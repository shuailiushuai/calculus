"""
Bank agents implementation for the K+S labor-augmented model.

Banks provide credit to firms, collect deposits from workers, and are subject
to capital adequacy requirements similar to Basel regulations.
"""

using Agents
using Distributions
using Statistics

"""
Bank agent with full balance sheet and regulatory compliance.
"""
@agent Bank GridAgent{2} begin
    # Bank identification and characteristics
    age::Int
    bank_size::Float64                # Total assets
    
    # Balance sheet - Assets
    cash_reserves::Float64           # Cash and central bank reserves
    loans_to_firms::Dict{Int, Float64}  # Firm ID -> Loan amount
    total_loans::Float64
    other_assets::Float64
    
    # Balance sheet - Liabilities
    worker_deposits::Dict{Int, Float64}  # Worker ID -> Deposit amount
    total_deposits::Float64
    interbank_borrowing::Float64
    central_bank_borrowing::Float64
    
    # Balance sheet - Equity
    equity_capital::Float64
    retained_earnings::Float64
    
    # Interest rates
    deposit_rate::Float64
    loan_rate_base::Float64          # Base lending rate
    loan_rates::Dict{Int, Float64}   # Firm-specific rates
    
    # Risk assessment and credit scoring
    credit_standards::Float64        # Tightness of credit standards (0-1)
    risk_weights::Dict{Int, Float64} # Risk weights for firm loans
    default_provisions::Float64      # Provisions for expected losses
    
    # Regulatory compliance
    capital_adequacy_ratio::Float64  # Capital / Risk-weighted assets
    required_capital_ratio::Float64  # Regulatory minimum
    excess_capital::Float64
    regulatory_violations::Int       # Count of violations
    
    # Bank performance
    net_interest_income::Float64
    operating_costs::Float64
    loan_losses::Float64
    net_income::Float64
    return_on_equity::Float64
    
    # Credit rationing and demand
    credit_applications::Vector{Tuple{Int, Float64, String}}  # (firm_id, amount, purpose)
    approved_loans::Vector{Tuple{Int, Float64, Float64}}      # (firm_id, amount, rate)
    rejected_applications::Vector{Int}                         # Firm IDs
    
    # Market position
    market_share_deposits::Float64
    market_share_loans::Float64
    customer_relationships::Dict{Int, Int}  # Firm ID -> relationship duration
    
    # Bailout and intervention history
    bailout_history::Vector{Int}     # Periods when bank was bailed out
    intervention_level::Float64      # Current level of government intervention
end

"""
    initialize_banks!(model::KSModel)

Initialize all bank agents with appropriate starting balance sheets and parameters.
"""
function initialize_banks!(model::KSModel)
    total_bank_id_offset = model.params.n_workers + model.params.n_firms_sector1 + model.params.n_firms_sector2
    
    for i in 1:model.params.n_banks
        pos = (rand(1:100), rand(1:100))
        
        # Initial balance sheet sizing
        initial_assets = 50000.0 + 25000.0 * rand()
        initial_equity = initial_assets * (model.params.bank_capital_ratio + 0.02 * rand())
        initial_deposits = initial_assets * (0.8 + 0.1 * rand())
        initial_loans = initial_assets * (0.6 + 0.2 * rand())
        
        bank = Bank(
            total_bank_id_offset + i,            # id
            pos,                                 # pos
            rand(5:20),                         # age
            initial_assets,                      # bank_size
            initial_assets * 0.1,               # cash_reserves
            Dict{Int, Float64}(),               # loans_to_firms
            initial_loans,                       # total_loans
            initial_assets * 0.2,               # other_assets
            Dict{Int, Float64}(),               # worker_deposits
            initial_deposits,                    # total_deposits
            0.0,                                # interbank_borrowing
            0.0,                                # central_bank_borrowing
            initial_equity,                      # equity_capital
            0.0,                                # retained_earnings
            model.params.interest_rate_deposits, # deposit_rate
            model.params.interest_rate_loans,    # loan_rate_base
            Dict{Int, Float64}(),               # loan_rates
            0.5 + 0.3 * rand(),                 # credit_standards
            Dict{Int, Float64}(),               # risk_weights
            initial_loans * 0.02,               # default_provisions
            model.params.bank_capital_ratio + 0.02 * rand(), # capital_adequacy_ratio
            model.params.bank_capital_ratio,     # required_capital_ratio
            max(0.0, initial_equity - initial_assets * model.params.bank_capital_ratio), # excess_capital
            0,                                  # regulatory_violations
            0.0,                                # net_interest_income
            initial_assets * 0.02,              # operating_costs
            0.0,                                # loan_losses  
            0.0,                                # net_income
            0.0,                                # return_on_equity
            Tuple{Int, Float64, String}[],      # credit_applications
            Tuple{Int, Float64, Float64}[],     # approved_loans
            Int[],                              # rejected_applications
            1.0 / model.params.n_banks,        # market_share_deposits
            1.0 / model.params.n_banks,        # market_share_loans
            Dict{Int, Int}(),                   # customer_relationships
            Int[],                              # bailout_history
            0.0                                 # intervention_level
        )
        
        add_agent!(bank, model.model)
    end
end

"""
    calculate_risk_weighted_assets(bank::Bank, model::KSModel) -> Float64

Calculate risk-weighted assets for capital adequacy calculations.
"""
function calculate_risk_weighted_assets(bank::Bank, model::KSModel)
    rwa = 0.0
    
    # Cash and reserves have 0% risk weight
    # rwa += bank.cash_reserves * 0.0
    
    # Loans to firms - risk weight depends on firm characteristics
    for (firm_id, loan_amount) in bank.loans_to_firms
        if haskey(model.model.agents, firm_id)
            firm = model.model.agents[firm_id]
            
            # Determine risk weight based on firm characteristics
            if firm isa Firm1
                # Capital goods firms - moderate risk
                risk_weight = 0.75
            elseif firm isa Firm2
                # Consumption goods firms - higher risk
                risk_weight = 1.0
            else
                risk_weight = 1.0  # Default
            end
            
            # Adjust risk weight based on firm performance
            if hasfield(typeof(firm), :profits) && firm.profits < 0
                risk_weight *= 1.5  # Higher risk for unprofitable firms
            end
            
            # Apply firm-specific risk adjustments
            if haskey(bank.risk_weights, firm_id)
                risk_weight *= bank.risk_weights[firm_id]
            end
            
            rwa += loan_amount * risk_weight
        else
            # Firm no longer exists - 150% risk weight for bad debt
            rwa += loan_amount * 1.5
        end
    end
    
    # Other assets - 100% risk weight
    rwa += bank.other_assets * 1.0
    
    return rwa
end

"""
    update_capital_adequacy!(bank::Bank, model::KSModel)

Update bank capital adequacy ratio and check regulatory compliance.
"""
function update_capital_adequacy!(bank::Bank, model::KSModel)
    # Calculate risk-weighted assets
    rwa = calculate_risk_weighted_assets(bank, model)
    
    # Calculate capital adequacy ratio
    total_capital = bank.equity_capital + bank.retained_earnings
    if rwa > 0
        bank.capital_adequacy_ratio = total_capital / rwa
    else
        bank.capital_adequacy_ratio = 1.0  # No risk assets
    end
    
    # Check regulatory compliance
    if bank.capital_adequacy_ratio < bank.required_capital_ratio
        bank.regulatory_violations += 1
        bank.excess_capital = total_capital - rwa * bank.required_capital_ratio
        
        # Automatic regulatory response
        if bank.regulatory_violations > 3
            # Forced capital injection or intervention
            initiate_bank_intervention!(bank, model)
        end
    else
        bank.excess_capital = total_capital - rwa * bank.required_capital_ratio
        bank.regulatory_violations = max(0, bank.regulatory_violations - 1)
    end
end

"""
    assess_credit_risk!(bank::Bank, firm_id::Int, model::KSModel) -> Float64

Assess credit risk for a potential borrower and return risk score (0-1, higher = riskier).
"""
function assess_credit_risk!(bank::Bank, firm_id::Int, model::KSModel)
    if !haskey(model.model.agents, firm_id)
        return 1.0  # Maximum risk if firm doesn't exist
    end
    
    firm = model.model.agents[firm_id]
    risk_score = 0.0
    
    # Financial health indicators
    if hasfield(typeof(firm), :profits) && hasfield(typeof(firm), :revenue)
        if firm.revenue > 0
            profit_margin = firm.profits / firm.revenue
            risk_score += profit_margin < 0 ? 0.3 : max(0, 0.1 - profit_margin)
        else
            risk_score += 0.4  # No revenue is very risky
        end
    end
    
    # Leverage assessment
    if hasfield(typeof(firm), :debt) && hasfield(typeof(firm), :cash)
        if firm.cash > 0
            leverage = firm.debt / firm.cash
            risk_score += min(0.3, leverage * 0.1)
        else
            risk_score += 0.2  # No cash is risky
        end
    end
    
    # Sector-specific risk factors
    if firm isa Firm1
        risk_score += 0.1  # Capital goods sector baseline risk
    elseif firm isa Firm2
        risk_score += 0.15  # Consumption goods sector higher risk
    end
    
    # Firm age and stability
    if hasfield(typeof(firm), :age)
        if firm.age < 5
            risk_score += 0.1  # Young firms are riskier
        end
    end
    
    # Market position
    if hasfield(typeof(firm), :market_share)
        if firm.market_share < 0.01
            risk_score += 0.1  # Small market share is riskier
        end
    end
    
    # Existing relationship premium
    if haskey(bank.customer_relationships, firm_id)
        relationship_years = bank.customer_relationships[firm_id]
        risk_score -= min(0.1, relationship_years * 0.01)  # Relationship discount
    end
    
    # Current credit standards adjustment
    risk_score *= bank.credit_standards
    
    return min(1.0, max(0.0, risk_score))
end

"""
    process_credit_applications!(bank::Bank, model::KSModel)

Process all pending credit applications using risk assessment and capital constraints.
"""
function process_credit_applications!(bank::Bank, model::KSModel)
    empty!(bank.approved_loans)
    empty!(bank.rejected_applications)
    
    if isempty(bank.credit_applications)
        return
    end
    
    # Sort applications by relationship and risk
    sorted_applications = sort(bank.credit_applications, by = app -> begin
        firm_id, amount, purpose = app
        risk_score = assess_credit_risk!(bank, firm_id, model)
        relationship_bonus = haskey(bank.customer_relationships, firm_id) ? 
                           -bank.customer_relationships[firm_id] * 0.01 : 0.0
        risk_score + relationship_bonus
    end)
    
    # Process applications within capital constraints
    available_capital = bank.excess_capital
    total_new_loans = 0.0
    
    for (firm_id, requested_amount, purpose) in sorted_applications
        risk_score = assess_credit_risk!(bank, firm_id, model)
        
        # Determine if loan should be approved
        approval_threshold = bank.credit_standards
        
        if risk_score <= approval_threshold
            # Calculate required capital for this loan
            risk_weight = firm_id in keys(model.model.agents) ? 
                         (model.model.agents[firm_id] isa Firm1 ? 0.75 : 1.0) : 1.5
            required_capital = requested_amount * risk_weight * bank.required_capital_ratio
            
            if available_capital >= required_capital && 
               total_new_loans + requested_amount <= bank.cash_reserves
                
                # Approve loan
                interest_rate = calculate_loan_rate(bank, firm_id, risk_score, model)
                push!(bank.approved_loans, (firm_id, requested_amount, interest_rate))
                
                # Update bank balance sheet
                bank.loans_to_firms[firm_id] = get(bank.loans_to_firms, firm_id, 0.0) + requested_amount
                bank.total_loans += requested_amount
                bank.cash_reserves -= requested_amount
                bank.loan_rates[firm_id] = interest_rate
                
                # Update available capital
                available_capital -= required_capital
                total_new_loans += requested_amount
                
                # Update customer relationship
                bank.customer_relationships[firm_id] = get(bank.customer_relationships, firm_id, 0) + 1
                
            else
                # Reject due to capital constraints
                push!(bank.rejected_applications, firm_id)
            end
        else
            # Reject due to risk
            push!(bank.rejected_applications, firm_id)
        end
    end
    
    # Clear applications
    empty!(bank.credit_applications)
end

"""
    calculate_loan_rate(bank::Bank, firm_id::Int, risk_score::Float64, model::KSModel) -> Float64

Calculate the interest rate for a specific loan based on risk and market conditions.
"""
function calculate_loan_rate(bank::Bank, firm_id::Int, risk_score::Float64, model::KSModel)
    # Base rate
    rate = bank.loan_rate_base
    
    # Risk premium
    risk_premium = risk_score * 0.05  # Up to 5% risk premium
    rate += risk_premium
    
    # Relationship discount
    if haskey(bank.customer_relationships, firm_id)
        relationship_discount = min(0.01, bank.customer_relationships[firm_id] * 0.001)
        rate -= relationship_discount
    end
    
    # Market competition adjustment
    market_pressure = (1.0 - bank.market_share_loans) * 0.002
    rate -= market_pressure
    
    # Capital adequacy adjustment
    if bank.capital_adequacy_ratio < bank.required_capital_ratio + 0.02
        rate += 0.01  # Premium for capital-constrained banks
    end
    
    return max(bank.deposit_rate + 0.01, rate)  # Ensure positive spread
end

"""
    collect_deposits!(bank::Bank, model::KSModel)

Collect deposits from workers and update deposit balances.
"""
function collect_deposits!(bank::Bank, model::KSModel)
    # Process worker deposits
    total_new_deposits = 0.0
    
    for worker in values(model.model.agents)
        if worker isa Worker && worker.savings > 0
            # Workers deposit fraction of savings
            deposit_fraction = 0.8 + 0.2 * rand()  # 80-100% of savings
            deposit_amount = worker.savings * deposit_fraction
            
            if deposit_amount > 10.0  # Minimum deposit threshold
                # Add to bank deposits
                bank.worker_deposits[worker.id] = get(bank.worker_deposits, worker.id, 0.0) + deposit_amount
                total_new_deposits += deposit_amount
                
                # Update worker savings
                worker.savings -= deposit_amount
            end
        end
    end
    
    # Update bank balance sheet
    bank.total_deposits += total_new_deposits
    bank.cash_reserves += total_new_deposits
end

"""
    process_loan_repayments!(bank::Bank, model::KSModel)

Process loan repayments and handle defaults.
"""
function process_loan_repayments!(bank::Bank, model::KSModel)
    defaults = Int[]
    total_repayments = 0.0
    total_interest = 0.0
    
    for (firm_id, loan_amount) in collect(bank.loans_to_firms)
        if haskey(model.model.agents, firm_id)
            firm = model.model.agents[firm_id]
            interest_rate = get(bank.loan_rates, firm_id, bank.loan_rate_base)
            
            # Calculate payment due
            interest_payment = loan_amount * interest_rate / 12  # Monthly payment
            principal_payment = loan_amount * 0.01  # 1% principal per month
            total_payment = interest_payment + principal_payment
            
            # Check if firm can pay
            if hasfield(typeof(firm), :cash) && firm.cash >= total_payment
                # Firm pays
                firm.cash -= total_payment
                total_repayments += principal_payment
                total_interest += interest_payment
                
                # Reduce loan balance
                bank.loans_to_firms[firm_id] -= principal_payment
                if bank.loans_to_firms[firm_id] <= 0
                    delete!(bank.loans_to_firms, firm_id)
                    delete!(bank.loan_rates, firm_id)
                end
            else
                # Firm defaults
                push!(defaults, firm_id)
            end
        else
            # Firm no longer exists - automatic default
            push!(defaults, firm_id)
        end
    end
    
    # Process defaults
    total_defaults = 0.0
    for firm_id in defaults
        default_amount = bank.loans_to_firms[firm_id]
        total_defaults += default_amount
        
        # Remove from loan portfolio
        delete!(bank.loans_to_firms, firm_id)
        delete!(bank.loan_rates, firm_id)
        delete!(bank.customer_relationships, firm_id)
    end
    
    # Update bank balance sheet
    bank.total_loans -= (total_repayments + total_defaults)
    bank.cash_reserves += total_repayments
    bank.loan_losses += total_defaults
    bank.net_interest_income += total_interest
    
    # Update provisions
    bank.default_provisions = bank.total_loans * 0.02  # 2% provision rate
end

"""
    pay_deposit_interest!(bank::Bank, model::KSModel)

Pay interest on worker deposits.
"""
function pay_deposit_interest!(bank::Bank, model::KSModel)
    total_interest_paid = 0.0
    
    for (worker_id, deposit_amount) in bank.worker_deposits
        if haskey(model.model.agents, worker_id)
            worker = model.model.agents[worker_id]
            interest_payment = deposit_amount * bank.deposit_rate / 12  # Monthly interest
            
            # Add interest to worker's deposit balance
            bank.worker_deposits[worker_id] += interest_payment
            total_interest_paid += interest_payment
        end
    end
    
    # Update bank balance sheet
    bank.total_deposits += total_interest_paid
    bank.cash_reserves -= total_interest_paid
end

"""
    initiate_bank_intervention!(bank::Bank, model::KSModel)

Initiate government intervention for undercapitalized banks.
"""
function initiate_bank_intervention!(bank::Bank, model::KSModel)
    capital_shortfall = calculate_risk_weighted_assets(bank, model) * bank.required_capital_ratio - 
                       (bank.equity_capital + bank.retained_earnings)
    
    if capital_shortfall > 0
        # Government capital injection
        bank.equity_capital += capital_shortfall * 1.5  # 150% of minimum required
        bank.intervention_level = capital_shortfall / bank.bank_size
        push!(bank.bailout_history, model.step_counter)
        
        # Tighten credit standards as condition
        bank.credit_standards = min(1.0, bank.credit_standards + 0.2)
        
        println("Bank $(bank.id) received government bailout of $(capital_shortfall * 1.5)")
    end
end

"""
    calculate_bank_performance!(bank::Bank, model::KSModel)

Calculate bank performance metrics and update financial statements.
"""
function calculate_bank_performance!(bank::Bank, model::KSModel)
    # Calculate net income
    bank.net_income = bank.net_interest_income - bank.operating_costs - bank.loan_losses
    
    # Update retained earnings
    bank.retained_earnings += bank.net_income * 0.7  # 70% retention rate
    
    # Calculate return on equity
    total_equity = bank.equity_capital + bank.retained_earnings
    if total_equity > 0
        bank.return_on_equity = bank.net_income / total_equity
    else
        bank.return_on_equity = 0.0
    end
    
    # Update bank size
    bank.bank_size = bank.cash_reserves + bank.total_loans + bank.other_assets
    
    # Reset periodic variables
    bank.net_interest_income = 0.0
    bank.loan_losses = 0.0
end

"""
    step_bank!(bank::Bank, model::KSModel)

Main step function for bank agents.
"""
function step_bank!(bank::Bank, model::KSModel)
    bank.age += 1
    
    # Collect deposits from workers
    collect_deposits!(bank, model)
    
    # Process loan repayments and defaults
    process_loan_repayments!(bank, model)
    
    # Pay interest on deposits
    pay_deposit_interest!(bank, model)
    
    # Process new credit applications
    process_credit_applications!(bank, model)
    
    # Update capital adequacy
    update_capital_adequacy!(bank, model)
    
    # Calculate performance metrics
    calculate_bank_performance!(bank, model)
end