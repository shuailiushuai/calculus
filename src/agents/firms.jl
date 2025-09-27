"""
Firm agents implementation for the K+S labor-augmented model.

Includes both Sector 1 (capital goods) and Sector 2 (consumption goods) firms
with complete hiring/firing mechanisms, production planning, and market interactions.
"""

using Agents
using Distributions
using Statistics

"""
Sector 1 firm (Capital goods producer) with R&D and innovation capabilities.
"""
@agent Firm1 GridAgent{2} begin
    # Basic firm characteristics
    age::Int
    market_share::Float64
    
    # Production and technology
    productivity::Float64
    production_capacity::Float64
    actual_production::Float64
    inventory::Float64
    
    # Innovation and R&D
    rd_expenditure::Float64
    rd_intensity::Float64
    innovation_success::Bool
    patent_portfolio::Vector{Int}  # Patents owned (expiration periods)
    
    # Employment and labor
    employees::Vector{Int}         # Worker IDs
    labor_demand::Int             # Desired number of workers
    labor_cost::Float64
    avg_wage::Float64
    hiring_queue::Vector{Tuple{Int, Float64}}  # (worker_id, offered_wage)
    firing_candidates::Vector{Int} # Workers to potentially fire
    
    # Financial variables
    revenue::Float64
    costs::Float64
    profits::Float64
    cash::Float64
    debt::Float64
    credit_demand::Float64
    
    # Market and pricing
    price::Float64
    customers::Vector{Int}        # Sector 2 firms that buy from this firm
    orders_received::Float64
    delivery_delay::Int
    
    # Investment
    desired_investment::Float64
    actual_investment::Float64
end

"""
Sector 2 firm (Consumption goods producer) with inventory management.
"""
@agent Firm2 GridAgent{2} begin
    # Basic firm characteristics  
    age::Int
    market_share::Float64
    
    # Production
    productivity::Float64
    production_capacity::Float64
    actual_production::Float64
    inventory::Float64
    desired_inventory::Float64
    
    # Employment and labor
    employees::Vector{Int}         # Worker IDs
    labor_demand::Int             # Desired number of workers
    labor_cost::Float64
    avg_wage::Float64
    hiring_queue::Vector{Tuple{Int, Float64}}  # (worker_id, offered_wage)
    firing_candidates::Vector{Int} # Workers to potentially fire
    
    # Financial variables
    revenue::Float64
    costs::Float64
    profits::Float64
    cash::Float64
    debt::Float64
    credit_demand::Float64
    
    # Market and pricing
    price::Float64
    price_sensitivity::Float64
    demand_received::Float64
    unfilled_demand::Float64
    
    # Capital and suppliers
    capital_stock::Float64
    capital_age_distribution::Vector{Int}
    supplier_id::Union{Int, Nothing}  # Sector 1 firm supplier
    capital_orders::Float64
    
    # Competition and market position
    competitiveness::Float64
    
    # Worker bonuses
    bonus_budget::Float64
    bonus_rate::Float64
end

"""
    initialize_firms!(model::KSModel)

Initialize all firm agents in both sectors with appropriate starting conditions.
"""
function initialize_firms!(model::KSModel)
    # Initialize Sector 1 firms (Capital goods)
    for i in 1:model.params.n_firms_sector1
        pos = (rand(1:100), rand(1:100))
        
        firm1 = Firm1(
            model.params.n_workers + i,           # id (after workers)
            pos,                                  # pos
            rand(1:10),                          # age
            1.0 / model.params.n_firms_sector1,  # market_share
            0.8 + 0.4 * rand(),                  # productivity
            1000.0 + 500.0 * rand(),             # production_capacity
            0.0,                                 # actual_production
            100.0 + 50.0 * rand(),               # inventory
            model.params.sector1_rd_intensity * 1000.0, # rd_expenditure
            model.params.sector1_rd_intensity,    # rd_intensity
            false,                               # innovation_success
            Int[],                               # patent_portfolio
            Int[],                               # employees
            20 + rand(1:30),                     # labor_demand
            0.0,                                 # labor_cost
            1.0 + 0.2 * randn(),                 # avg_wage
            Tuple{Int, Float64}[],               # hiring_queue
            Int[],                               # firing_candidates
            0.0,                                 # revenue
            0.0,                                 # costs
            0.0,                                 # profits
            10000.0 + 5000.0 * rand(),           # cash
            0.0,                                 # debt
            0.0,                                 # credit_demand
            10.0 + 2.0 * rand(),                 # price
            Int[],                               # customers
            0.0,                                 # orders_received
            rand(1:3),                           # delivery_delay
            0.0,                                 # desired_investment
            0.0                                  # actual_investment
        )
        
        add_agent!(firm1, model.model)
    end
    
    # Initialize Sector 2 firms (Consumption goods)
    for i in 1:model.params.n_firms_sector2
        pos = (rand(1:100), rand(1:100))
        
        firm2 = Firm2(
            model.params.n_workers + model.params.n_firms_sector1 + i,  # id
            pos,                                  # pos
            rand(1:10),                          # age
            1.0 / model.params.n_firms_sector2,  # market_share
            0.8 + 0.4 * rand(),                  # productivity
            1000.0 + 500.0 * rand(),             # production_capacity
            0.0,                                 # actual_production
            100.0 + 50.0 * rand(),               # inventory
            model.params.sector2_desired_inventories * 1000.0, # desired_inventory
            Int[],                               # employees
            30 + rand(1:50),                     # labor_demand
            0.0,                                 # labor_cost
            1.0 + 0.2 * randn(),                 # avg_wage
            Tuple{Int, Float64}[],               # hiring_queue
            Int[],                               # firing_candidates
            0.0,                                 # revenue
            0.0,                                 # costs
            0.0,                                 # profits
            10000.0 + 5000.0 * rand(),           # cash
            0.0,                                 # debt
            0.0,                                 # credit_demand
            5.0 + 1.0 * rand(),                  # price
            model.params.sector2_price_sensitivity, # price_sensitivity
            0.0,                                 # demand_received
            0.0,                                 # unfilled_demand
            5000.0 + 2000.0 * rand(),            # capital_stock
            rand(1:20, 10),                      # capital_age_distribution
            nothing,                             # supplier_id
            0.0,                                 # capital_orders
            1.0 + 0.2 * rand(),                  # competitiveness
            1000.0 + 500.0 * rand(),             # bonus_budget
            0.05 + 0.05 * rand()                 # bonus_rate
        )
        
        add_agent!(firm2, model.model)
    end
end

"""
    calculate_labor_demand!(firm::Union{Firm1, Firm2}, model::KSModel)

Calculate the firm's labor demand based on production plans and productivity.
"""
function calculate_labor_demand!(firm::Union{Firm1, Firm2}, model::KSModel)
    if firm isa Firm1
        # Sector 1: Labor demand based on orders and R&D needs
        base_demand = max(1, round(Int, firm.orders_received / firm.productivity))
        rd_demand = max(1, round(Int, firm.rd_expenditure / (firm.avg_wage * 12)))
        firm.labor_demand = base_demand + rd_demand
    else
        # Sector 2: Labor demand based on production plans
        desired_production = firm.inventory < firm.desired_inventory ? 
                           firm.desired_inventory - firm.inventory + firm.demand_received :
                           firm.demand_received
        firm.labor_demand = max(1, round(Int, desired_production / firm.productivity))
    end
end

"""
    process_hiring_queue!(firm::Union{Firm1, Firm2}, model::KSModel)

Process the firm's hiring queue by ranking applications and making offers.
"""
function process_hiring_queue!(firm::Union{Firm1, Firm2}, model::KSModel)
    if isempty(firm.hiring_queue)
        return
    end
    
    # Calculate how many workers needed
    positions_available = max(0, firm.labor_demand - length(firm.employees))
    
    if positions_available <= 0
        empty!(firm.hiring_queue)  # Clear queue if no positions
        return
    end
    
    # Rank applications by worker skill and wage demands
    ranked_applications = sort(firm.hiring_queue, by = app -> begin
        worker_id, requested_wage = app
        worker = model.model[worker_id]
        
        # Ranking score: higher skill, lower wage demand is better
        skill_score = worker.skill_level
        wage_score = 1.0 / (1.0 + requested_wage / firm.avg_wage)  # Inverse wage preference
        
        -(skill_score * 0.7 + wage_score * 0.3)  # Negative for descending sort
    end)
    
    # Make offers to top candidates
    hired_count = 0
    for (worker_id, requested_wage) in ranked_applications
        if hired_count >= positions_available
            break
        end
        
        worker = model.model[worker_id]
        
        # Check if worker is still available and wage is acceptable
        if !worker.employed && requested_wage <= firm.avg_wage * 1.2
            # Make job offer
            offered_wage = min(requested_wage * 1.05, firm.avg_wage * 1.1)  # Slight premium
            
            # Add to worker's offers
            push!(worker.job_offers_received, (firm.id, offered_wage))
            
            hired_count += 1
        end
    end
    
    # Clear hiring queue
    empty!(firm.hiring_queue)
end

"""
    execute_hiring_decisions!(firm::Union{Firm1, Firm2}, model::KSModel)

Execute final hiring decisions based on worker acceptances.
"""
function execute_hiring_decisions!(firm::Union{Firm1, Firm2}, model::KSModel)
    positions_available = max(0, firm.labor_demand - length(firm.employees))
    hired_count = 0
    
    # Check which workers accepted offers
    for worker in values(model.model.agents)
        if worker isa Worker && !worker.employed && hired_count < positions_available
            # Check if worker has offer from this firm
            firm_offers = filter(offer -> offer[1] == firm.id, worker.job_offers_received)
            
            if !isempty(firm_offers)
                offered_wage = firm_offers[1][2]
                
                # Worker accepts if wage meets reservation wage
                if offered_wage >= worker.reservation_wage
                    # Hire worker
                    worker.employed = true
                    worker.employer_id = firm.id
                    worker.wage = offered_wage
                    worker.contract_start_period = model.step_counter
                    worker.contract_duration = rand(6:24)  # Contract length
                    worker.employment_duration = 0
                    
                    # Set bonus rate for sector 2 workers
                    if firm isa Firm2
                        worker.bonus_rate = firm.bonus_rate
                    end
                    
                    # Add to firm's employee list
                    push!(firm.employees, worker.id)
                    
                    # Update wage memory
                    update_wage_memory!(worker, offered_wage)
                    
                    hired_count += 1
                end
            end
        end
    end
    
    # Update firm's average wage
    if !isempty(firm.employees)
        total_wage = sum(model.model[worker_id].wage for worker_id in firm.employees)
        firm.avg_wage = total_wage / length(firm.employees)
    end
end

"""
    determine_firing_candidates!(firm::Union{Firm1, Firm2}, model::KSModel, firing_rule::Int)

Determine which workers to fire based on the specified firing rule (0-6).
"""
function determine_firing_candidates!(firm::Union{Firm1, Firm2}, model::KSModel, firing_rule::Int)
    empty!(firm.firing_candidates)
    
    # Calculate excess workers
    excess_workers = length(firm.employees) - firm.labor_demand
    if excess_workers <= 0
        return
    end
    
    # Get worker information for ranking
    worker_info = []
    for worker_id in firm.employees
        worker = model.model[worker_id]
        push!(worker_info, (
            worker_id,
            worker.skill_level,
            worker.employment_duration,
            worker.wage,
            worker.age,
            worker.contract_start_period
        ))
    end
    
    if isempty(worker_info)
        return
    end
    
    # Apply firing rule
    if firing_rule == 0
        # Random firing
        shuffled_workers = shuffle(worker_info)
        firm.firing_candidates = [w[1] for w in shuffled_workers[1:min(excess_workers, length(shuffled_workers))]]
        
    elseif firing_rule == 1
        # Work-sharing: reduce hours instead of firing if excess is small
        if excess_workers <= ceil(length(firm.employees) * model.params.work_sharing_threshold)
            # Implement work-sharing (reduce wages proportionally)
            for worker_id in firm.employees
                worker = model.model[worker_id]
                work_share_reduction = excess_workers / length(firm.employees)
                worker.wage *= (1.0 - work_share_reduction)
            end
            return  # No actual firing
        else
            # If excess too large, fall back to LIFO
            sorted_workers = sort(worker_info, by = w -> w[3])  # Sort by employment duration
            firm.firing_candidates = [w[1] for w in sorted_workers[1:min(excess_workers, length(sorted_workers))]]
        end
        
    elseif firing_rule == 2
        # LIFO (Last In, First Out)
        sorted_workers = sort(worker_info, by = w -> w[3])  # Sort by employment duration
        firm.firing_candidates = [w[1] for w in sorted_workers[1:min(excess_workers, length(sorted_workers))]]
        
    elseif firing_rule == 3
        # FIFO (First In, First Out) 
        sorted_workers = sort(worker_info, by = w -> -w[3])  # Sort by employment duration (descending)
        firm.firing_candidates = [w[1] for w in sorted_workers[1:min(excess_workers, length(sorted_workers))]]
        
    elseif firing_rule == 4
        # Fire lowest skill workers first
        sorted_workers = sort(worker_info, by = w -> w[2])  # Sort by skill level
        firm.firing_candidates = [w[1] for w in sorted_workers[1:min(excess_workers, length(sorted_workers))]]
        
    elseif firing_rule == 5
        # Fire highest wage workers first
        sorted_workers = sort(worker_info, by = w -> -w[4])  # Sort by wage (descending)
        firm.firing_candidates = [w[1] for w in sorted_workers[1:min(excess_workers, length(sorted_workers))]]
        
    elseif firing_rule == 6
        # Fire oldest workers first
        sorted_workers = sort(worker_info, by = w -> -w[5])  # Sort by age (descending)
        firm.firing_candidates = [w[1] for w in sorted_workers[1:min(excess_workers, length(sorted_workers))]]
    end
end

"""
    execute_firing_decisions!(firm::Union{Firm1, Firm2}, model::KSModel)

Execute firing decisions while respecting contract protection periods.
"""
function execute_firing_decisions!(firm::Union{Firm1, Firm2}, model::KSModel)
    actually_fired = Int[]
    
    for worker_id in firm.firing_candidates
        worker = model.model[worker_id]
        
        # Check contract protection
        contract_age = model.step_counter - worker.contract_start_period
        if contract_age < model.params.contract_protection_periods && worker.contract_duration > 0
            continue  # Worker protected by contract
        end
        
        # Fire worker
        worker.employed = false
        worker.employer_id = nothing
        worker.wage = 0.0
        worker.contract_start_period = 0
        worker.contract_duration = 0
        worker.employment_duration = 0
        worker.bonus_rate = 0.0
        
        push!(actually_fired, worker_id)
    end
    
    # Remove fired workers from employee list
    firm.employees = filter(id -> !(id in actually_fired), firm.employees)
    
    # Update average wage
    if !isempty(firm.employees)
        total_wage = sum(model.model[worker_id].wage for worker_id in firm.employees)
        firm.avg_wage = total_wage / length(firm.employees)
        firm.labor_cost = total_wage
    else
        firm.avg_wage = 1.0  # Default wage
        firm.labor_cost = 0.0
    end
    
    empty!(firm.firing_candidates)
end

"""
    step_firm1!(firm::Firm1, model::KSModel)

Main step function for Sector 1 (capital goods) firms.
"""
function step_firm1!(firm::Firm1, model::KSModel)
    firm.age += 1
    
    # Calculate labor demand
    calculate_labor_demand!(firm, model)
    
    # Determine firing if excess workers
    if length(firm.employees) > firm.labor_demand
        firing_rule = rand(model.params.firing_rules)  # Random firing rule selection
        determine_firing_candidates!(firm, model, firing_rule)
        execute_firing_decisions!(firm, model)
    end
    
    # R&D and innovation activities
    conduct_rd_activities!(firm, model)
    
    # Update patent portfolio (patents expire)
    firm.patent_portfolio = filter(p -> p > 0, firm.patent_portfolio .- 1)
end

"""
    step_firm2!(firm::Firm2, model::KSModel)

Main step function for Sector 2 (consumption goods) firms.
"""
function step_firm2!(firm::Firm2, model::KSModel)
    firm.age += 1
    
    # Update desired inventory based on demand expectations
    firm.desired_inventory = firm.demand_received * model.params.sector2_desired_inventories
    
    # Calculate labor demand
    calculate_labor_demand!(firm, model)
    
    # Determine firing if excess workers
    if length(firm.employees) > firm.labor_demand
        firing_rule = rand(model.params.firing_rules)  # Random firing rule selection
        determine_firing_candidates!(firm, model, firing_rule)
        execute_firing_decisions!(firm, model)
    end
    
    # Update competitiveness based on price and quality
    update_competitiveness!(firm, model)
    
    # Plan capital investment
    plan_capital_investment!(firm, model)
end

"""
    conduct_rd_activities!(firm::Firm1, model::KSModel)

Conduct R&D activities for Sector 1 firms including innovation and imitation.
"""
function conduct_rd_activities!(firm::Firm1, model::KSModel)
    # Innovation attempt
    if rand() < model.params.sector1_innovation_prob
        if rand() < firm.rd_intensity * 10  # Higher R&D intensity improves success
            firm.innovation_success = true
            firm.productivity *= (1.0 + 0.1 * randn())  # Productivity improvement
            push!(firm.patent_portfolio, model.params.sector1_patent_protection)
        end
    end
    
    # Imitation attempt
    if rand() < model.params.sector1_imitation_prob && !firm.innovation_success
        # Find best practice in sector
        best_productivity = maximum(f.productivity for f in values(model.model.agents) if f isa Firm1)
        if best_productivity > firm.productivity
            improvement = (best_productivity - firm.productivity) * 0.1
            firm.productivity += improvement
        end
    end
    
    firm.innovation_success = false  # Reset for next period
end

"""
    update_competitiveness!(firm::Firm2, model::KSModel)

Update competitiveness indicator for Sector 2 firms.
"""
function update_competitiveness!(firm::Firm2, model::KSModel)
    # Competitiveness based on price, delivery, and quality
    price_factor = 1.0 / (1.0 + firm.price)
    delivery_factor = 1.0 / (1.0 + firm.inventory <= 0 ? 10.0 : 1.0)  # Penalty for stockouts
    quality_factor = firm.productivity / maximum(f.productivity for f in values(model.model.agents) if f isa Firm2)
    
    firm.competitiveness = price_factor * 0.4 + delivery_factor * 0.3 + quality_factor * 0.3
end

"""
    plan_capital_investment!(firm::Firm2, model::KSModel)

Plan capital investment for Sector 2 firms based on capacity needs.
"""
function plan_capital_investment!(firm::Firm2, model::KSModel)
    # Investment needed if demand exceeds capacity
    if firm.demand_received > firm.production_capacity * 0.9
        firm.desired_investment = (firm.demand_received - firm.production_capacity) * 2.0
    else
        firm.desired_investment = firm.capital_stock * 0.05  # Replacement investment
    end
    
    # Plan capital orders to Sector 1 firms
    if firm.desired_investment > 0
        firm.capital_orders = firm.desired_investment
    end
end