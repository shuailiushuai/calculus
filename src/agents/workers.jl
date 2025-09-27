"""
Worker agents implementation for the K+S labor-augmented model.

Workers have reservation wages, employment contracts, memory of past wages,
and can become discouraged. They search for jobs, negotiate wages, and pay taxes.
"""

using Agents
using Distributions
using Statistics

"""
Worker agent type with all necessary attributes for labor market dynamics.
"""
@agent Worker GridAgent{2} begin
    # Employment status
    employed::Bool
    employer_id::Union{Int, Nothing}  # ID of employing firm
    wage::Float64
    
    # Reservation wage dynamics
    reservation_wage::Float64
    wage_memory::Vector{Float64}      # Memory of past wages offered
    memory_pointer::Int               # Circular buffer pointer
    
    # Employment contract details
    contract_start_period::Int        # When current contract started
    contract_duration::Int            # Length of contract (Tc)
    employment_duration::Int          # How long employed at current firm (Te)
    
    # Worker characteristics
    skill_level::Float64             # Worker productivity
    age::Int                        # Worker age
    discouraged::Bool               # Whether worker is discouraged from searching
    discouragement_periods::Int     # How long worker has been discouraged
    
    # Search and application behavior
    applications_sent::Int          # Number of applications this period
    job_offers_received::Vector{Tuple{Int, Float64}}  # (firm_id, wage) offers
    
    # Financial variables
    savings::Float64               # Worker savings
    consumption_budget::Float64    # Budget for consumption
    taxes_paid::Float64           # Taxes paid this period
    unemployment_benefits::Float64 # Benefits received if unemployed
    
    # Bonus for sector 2 workers
    bonus_rate::Float64           # Bonus rate if employed in sector 2
    bonus_received::Float64       # Actual bonus received
end

"""
    initialize_workers!(model::KSModel)

Initialize all worker agents with appropriate starting conditions.
"""
function initialize_workers!(model::KSModel)
    for i in 1:model.params.n_workers
        pos = (rand(1:100), rand(1:100))
        
        # Initialize wage memory with random values around initial wage
        initial_wage = 1.0 + 0.2 * randn()
        wage_memory = fill(initial_wage, model.params.worker_memory_length)
        
        worker = Worker(
            i,                                    # id
            pos,                                  # pos
            false,                               # employed
            nothing,                             # employer_id  
            0.0,                                # wage
            initial_wage * 0.9,                 # reservation_wage (slightly below initial)
            wage_memory,                        # wage_memory
            1,                                  # memory_pointer
            0,                                  # contract_start_period
            0,                                  # contract_duration
            0,                                  # employment_duration
            0.8 + 0.4 * rand(),                # skill_level
            rand(18:65),                       # age
            false,                             # discouraged
            0,                                 # discouragement_periods
            0,                                 # applications_sent
            Tuple{Int, Float64}[],             # job_offers_received
            1000.0 + 500.0 * rand(),          # savings
            0.0,                               # consumption_budget
            0.0,                               # taxes_paid
            0.0,                               # unemployment_benefits
            0.0,                               # bonus_rate
            0.0                                # bonus_received
        )
        
        add_agent!(worker, model.model)
    end
end

"""
    update_reservation_wage!(worker::Worker, model::KSModel)

Update worker's reservation wage based on satisficing behavior with memory.
Uses adaptive expectations based on wage offers received and employment status.
"""
function update_reservation_wage!(worker::Worker, model::KSModel)
    if worker.discouraged
        # Discouraged workers lower reservation wage more aggressively
        worker.reservation_wage *= (1.0 - 2.0 * model.params.reservation_wage_adaptation)
        return
    end
    
    # Calculate satisficing wage from memory
    satisficing_wage = calculate_satisficing_wage(worker, model)
    
    if worker.employed
        # Employed workers slowly adjust reservation wage upward
        target_wage = max(worker.wage, satisficing_wage)
        worker.reservation_wage = worker.reservation_wage + 
            model.params.reservation_wage_adaptation * (target_wage - worker.reservation_wage)
    else
        # Unemployed workers adjust based on job market success
        if length(worker.job_offers_received) > 0
            # Received offers - can be more selective
            best_offer = maximum([offer[2] for offer in worker.job_offers_received])
            worker.reservation_wage = worker.reservation_wage + 
                0.5 * model.params.reservation_wage_adaptation * (best_offer - worker.reservation_wage)
        else
            # No offers - lower expectations
            worker.reservation_wage = worker.reservation_wage - 
                model.params.reservation_wage_adaptation * (worker.reservation_wage - satisficing_wage)
        end
    end
    
    # Ensure reservation wage doesn't go below unemployment benefits
    min_wage = model.params.unemployment_benefit_rate * satisficing_wage
    worker.reservation_wage = max(worker.reservation_wage, min_wage)
end

"""
    calculate_satisficing_wage(worker::Worker, model::KSModel) -> Float64

Calculate the satisficing wage based on worker's memory of past wage offers.
Uses a weighted average with more recent offers having higher weight.
"""
function calculate_satisficing_wage(worker::Worker, model::KSModel)
    if isempty(worker.wage_memory) || all(w -> w <= 0, worker.wage_memory)
        return 1.0  # Default wage if no memory
    end
    
    # Use exponential weights for more recent memories
    weights = [exp(-0.1 * i) for i in 0:(length(worker.wage_memory)-1)]
    
    # Calculate weighted average
    total_weight = sum(weights)
    if total_weight > 0
        return sum(worker.wage_memory .* weights) / total_weight
    else
        return mean(worker.wage_memory)
    end
end

"""
    update_wage_memory!(worker::Worker, wage_offer::Float64)

Update worker's memory of wage offers using a circular buffer.
"""
function update_wage_memory!(worker::Worker, wage_offer::Float64)
    worker.wage_memory[worker.memory_pointer] = wage_offer
    worker.memory_pointer = (worker.memory_pointer % length(worker.wage_memory)) + 1
end

"""
    check_employment_contract!(worker::Worker, model::KSModel)

Check and update employment contract status.
Handles contract expiration and employment duration tracking.
"""
function check_employment_contract!(worker::Worker, model::KSModel)
    if !worker.employed
        return
    end
    
    worker.employment_duration += 1
    
    # Check if contract has expired
    if worker.contract_duration > 0 && 
       (model.step_counter - worker.contract_start_period) >= worker.contract_duration
        # Contract expired - worker becomes unemployed
        worker.employed = false
        worker.employer_id = nothing
        worker.wage = 0.0
        worker.contract_start_period = 0
        worker.contract_duration = 0
        worker.employment_duration = 0
    end
end

"""
    update_discouragement!(worker::Worker, model::KSModel)

Update worker discouragement status based on job search success.
Workers become discouraged after prolonged unemployment without offers.
"""
function update_discouragement!(worker::Worker, model::KSModel)
    if worker.employed
        # Reset discouragement if employed
        worker.discouraged = false
        worker.discouragement_periods = 0
        return
    end
    
    # Check if worker should become discouraged
    if !worker.discouraged
        if length(worker.job_offers_received) == 0 && worker.applications_sent > 0
            worker.discouragement_periods += 1
            
            # Become discouraged after several periods without offers
            if worker.discouragement_periods >= 6
                worker.discouraged = true
                println("Worker $(worker.id) became discouraged after $(worker.discouragement_periods) periods")
            end
        else
            # Reset counter if received offers
            worker.discouragement_periods = 0
        end
    else
        # Already discouraged - check if should recover
        worker.discouragement_periods += 1
        
        # Random chance to recover from discouragement
        if rand() < 0.1  # 10% chance per period
            worker.discouraged = false
            worker.discouragement_periods = 0
            println("Worker $(worker.id) recovered from discouragement")
        end
    end
end

"""
    calculate_sector2_bonus!(worker::Worker, model::KSModel)

Calculate bonus for workers employed in sector 2 (consumption goods).
Bonus depends on firm performance and worker's employment duration.
"""
function calculate_sector2_bonus!(worker::Worker, model::KSModel)
    worker.bonus_received = 0.0
    
    if !worker.employed || worker.employer_id === nothing
        return
    end
    
    # Check if employed in sector 2
    employer = model.model[worker.employer_id]
    if !(employer isa Firm2)
        return
    end
    
    # Bonus calculation based on firm performance and employment duration
    base_bonus = worker.wage * worker.bonus_rate
    
    # Bonus increases with employment duration (loyalty bonus)
    duration_multiplier = min(1.0 + 0.05 * worker.employment_duration, 2.0)
    
    # Bonus depends on firm's profitability
    if hasfield(typeof(employer), :profits) && employer.profits > 0
        profit_multiplier = min(1.0 + 0.1 * (employer.profits / employer.revenue), 1.5)
    else
        profit_multiplier = 1.0
    end
    
    worker.bonus_received = base_bonus * duration_multiplier * profit_multiplier
end

"""
    calculate_worker_taxes!(worker::Worker, model::KSModel)

Calculate taxes owed by worker based on wage income and bonuses.
"""
function calculate_worker_taxes!(worker::Worker, model::KSModel)
    taxable_income = 0.0
    
    if worker.employed
        taxable_income += worker.wage
        taxable_income += worker.bonus_received
    end
    
    worker.taxes_paid = taxable_income * model.params.tax_rate_workers
end

"""
    calculate_unemployment_benefits!(worker::Worker, model::KSModel)

Calculate unemployment benefits for unemployed workers.
"""
function calculate_unemployment_benefits!(worker::Worker, model::KSModel)
    worker.unemployment_benefits = 0.0
    
    if !worker.employed && !worker.discouraged
        # Benefits based on previous wage or satisficing wage
        reference_wage = calculate_satisficing_wage(worker, model)
        worker.unemployment_benefits = reference_wage * model.params.unemployment_benefit_rate
    end
end

"""
    worker_consumption_budget!(worker::Worker, model::KSModel)

Calculate worker's consumption budget based on income, savings, and taxes.
"""
function worker_consumption_budget!(worker::Worker, model::KSModel)
    # Income this period
    period_income = 0.0
    
    if worker.employed
        period_income += worker.wage + worker.bonus_received - worker.taxes_paid
    else
        period_income += worker.unemployment_benefits
    end
    
    # Update savings
    savings_rate = 0.1  # Base savings rate
    if period_income > 0
        worker.savings += period_income * savings_rate
        worker.consumption_budget = period_income * (1.0 - savings_rate)
    else
        # Dis-save if no income
        dissaving_amount = min(worker.savings * 0.1, 100.0)
        worker.savings -= dissaving_amount
        worker.consumption_budget = dissaving_amount
    end
    
    # Ensure non-negative values
    worker.savings = max(worker.savings, 0.0)
    worker.consumption_budget = max(worker.consumption_budget, 0.0)
end

"""
    step_worker!(worker::Worker, model::KSModel)

Main step function for worker agents. Coordinates all worker activities.
"""
function step_worker!(worker::Worker, model::KSModel)
    # Clear previous period data
    worker.applications_sent = 0
    empty!(worker.job_offers_received)
    
    # Update employment contract status
    check_employment_contract!(worker, model)
    
    # Update reservation wage
    update_reservation_wage!(worker, model)
    
    # Update discouragement status
    update_discouragement!(worker, model)
    
    # Calculate bonuses for sector 2 workers
    calculate_sector2_bonus!(worker, model)
    
    # Calculate taxes
    calculate_worker_taxes!(worker, model)
    
    # Calculate unemployment benefits
    calculate_unemployment_benefits!(worker, model)
    
    # Calculate consumption budget
    worker_consumption_budget!(worker, model)
end