"""
Government agent implementation for the K+S labor-augmented model.

The government collects taxes, pays unemployment benefits, provides training programs,
manages public debt, and implements fiscal rules.
"""

using Agents
using Statistics

"""
Government agent with comprehensive fiscal operations.
"""
@agent Government GridAgent{2} begin
    # Government identification
    age::Int
    
    # Fiscal revenues
    tax_revenue_workers::Float64      # Income taxes from workers
    tax_revenue_firms::Float64        # Corporate taxes from firms
    total_tax_revenue::Float64
    other_revenues::Float64           # Other government revenues
    
    # Government expenditures
    unemployment_benefits_paid::Float64
    training_program_costs::Float64
    public_investment::Float64
    government_consumption::Float64
    interest_payments::Float64
    other_expenditures::Float64
    total_expenditures::Float64
    
    # Fiscal balance and debt
    fiscal_balance::Float64           # Surplus/deficit this period
    cumulative_debt::Float64          # Total government debt
    debt_service_costs::Float64       # Interest on debt
    debt_gdp_ratio::Float64           # Debt as % of GDP
    
    # Fiscal rules and targets
    debt_target::Float64              # Target debt-to-GDP ratio
    fiscal_rule_active::Bool          # Whether fiscal rules are binding
    automatic_stabilizers::Bool       # Whether automatic stabilizers are active
    
    # Unemployment benefits system
    benefit_recipients::Set{Int}      # Worker IDs receiving benefits
    benefit_duration_limits::Dict{Int, Int}  # Worker ID -> periods of benefit receipt
    max_benefit_duration::Int         # Maximum benefit duration
    benefit_replacement_rate::Float64 # Unemployment benefit replacement rate
    
    # Training programs
    training_participants::Set{Int}   # Worker IDs in training programs
    training_program_capacity::Int    # Maximum participants per period
    training_effectiveness::Float64   # Probability training improves skill
    training_cost_per_participant::Float64
    
    # Public investment and infrastructure
    infrastructure_stock::Float64     # Government infrastructure capital
    infrastructure_depreciation::Float64
    productivity_spillovers::Float64  # Infrastructure impact on productivity
    
    # Counter-cyclical policies
    gdp_trend::Float64               # Estimated trend GDP
    output_gap::Float64              # Current output gap
    cyclical_spending_multiplier::Float64
    
    # Bank bailout and financial stability
    bank_bailout_fund::Float64       # Available funds for bank bailouts
    systemic_risk_threshold::Float64 # Threshold for intervention
    bailout_costs_this_period::Float64
    
    # Economic statistics (for policy decisions)
    unemployment_rate::Float64
    inflation_rate::Float64
    gdp_growth_rate::Float64
    
    # Policy parameters
    tax_progressivity::Float64       # Progressive tax parameter
    social_safety_net_generosity::Float64
end

"""
    initialize_government!(model::KSModel)

Initialize the government agent with appropriate starting fiscal position.
"""
function initialize_government!(model::KSModel)
    pos = (50, 50)  # Center of the grid
    total_agent_offset = model.params.n_workers + model.params.n_firms_sector1 + 
                        model.params.n_firms_sector2 + model.params.n_banks
    
    # Estimate initial GDP for debt calculations
    estimated_gdp = model.params.n_workers * 1.2 * 12 +  # Worker income
                   (model.params.n_firms_sector1 + model.params.n_firms_sector2) * 5000  # Firm output
    
    government = Government(
        total_agent_offset + 1,              # id
        pos,                                 # pos
        0,                                   # age
        0.0,                                # tax_revenue_workers
        0.0,                                # tax_revenue_firms
        0.0,                                # total_tax_revenue
        0.0,                                # other_revenues
        0.0,                                # unemployment_benefits_paid
        0.0,                                # training_program_costs
        0.0,                                # public_investment
        estimated_gdp * model.params.government_spending_gdp_ratio, # government_consumption
        0.0,                                # interest_payments
        0.0,                                # other_expenditures
        0.0,                                # total_expenditures
        0.0,                                # fiscal_balance
        estimated_gdp * model.params.debt_gdp_target, # cumulative_debt
        0.0,                                # debt_service_costs
        model.params.debt_gdp_target,       # debt_gdp_ratio
        model.params.debt_gdp_target,       # debt_target
        true,                               # fiscal_rule_active
        true,                               # automatic_stabilizers
        Set{Int}(),                         # benefit_recipients
        Dict{Int, Int}(),                   # benefit_duration_limits
        26,                                 # max_benefit_duration (6 months)
        model.params.unemployment_benefit_rate, # benefit_replacement_rate
        Set{Int}(),                         # training_participants
        100,                                # training_program_capacity
        0.3,                                # training_effectiveness
        500.0,                              # training_cost_per_participant
        50000.0,                            # infrastructure_stock
        0.05,                               # infrastructure_depreciation
        0.02,                               # productivity_spillovers
        estimated_gdp,                      # gdp_trend
        0.0,                                # output_gap
        1.5,                                # cyclical_spending_multiplier
        10000.0,                            # bank_bailout_fund
        0.3,                                # systemic_risk_threshold
        0.0,                                # bailout_costs_this_period
        0.0,                                # unemployment_rate
        0.0,                                # inflation_rate
        0.0,                                # gdp_growth_rate
        0.1,                                # tax_progressivity
        1.0                                 # social_safety_net_generosity
    )
    
    add_agent!(government, model.model)
end

"""
    collect_worker_taxes!(government::Government, model::KSModel)

Collect income taxes from employed workers.
"""
function collect_worker_taxes!(government::Government, model::KSModel)
    government.tax_revenue_workers = 0.0
    
    for worker in values(model.model.agents)
        if worker isa Worker && worker.employed
            # Progressive taxation
            taxable_income = worker.wage + worker.bonus_received
            
            if taxable_income > 0
                # Simple progressive tax with flat rate above threshold
                base_rate = model.params.tax_rate_workers
                progressive_rate = base_rate * (1.0 + government.tax_progressivity * max(0, taxable_income - 1.5))
                
                tax_owed = taxable_income * min(progressive_rate, 0.5)  # Max 50% tax rate
                worker.taxes_paid = tax_owed
                government.tax_revenue_workers += tax_owed
                
                # Deduct taxes from worker's cash
                if hasfield(typeof(worker), :savings)
                    worker.savings = max(0.0, worker.savings - tax_owed)
                end
            end
        end
    end
end

"""
    collect_firm_taxes!(government::Government, model::KSModel)

Collect corporate taxes from profitable firms.
"""
function collect_firm_taxes!(government::Government, model::KSModel)
    government.tax_revenue_firms = 0.0
    
    for firm in values(model.model.agents)
        if (firm isa Firm1 || firm isa Firm2) && firm.profits > 0
            # Corporate tax on profits
            corporate_tax = firm.profits * model.params.tax_rate_firms
            government.tax_revenue_firms += corporate_tax
            
            # Deduct taxes from firm's cash
            firm.cash = max(0.0, firm.cash - corporate_tax)
        end
    end
end

"""
    determine_benefit_eligibility!(government::Government, worker::Worker, model::KSModel) -> Bool

Determine if an unemployed worker is eligible for unemployment benefits.
"""
function determine_benefit_eligibility!(government::Government, worker::Worker, model::KSModel)
    # Must be unemployed and not discouraged
    if worker.employed || worker.discouraged
        return false
    end
    
    # Check if already receiving benefits and duration limits
    if worker.id in government.benefit_recipients
        duration = get(government.benefit_duration_limits, worker.id, 0)
        if duration >= government.max_benefit_duration
            # Remove from benefits due to duration limit
            delete!(government.benefit_recipients, worker.id)
            delete!(government.benefit_duration_limits, worker.id)
            return false
        end
    end
    
    # Check work history - must have been employed recently
    if worker.employment_duration == 0 && length(worker.wage_memory) == 0
        return false  # No work history
    end
    
    return true
end

"""
    pay_unemployment_benefits!(government::Government, model::KSModel)

Calculate and pay unemployment benefits to eligible workers.
"""
function pay_unemployment_benefits!(government::Government, model::KSModel)
    government.unemployment_benefits_paid = 0.0
    new_recipients = Set{Int}()
    
    for worker in values(model.model.agents)
        if worker isa Worker
            if determine_benefit_eligibility!(government, worker, model)
                # Calculate benefit amount
                reference_wage = calculate_satisficing_wage(worker, model)
                benefit_amount = reference_wage * government.benefit_replacement_rate
                benefit_amount *= government.social_safety_net_generosity  # Policy parameter
                
                # Pay benefit
                worker.unemployment_benefits = benefit_amount
                worker.savings += benefit_amount
                government.unemployment_benefits_paid += benefit_amount
                
                # Update tracking
                push!(new_recipients, worker.id)
                government.benefit_duration_limits[worker.id] = 
                    get(government.benefit_duration_limits, worker.id, 0) + 1
            else
                worker.unemployment_benefits = 0.0
            end
        end
    end
    
    government.benefit_recipients = new_recipients
end

"""
    operate_training_programs!(government::Government, model::KSModel)

Operate government training programs for unemployed workers.
"""
function operate_training_programs!(government::Government, model::KSModel)
    government.training_program_costs = 0.0
    empty!(government.training_participants)
    
    # Find eligible workers (unemployed, not in training)
    eligible_workers = []
    for worker in values(model.model.agents)
        if worker isa Worker && !worker.employed && !worker.discouraged
            push!(eligible_workers, worker)
        end
    end
    
    # Select participants up to capacity
    participants = min(length(eligible_workers), government.training_program_capacity)
    if participants > 0
        selected_workers = sample(eligible_workers, participants, replace=false)
        
        for worker in selected_workers
            # Enroll in training
            push!(government.training_participants, worker.id)
            government.training_program_costs += government.training_cost_per_participant
            
            # Training effect - chance to improve skill
            if rand() < government.training_effectiveness
                worker.skill_level = min(1.0, worker.skill_level + 0.1 * rand())
                
                # Also improves reservation wage expectation
                worker.reservation_wage *= 1.05
            end
            
            # Training participants get reduced benefits
            worker.unemployment_benefits *= 0.8
        end
    end
end

"""
    manage_public_investment!(government::Government, model::KSModel)

Manage government investment in infrastructure and its productivity effects.
"""
function manage_public_investment!(government::Government, model::KSModel)
    # Determine investment based on fiscal rules and economic conditions
    if government.fiscal_rule_active && government.debt_gdp_ratio > government.debt_target
        # Constrain investment due to high debt
        government.public_investment = government.infrastructure_stock * 0.03  # Maintenance only
    else
        # Counter-cyclical investment
        base_investment = government.infrastructure_stock * 0.05
        cyclical_adjustment = -government.output_gap * government.cyclical_spending_multiplier * 1000
        government.public_investment = max(0, base_investment + cyclical_adjustment)
    end
    
    # Update infrastructure stock
    depreciation = government.infrastructure_stock * government.infrastructure_depreciation
    government.infrastructure_stock += government.public_investment - depreciation
    
    # Apply productivity spillovers to firms
    if government.infrastructure_stock > 0
        spillover_effect = government.productivity_spillovers * 
                          (government.infrastructure_stock / 100000.0)  # Normalized
        
        for firm in values(model.model.agents)
            if firm isa Firm1 || firm isa Firm2
                firm.productivity *= (1.0 + spillover_effect / 12)  # Monthly effect
            end
        end
    end
end

"""
    calculate_debt_dynamics!(government::Government, model::KSModel, current_gdp::Float64)

Update government debt dynamics and debt service costs.
"""
function calculate_debt_dynamics!(government::Government, model::KSModel, current_gdp::Float64)
    # Calculate total revenues and expenditures
    government.total_tax_revenue = government.tax_revenue_workers + government.tax_revenue_firms
    
    government.total_expenditures = government.unemployment_benefits_paid +
                                   government.training_program_costs +
                                   government.public_investment +
                                   government.government_consumption +
                                   government.interest_payments +
                                   government.bailout_costs_this_period
    
    # Calculate fiscal balance
    government.fiscal_balance = government.total_tax_revenue + government.other_revenues - 
                               government.total_expenditures
    
    # Update debt
    government.cumulative_debt -= government.fiscal_balance  # Deficit increases debt
    government.cumulative_debt = max(0.0, government.cumulative_debt)
    
    # Calculate debt service costs
    average_interest_rate = model.params.interest_rate_loans + 0.01  # Government borrowing rate
    government.debt_service_costs = government.cumulative_debt * average_interest_rate / 12
    government.interest_payments = government.debt_service_costs
    
    # Update debt-to-GDP ratio
    if current_gdp > 0
        government.debt_gdp_ratio = government.cumulative_debt / current_gdp
    end
    
    # Update GDP trend (simple exponential smoothing)
    government.gdp_trend = 0.95 * government.gdp_trend + 0.05 * current_gdp
    government.output_gap = (current_gdp - government.gdp_trend) / government.gdp_trend
end

"""
    implement_fiscal_rules!(government::Government, model::KSModel)

Implement fiscal rules and automatic stabilizers.
"""
function implement_fiscal_rules!(government::Government, model::KSModel)
    # Check if fiscal rules should be activated
    if government.debt_gdp_ratio > government.debt_target * 1.1
        government.fiscal_rule_active = true
    elseif government.debt_gdp_ratio < government.debt_target * 0.9
        government.fiscal_rule_active = false
    end
    
    # Automatic stabilizers
    if government.automatic_stabilizers
        # Adjust spending based on unemployment rate
        if government.unemployment_rate > 0.08  # High unemployment
            government.social_safety_net_generosity = min(1.5, government.social_safety_net_generosity + 0.05)
            government.training_program_capacity = min(200, round(Int, government.training_program_capacity * 1.1))
        elseif government.unemployment_rate < 0.05  # Low unemployment
            government.social_safety_net_generosity = max(0.8, government.social_safety_net_generosity - 0.05)
            government.training_program_capacity = max(50, round(Int, government.training_program_capacity * 0.95))
        end
        
        # Adjust tax progressivity based on inequality (simplified)
        if government.output_gap < -0.05  # Recession
            government.tax_progressivity = max(0.05, government.tax_progressivity - 0.01)
        elseif government.output_gap > 0.05  # Boom
            government.tax_progressivity = min(0.2, government.tax_progressivity + 0.01)
        end
    end
end

"""
    monitor_systemic_risk!(government::Government, model::KSModel)

Monitor banking sector for systemic risk and prepare interventions.
"""
function monitor_systemic_risk!(government::Government, model::KSModel)
    government.bailout_costs_this_period = 0.0
    
    # Calculate banking sector health indicators
    total_bank_assets = 0.0
    undercapitalized_banks = 0
    total_capital_shortfall = 0.0
    
    banks = [agent for agent in values(model.model.agents) if agent isa Bank]
    
    if !isempty(banks)
        for bank in banks
            total_bank_assets += bank.bank_size
            
            if bank.capital_adequacy_ratio < bank.required_capital_ratio
                undercapitalized_banks += 1
                rwa = calculate_risk_weighted_assets(bank, model)
                shortfall = rwa * bank.required_capital_ratio - 
                           (bank.equity_capital + bank.retained_earnings)
                total_capital_shortfall += max(0, shortfall)
            end
        end
        
        # Check systemic risk threshold
        systemic_risk_ratio = undercapitalized_banks / length(banks)
        
        if systemic_risk_ratio > government.systemic_risk_threshold
            # Systemic crisis - implement broad bailout
            for bank in banks
                if bank.capital_adequacy_ratio < bank.required_capital_ratio
                    rwa = calculate_risk_weighted_assets(bank, model)
                    shortfall = rwa * bank.required_capital_ratio - 
                               (bank.equity_capital + bank.retained_earnings)
                    
                    if shortfall > 0
                        bailout_amount = shortfall * 1.2  # 120% of minimum required
                        bank.equity_capital += bailout_amount
                        government.bailout_costs_this_period += bailout_amount
                    end
                end
            end
            
            println("Systemic banking crisis: Government bailout costs: $(government.bailout_costs_this_period)")
        end
    end
    
    # Replenish bailout fund
    government.bank_bailout_fund += government.total_tax_revenue * 0.01  # 1% of tax revenue
end

"""
    step_government!(government::Government, model::KSModel)

Main step function for government operations.
"""
function step_government!(government::Government, model::KSModel)
    government.age += 1
    
    # Collect taxes
    collect_worker_taxes!(government, model)
    collect_firm_taxes!(government, model)
    
    # Pay unemployment benefits
    pay_unemployment_benefits!(government, model)
    
    # Operate training programs
    operate_training_programs!(government, model)
    
    # Manage public investment
    manage_public_investment!(government, model)
    
    # Monitor systemic risk and banking sector
    monitor_systemic_risk!(government, model)
    
    # Update fiscal position and debt dynamics
    current_gdp = estimate_current_gdp(model)
    calculate_debt_dynamics!(government, model, current_gdp)
    
    # Implement fiscal rules and automatic stabilizers
    implement_fiscal_rules!(government, model)
end

"""
    estimate_current_gdp(model::KSModel) -> Float64

Estimate current GDP for fiscal calculations (expenditure approach).
"""
function estimate_current_gdp(model::KSModel)
    consumption = 0.0
    investment = 0.0
    government_spending = 0.0
    
    # Consumption (worker spending)
    for worker in values(model.model.agents)
        if worker isa Worker
            consumption += worker.consumption_budget
        end
    end
    
    # Investment (firm investment)
    for firm in values(model.model.agents)
        if firm isa Firm1 || firm isa Firm2
            if hasfield(typeof(firm), :actual_investment)
                investment += firm.actual_investment
            end
        end
    end
    
    # Government spending
    for gov in values(model.model.agents)
        if gov isa Government
            government_spending = gov.total_expenditures
            break
        end
    end
    
    return consumption + investment + government_spending
end