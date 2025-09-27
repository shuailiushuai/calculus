"""
# K+S Labor-Augmented Model

A complete implementation of the Dosi et al. (2010) K+S labor-augmented model
using Agents.jl framework. This model includes heterogeneous firms, workers,
banks, and government with complex interactions in capital, consumption,
and labor markets.

## Main Components:
- Worker agents with reservation wage dynamics and employment contracts
- Firm agents in capital goods (sector 1) and consumption goods (sector 2) sectors
- Bank agents with capital adequacy rules and credit rationing
- Government agent with fiscal operations and unemployment benefits
- Complete market clearing mechanisms
- Macroeconomic aggregation and data collection

## References:
Dosi, G., Fagiolo, G., & Roventini, A. (2010). Schumpeter meeting Keynes: A policy-friendly model of endogenous growth and business cycles. Journal of Economic Dynamics and Control, 34(9), 1748-1767.
"""
module KSLaborAugmentedModel

using Agents
using DataFrames
using Distributions
using Random
using Statistics
using StatsBase
using LinearAlgebra
using Plots

# Export main types and functions
export KSModel, Worker, Firm1, Firm2, Bank, Government
export create_model, step_agent!, model_step!, run_simulation!
export collect_model_data, analyze_results, plot_results

# Include sub-modules
include("agents/workers.jl")
include("agents/firms.jl") 
include("agents/banks.jl")
include("agents/government.jl")
include("markets/labor_market.jl")
include("markets/capital_market.jl")
include("markets/consumption_market.jl")
include("analysis/data_collection.jl")
include("analysis/aggregation.jl")

"""
Model parameters structure containing all calibrated parameters
for the K+S labor-augmented model.
"""
@kwdef struct KSParameters
    # Basic model dimensions
    n_workers::Int = 10000
    n_firms_sector1::Int = 50  # Capital goods sector
    n_firms_sector2::Int = 200 # Consumption goods sector  
    n_banks::Int = 10
    
    # Time and simulation
    max_steps::Int = 1000
    warmup_steps::Int = 100
    
    # Worker parameters
    worker_memory_length::Int = 26  # Number of periods workers remember wages
    reservation_wage_adaptation::Float64 = 0.02
    unemployment_benefit_rate::Float64 = 0.4
    worker_search_intensity::Float64 = 0.1
    wage_bargaining_power::Float64 = 0.5
    
    # Firm parameters - Sector 1 (Capital goods)
    sector1_rd_intensity::Float64 = 0.04
    sector1_innovation_prob::Float64 = 0.3
    sector1_imitation_prob::Float64 = 0.7
    sector1_patent_protection::Int = 15
    
    # Firm parameters - Sector 2 (Consumption goods)
    sector2_desired_inventories::Float64 = 0.1
    sector2_price_sensitivity::Float64 = 2.0
    sector2_delivery_delay::Int = 3
    
    # Labor market parameters
    firing_rules::Vector{Int} = [0, 1, 2, 3, 4, 5, 6]
    work_sharing_threshold::Float64 = 0.1
    contract_protection_periods::Int = 12
    
    # Financial parameters
    interest_rate_deposits::Float64 = 0.01
    interest_rate_loans::Float64 = 0.04
    bank_capital_ratio::Float64 = 0.08
    credit_rationing_threshold::Float64 = 1.5
    
    # Government parameters
    tax_rate_workers::Float64 = 0.2
    tax_rate_firms::Float64 = 0.25
    government_spending_gdp_ratio::Float64 = 0.2
    debt_gdp_target::Float64 = 0.6
    
    # Market parameters
    replicator_dynamics_speed::Float64 = 0.1
    market_share_threshold::Float64 = 0.01
    entry_probability::Float64 = 0.05
    exit_threshold::Float64 = 0.02
end

"""
Main model structure for the K+S labor-augmented model.
Contains the agent-based model and all parameters.
"""
mutable struct KSModel <: Agents.ABM{Agents.GridSpace{2}}
    model::Agents.ABM
    params::KSParameters
    step_counter::Int
    
    # Aggregate variables
    gdp::Float64
    unemployment_rate::Float64
    inflation_rate::Float64
    average_wage::Float64
    productivity_growth::Float64
    
    # Market variables  
    labor_market_tightness::Float64
    credit_market_conditions::Float64
    
    # Government variables
    government_debt::Float64
    government_deficit::Float64
    
    # Data collection
    time_series_data::DataFrame
    
    function KSModel(params::KSParameters = KSParameters())
        # Create the underlying ABM
        space = GridSpace((100, 100), periodic = true)
        model = ABM(Union{Worker, Firm1, Firm2, Bank, Government}, 
                   space; 
                   properties = Dict(:step => 0))
        
        new(model, params, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, DataFrame())
    end
end

"""
    create_model(params::KSParameters = KSParameters()) -> KSModel

Create and initialize a new K+S labor-augmented model with the specified parameters.
All agents are created and placed in the model space with initial conditions.
"""
function create_model(params::KSParameters = KSParameters())
    model = KSModel(params)
    
    # Initialize agents
    initialize_workers!(model)
    initialize_firms!(model) 
    initialize_banks!(model)
    initialize_government!(model)
    
    # Initialize markets
    initialize_labor_market!(model)
    initialize_capital_market!(model)
    initialize_consumption_market!(model)
    
    return model
end

"""
Main simulation step function that coordinates all agent and market activities.
"""
function model_step!(model::KSModel)
    model.step_counter += 1
    
    # Phase 1: Production planning
    production_planning_phase!(model)
    
    # Phase 2: Labor market
    labor_market_phase!(model) 
    
    # Phase 3: Credit market
    credit_market_phase!(model)
    
    # Phase 4: Production
    production_phase!(model)
    
    # Phase 5: Consumption market
    consumption_market_phase!(model)
    
    # Phase 6: Capital market
    capital_market_phase!(model)
    
    # Phase 7: Government operations
    government_phase!(model)
    
    # Phase 8: Entry/Exit
    entry_exit_phase!(model)
    
    # Phase 9: Data collection
    collect_model_data!(model)
end

"""
    credit_market_phase!(model::KSModel)

Execute credit market operations and bank lending decisions.
"""
function credit_market_phase!(model::KSModel)
    # Step 1: Firms submit credit applications
    for firm in values(model.model.agents)
        if firm isa Firm1 || firm isa Firm2
            submit_credit_applications!(firm, model)
        end
    end
    
    # Step 2: Banks process applications
    for bank in values(model.model.agents)
        if bank isa Bank
            step_bank!(bank, model)
        end
    end
    
    # Step 3: Execute approved loans
    execute_credit_transactions!(model)
end

"""
    submit_credit_applications!(firm::Union{Firm1, Firm2}, model::KSModel)

Firm submits credit applications to banks based on financing needs.
"""
function submit_credit_applications!(firm::Union{Firm1, Firm2}, model::KSModel)
    # Calculate credit demand
    credit_needed = 0.0
    
    # Working capital needs
    if firm.labor_cost > firm.cash * 0.8
        credit_needed += firm.labor_cost - firm.cash * 0.8
    end
    
    # Investment financing (for Sector 2)
    if firm isa Firm2 && firm.desired_investment > 0
        if firm.cash < firm.desired_investment
            credit_needed += firm.desired_investment - firm.cash
        end
    end
    
    # R&D financing (for Sector 1)
    if firm isa Firm1 && firm.rd_expenditure > 0
        if firm.cash < firm.rd_expenditure
            credit_needed += firm.rd_expenditure - firm.cash
        end
    end
    
    firm.credit_demand = credit_needed
    
    # Submit applications to banks if credit needed
    if credit_needed > 0
        banks = [agent for agent in values(model.model.agents) if agent isa Bank]
        
        if !isempty(banks)
            # Apply to 1-3 random banks
            num_applications = min(3, length(banks))
            selected_banks = sample(banks, num_applications, replace=false)
            
            for bank in selected_banks
                purpose = firm isa Firm1 ? "R&D" : "investment"
                push!(bank.credit_applications, (firm.id, credit_needed, purpose))
            end
        end
    end
end

"""
    execute_credit_transactions!(model::KSModel)

Execute approved credit transactions between banks and firms.
"""
function execute_credit_transactions!(model::KSModel)
    for bank in values(model.model.agents)
        if bank isa Bank
            for (firm_id, loan_amount, interest_rate) in bank.approved_loans
                if haskey(model.model.agents, firm_id)
                    firm = model.model.agents[firm_id]
                    
                    # Transfer funds to firm
                    firm.cash += loan_amount
                    firm.debt += loan_amount
                    
                    println("Firm $(firm.id) received loan of $(loan_amount) at $(interest_rate*100)% rate")
                end
            end
            
            # Clear approved loans for next period
            empty!(bank.approved_loans)
        end
    end
end

"""
    government_phase!(model::KSModel)

Execute government operations and fiscal policy.
"""
function government_phase!(model::KSModel)
    for government in values(model.model.agents)
        if government isa Government
            step_government!(government, model)
            break
        end
    end
end

"""
    run_simulation!(model::KSModel; steps::Int = model.params.max_steps)

Run the complete simulation for the specified number of steps.
Returns a DataFrame with collected time series data.
"""
function run_simulation!(model::KSModel; steps::Int = model.params.max_steps)
    # Run warmup period
    for _ in 1:model.params.warmup_steps
        model_step!(model)
    end
    
    # Clear data and run main simulation
    model.time_series_data = DataFrame()
    
    for step in 1:steps
        model_step!(model)
        
        # Progress reporting every 100 steps
        if step % 100 == 0
            println("Completed step $step of $steps")
        end
    end
    
    return model.time_series_data
end

end # module