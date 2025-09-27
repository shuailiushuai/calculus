"""
Aggregation and analysis functions for the K+S labor-augmented model.

Functions for analyzing model results, calculating stylized facts,
and performing macroeconomic analysis.
"""

using DataFrames
using Statistics
using Plots
using StatsBase
using CSV

"""
    analyze_results(model::KSModel) -> Dict

Perform comprehensive analysis of model results and calculate key statistics.
"""
function analyze_results(model::KSModel)
    if isempty(model.time_series_data)
        return Dict("error" => "No data collected")
    end
    
    results = Dict{String, Any}()
    
    # Basic statistics
    results["simulation_length"] = nrow(model.time_series_data)
    results["final_gdp"] = model.time_series_data[end, :gdp]
    results["final_unemployment"] = model.time_series_data[end, :unemployment_rate]
    results["final_inflation"] = model.time_series_data[end, :inflation_rate]
    
    # Business cycle analysis
    results["business_cycle"] = analyze_business_cycles(model.time_series_data)
    
    # Labor market analysis
    results["labor_market"] = analyze_labor_market(model.time_series_data)
    
    # Financial sector analysis
    results["financial_sector"] = analyze_financial_sector(model.time_series_data)
    
    # Innovation and productivity
    results["innovation"] = analyze_innovation_dynamics(model.time_series_data)
    
    # Distributional analysis
    results["distribution"] = analyze_distribution(model.time_series_data)
    
    # Stylized facts
    results["stylized_facts"] = calculate_stylized_facts(model.time_series_data)
    
    return results
end

"""
    analyze_business_cycles(data::DataFrame) -> Dict

Analyze business cycle properties of the simulation.
"""
function analyze_business_cycles(data::DataFrame)
    if nrow(data) < 10
        return Dict("error" => "Insufficient data for business cycle analysis")
    end
    
    results = Dict{String, Any}()
    
    # GDP volatility and growth
    gdp_growth = data.gdp_growth
    results["gdp_growth_mean"] = mean(gdp_growth)
    results["gdp_growth_std"] = std(gdp_growth)
    results["gdp_volatility"] = std(gdp_growth) / abs(mean(gdp_growth))  # Coefficient of variation
    
    # Recession identification (simplified)
    negative_growth_periods = count(g -> g < -0.01, gdp_growth)  # More than 1% decline
    results["recession_frequency"] = negative_growth_periods / length(gdp_growth)
    
    # Correlation analysis
    if :unemployment_rate in names(data) && :inflation_rate in names(data)
        results["phillips_curve_correlation"] = cor(data.unemployment_rate, data.inflation_rate)
    end
    
    if :investment in names(data)
        results["investment_gdp_correlation"] = cor(data.investment, data.gdp)
        results["investment_volatility"] = std(data.investment) / mean(data.investment)
    end
    
    # Okun's law (relationship between unemployment and GDP)
    if :unemployment_rate in names(data) && length(gdp_growth) > 1
        unemployment_changes = diff(data.unemployment_rate)
        gdp_growth_trimmed = gdp_growth[2:end]  # Match lengths
        if length(unemployment_changes) == length(gdp_growth_trimmed)
            results["okuns_law_correlation"] = cor(unemployment_changes, gdp_growth_trimmed)
        end
    end
    
    return results
end

"""
    analyze_labor_market(data::DataFrame) -> Dict

Analyze labor market dynamics and patterns.
"""
function analyze_labor_market(data::DataFrame)
    results = Dict{String, Any}()
    
    if :unemployment_rate in names(data)
        results["avg_unemployment_rate"] = mean(data.unemployment_rate)
        results["unemployment_volatility"] = std(data.unemployment_rate)
        results["max_unemployment"] = maximum(data.unemployment_rate)
        results["min_unemployment"] = minimum(data.unemployment_rate)
    end
    
    if :average_wage in names(data)
        results["avg_wage_level"] = mean(data.average_wage)
        if :wage_growth in names(data)
            results["avg_wage_growth"] = mean(data.wage_growth)
            results["wage_growth_volatility"] = std(data.wage_growth)
        end
    end
    
    if :labor_market_tightness in names(data)
        results["avg_market_tightness"] = mean(data.labor_market_tightness)
        results["market_tightness_volatility"] = std(data.labor_market_tightness)
    end
    
    # Beveridge curve analysis (unemployment vs. vacancies)
    if :unemployment_rate in names(data) && :labor_market_tightness in names(data)
        results["beveridge_curve_correlation"] = cor(data.unemployment_rate, data.labor_market_tightness)
    end
    
    # Wage inequality
    if :wage_gini in names(data)
        results["avg_wage_inequality"] = mean(data.wage_gini)
        results["wage_inequality_trend"] = length(data.wage_gini) > 1 ? 
                                          cor(1:length(data.wage_gini), data.wage_gini) : 0.0
    end
    
    return results
end

"""
    analyze_financial_sector(data::DataFrame) -> Dict

Analyze banking and financial sector performance.
"""
function analyze_financial_sector(data::DataFrame)
    results = Dict{String, Any}()
    
    if :avg_capital_ratio in names(data)
        results["avg_capital_adequacy"] = mean(data.avg_capital_ratio)
        results["capital_ratio_volatility"] = std(data.avg_capital_ratio)
        results["undercapitalized_episodes"] = count(r -> r < 0.08, data.avg_capital_ratio)
    end
    
    if :credit_growth in names(data)
        results["avg_credit_growth"] = mean(data.credit_growth)
        results["credit_growth_volatility"] = std(data.credit_growth)
        results["credit_boom_episodes"] = count(g -> g > 0.1, data.credit_growth)  # 10%+ growth
        results["credit_crunch_episodes"] = count(g -> g < -0.05, data.credit_growth)  # 5%+ decline
    end
    
    if :credit_rationing_index in names(data)
        results["avg_credit_rationing"] = mean(data.credit_rationing_index)
        results["credit_rationing_volatility"] = std(data.credit_rationing_index)
    end
    
    if :total_loan_losses in names(data)
        results["total_banking_losses"] = sum(data.total_loan_losses)
        results["avg_loss_rate"] = mean(data.total_loan_losses)
    end
    
    return results
end

"""
    analyze_innovation_dynamics(data::DataFrame) -> Dict

Analyze innovation and technological progress patterns.
"""
function analyze_innovation_dynamics(data::DataFrame)
    results = Dict{String, Any}()
    
    if :innovation_rate in names(data)
        results["avg_innovation_rate"] = mean(data.innovation_rate)
        results["innovation_rate_volatility"] = std(data.innovation_rate)
    end
    
    if :technology_frontier in names(data)
        results["technology_progress"] = length(data.technology_frontier) > 1 ?
                                        (data.technology_frontier[end] - data.technology_frontier[1]) /
                                        data.technology_frontier[1] : 0.0
        results["frontier_growth_rate"] = mean(diff(data.technology_frontier) ./ data.technology_frontier[1:end-1])
    end
    
    if :productivity_dispersion in names(data)
        results["avg_productivity_dispersion"] = mean(data.productivity_dispersion)
        results["dispersion_trend"] = length(data.productivity_dispersion) > 1 ?
                                     cor(1:length(data.productivity_dispersion), data.productivity_dispersion) : 0.0
    end
    
    if :rd_intensity in names(data)
        results["avg_rd_intensity"] = mean(data.rd_intensity)
    end
    
    if :technology_gap in names(data)
        results["avg_technology_gap"] = mean(data.technology_gap)
        results["technology_gap_trend"] = length(data.technology_gap) > 1 ?
                                         cor(1:length(data.technology_gap), data.technology_gap) : 0.0
    end
    
    return results
end

"""
    analyze_distribution(data::DataFrame) -> Dict

Analyze distributional aspects of the economy.
"""
function analyze_distribution(data::DataFrame)
    results = Dict{String, Any}()
    
    # Wage inequality over time
    if :wage_gini in names(data)
        results["initial_wage_gini"] = data.wage_gini[1]
        results["final_wage_gini"] = data.wage_gini[end]
        results["wage_inequality_change"] = data.wage_gini[end] - data.wage_gini[1]
    end
    
    # Market concentration
    if :sector1_concentration in names(data)
        results["avg_sector1_concentration"] = mean(data.sector1_concentration)
        results["sector1_concentration_trend"] = length(data.sector1_concentration) > 1 ?
                                                cor(1:length(data.sector1_concentration), data.sector1_concentration) : 0.0
    end
    
    if :sector2_concentration in names(data)
        results["avg_sector2_concentration"] = mean(data.sector2_concentration)
        results["sector2_concentration_trend"] = length(data.sector2_concentration) > 1 ?
                                                cor(1:length(data.sector2_concentration), data.sector2_concentration) : 0.0
    end
    
    return results
end

"""
    calculate_stylized_facts(data::DataFrame) -> Dict

Calculate key macroeconomic stylized facts and compare with empirical benchmarks.
"""
function calculate_stylized_facts(data::DataFrame)
    facts = Dict{String, Any}()
    
    # Kaldor facts
    if :gdp_growth in names(data)
        facts["avg_gdp_growth"] = mean(data.gdp_growth)
        facts["gdp_growth_stability"] = std(data.gdp_growth) < 0.05  # Less than 5% volatility
    end
    
    if :productivity_growth in names(data)
        facts["avg_productivity_growth"] = mean(data.productivity_growth)
        facts["productivity_wages_correlation"] = :wage_growth in names(data) ?
                                                 cor(data.productivity_growth, data.wage_growth) : missing
    end
    
    # Business cycle facts
    if :gdp_growth in names(data) && :consumption in names(data)
        consumption_growth = diff(data.consumption) ./ data.consumption[1:end-1]
        gdp_growth_trimmed = data.gdp_growth[2:end]
        facts["consumption_gdp_correlation"] = cor(consumption_growth, gdp_growth_trimmed)
        facts["consumption_smoothing"] = std(consumption_growth) < std(gdp_growth_trimmed)
    end
    
    if :investment in names(data) && :gdp in names(data)
        investment_growth = diff(data.investment) ./ data.investment[1:end-1]  
        gdp_growth_trimmed = data.gdp_growth[2:end]
        facts["investment_volatility_ratio"] = std(investment_growth) / std(gdp_growth_trimmed)
        facts["investment_procyclical"] = cor(investment_growth, gdp_growth_trimmed) > 0.5
    end
    
    # Labor market facts
    if :unemployment_rate in names(data)
        facts["unemployment_countercyclical"] = :gdp_growth in names(data) ?
                                               cor(data.unemployment_rate[2:end], data.gdp_growth[2:end]) < -0.3 : missing
        facts["unemployment_persistence"] = length(data.unemployment_rate) > 1 ?
                                           cor(data.unemployment_rate[1:end-1], data.unemployment_rate[2:end]) : missing
    end
    
    # Financial sector facts
    if :credit_growth in names(data) && :gdp_growth in names(data)
        facts["credit_procyclical"] = cor(data.credit_growth[2:end], data.gdp_growth[2:end]) > 0.3
        facts["credit_more_volatile"] = std(data.credit_growth) > std(data.gdp_growth)
    end
    
    # Innovation facts
    if :innovation_rate in names(data) && :rd_intensity in names(data)
        facts["rd_innovation_correlation"] = cor(data.rd_intensity, data.innovation_rate)
        facts["innovation_persistence"] = length(data.innovation_rate) > 1 ?
                                         cor(data.innovation_rate[1:end-1], data.innovation_rate[2:end]) : missing
    end
    
    return facts
end

"""
    plot_results(model::KSModel; save_path::String = "")

Create comprehensive plots of simulation results.
"""
function plot_results(model::KSModel; save_path::String = "")
    if isempty(model.time_series_data)
        println("No data to plot")
        return nothing
    end
    
    data = model.time_series_data
    
    # Create subplots for different aspects
    plots_list = []
    
    # GDP and growth
    if :gdp in names(data) && :gdp_growth in names(data)
        p1 = plot(data.step, data.gdp, title="GDP Level", xlabel="Time", ylabel="GDP")
        p2 = plot(data.step, data.gdp_growth, title="GDP Growth Rate", xlabel="Time", ylabel="Growth Rate")
        push!(plots_list, plot(p1, p2, layout=(2,1)))
    end
    
    # Labor market
    if :unemployment_rate in names(data) && :average_wage in names(data)
        p1 = plot(data.step, data.unemployment_rate, title="Unemployment Rate", xlabel="Time", ylabel="Rate")
        p2 = plot(data.step, data.average_wage, title="Average Wage", xlabel="Time", ylabel="Wage")
        push!(plots_list, plot(p1, p2, layout=(2,1)))
    end
    
    # Financial sector
    if :avg_capital_ratio in names(data) && :credit_growth in names(data)
        p1 = plot(data.step, data.avg_capital_ratio, title="Bank Capital Adequacy", xlabel="Time", ylabel="Ratio")
        hline!(p1, [0.08], label="Regulatory Minimum", linestyle=:dash)
        p2 = plot(data.step, data.credit_growth, title="Credit Growth", xlabel="Time", ylabel="Growth Rate")
        push!(plots_list, plot(p1, p2, layout=(2,1)))
    end
    
    # Innovation and productivity
    if :technology_frontier in names(data) && :innovation_rate in names(data)
        p1 = plot(data.step, data.technology_frontier, title="Technology Frontier", xlabel="Time", ylabel="Productivity")
        p2 = plot(data.step, data.innovation_rate, title="Innovation Rate", xlabel="Time", ylabel="Rate")
        push!(plots_list, plot(p1, p2, layout=(2,1)))
    end
    
    # Government finances
    if :fiscal_balance in names(data) && :debt_gdp_ratio in names(data)
        p1 = plot(data.step, data.fiscal_balance, title="Fiscal Balance", xlabel="Time", ylabel="Balance")
        hline!(p1, [0], label="Balanced", linestyle=:dash)
        p2 = plot(data.step, data.debt_gdp_ratio, title="Debt-to-GDP Ratio", xlabel="Time", ylabel="Ratio")
        push!(plots_list, plot(p1, p2, layout=(2,1)))
    end
    
    # Combine all plots
    if !isempty(plots_list)
        final_plot = plot(plots_list..., size=(1200, 800 * length(plots_list)))
        
        if !isempty(save_path)
            savefig(final_plot, save_path)
            println("Plots saved to: $save_path")
        end
        
        return final_plot
    else
        println("No suitable data columns found for plotting")
        return nothing
    end
end

"""
    export_results(model::KSModel, filename::String)

Export simulation results to CSV file.
"""
function export_results(model::KSModel, filename::String)
    if isempty(model.time_series_data)
        println("No data to export")
        return
    end
    
    # Write the main time series data
    CSV.write(filename, model.time_series_data)
    println("Results exported to: $filename")
    
    # Also create a summary statistics file
    if endswith(filename, ".csv")
        summary_filename = replace(filename, ".csv" => "_summary.csv")
        
        # Calculate summary statistics
        summary_data = DataFrame()
        for col in names(model.time_series_data)
            if col != :step && eltype(model.time_series_data[!, col]) <: Number
                summary_data[!, col * "_mean"] = [mean(model.time_series_data[!, col])]
                summary_data[!, col * "_std"] = [std(model.time_series_data[!, col])]
                summary_data[!, col * "_min"] = [minimum(model.time_series_data[!, col])]
                summary_data[!, col * "_max"] = [maximum(model.time_series_data[!, col])]
            end
        end
        
        CSV.write(summary_filename, summary_data)
        println("Summary statistics exported to: $summary_filename")
    end
end

"""
    entry_exit_phase!(model::KSModel)

Handle firm entry and exit decisions, and worker demographic changes.
"""
function entry_exit_phase!(model::KSModel)
    # Firm exit due to poor performance
    handle_firm_exits!(model)
    
    # Firm entry based on market conditions
    handle_firm_entry!(model)
    
    # Worker demographic changes
    handle_worker_demographics!(model)
end

"""
    handle_firm_exits!(model::KSModel)

Remove firms that meet exit conditions.
"""
function handle_firm_exits!(model::KSModel)
    firms_to_exit = []
    
    # Check Sector 1 firms
    for firm in values(model.model.agents)
        if firm isa Firm1 || firm isa Firm2
            should_exit = false
            
            # Exit conditions
            if firm.market_share < model.params.market_share_threshold
                should_exit = true
                println("Firm $(firm.id) exiting due to low market share: $(firm.market_share)")
            elseif firm.cash < 0 && firm.profits < 0
                should_exit = true
                println("Firm $(firm.id) exiting due to bankruptcy")
            elseif firm.age > 5 && firm.market_share == 0.0
                should_exit = true
                println("Firm $(firm.id) exiting due to zero market share")
            end
            
            if should_exit
                push!(firms_to_exit, firm.id)
            end
        end
    end
    
    # Remove exiting firms
    for firm_id in firms_to_exit
        if haskey(model.model.agents, firm_id)
            firm = model.model.agents[firm_id]
            
            # Fire all employees
            for worker_id in firm.employees
                if haskey(model.model.agents, worker_id)
                    worker = model.model.agents[worker_id]
                    worker.employed = false
                    worker.employer_id = nothing
                    worker.wage = 0.0
                    worker.contract_start_period = 0
                    worker.contract_duration = 0
                    worker.employment_duration = 0
                end
            end
            
            # Remove from model
            kill_agent!(model.model.agents[firm_id], model.model)
        end
    end
end

"""
    handle_firm_entry!(model::KSModel)

Create new firms based on market conditions and entry probability.
"""
function handle_firm_entry!(model::KSModel)
    sector1_firms = [agent for agent in values(model.model.agents) if agent isa Firm1]
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    # Entry probability based on market conditions
    entry_prob = model.params.entry_probability
    
    # Adjust entry probability based on market concentration
    if !isempty(sector1_firms)
        sector1_concentration = calculate_herfindahl_index([f.market_share for f in sector1_firms])
        if sector1_concentration < 0.2  # Competitive market encourages entry
            entry_prob *= 1.5
        end
    end
    
    if !isempty(sector2_firms)
        sector2_concentration = calculate_herfindahl_index([f.market_share for f in sector2_firms])
        if sector2_concentration < 0.2
            entry_prob *= 1.5
        end
    end
    
    # Sector 1 entry
    if rand() < entry_prob && length(sector1_firms) < model.params.n_firms_sector1 * 1.5
        create_new_sector1_firm!(model)
    end
    
    # Sector 2 entry  
    if rand() < entry_prob && length(sector2_firms) < model.params.n_firms_sector2 * 1.5
        create_new_sector2_firm!(model)
    end
end

"""
    create_new_sector1_firm!(model::KSModel)

Create a new entrant in Sector 1.
"""
function create_new_sector1_firm!(model::KSModel)
    # Find next available ID
    max_id = maximum(keys(model.model.agents))
    new_id = max_id + 1
    
    pos = (rand(1:100), rand(1:100))
    
    # New firm starts small with basic technology
    existing_firms = [agent for agent in values(model.model.agents) if agent isa Firm1]
    avg_productivity = !isempty(existing_firms) ? mean(f.productivity for f in existing_firms) : 1.0
    
    new_firm = Firm1(
        new_id,                              # id
        pos,                                 # pos
        0,                                   # age
        0.01,                               # market_share (small)
        avg_productivity * 0.8,             # productivity (below average)
        500.0,                              # production_capacity
        0.0,                                # actual_production
        50.0,                               # inventory
        500.0,                              # rd_expenditure
        model.params.sector1_rd_intensity,   # rd_intensity
        false,                              # innovation_success
        Int[],                              # patent_portfolio
        Int[],                              # employees
        10,                                 # labor_demand
        0.0,                                # labor_cost
        1.0,                                # avg_wage
        Tuple{Int, Float64}[],              # hiring_queue
        Int[],                              # firing_candidates
        0.0,                                # revenue
        0.0,                                # costs
        0.0,                                # profits
        5000.0,                             # cash
        0.0,                                # debt
        0.0,                                # credit_demand
        !isempty(existing_firms) ? mean(f.price for f in existing_firms) : 10.0, # price
        Int[],                              # customers
        0.0,                                # orders_received
        rand(1:3),                          # delivery_delay
        0.0,                                # desired_investment
        0.0                                 # actual_investment
    )
    
    add_agent!(new_firm, model.model)
    println("New Sector 1 firm $(new_id) entered the market")
end

"""
    create_new_sector2_firm!(model::KSModel)

Create a new entrant in Sector 2.
"""
function create_new_sector2_firm!(model::KSModel)
    # Find next available ID
    max_id = maximum(keys(model.model.agents))
    new_id = max_id + 1
    
    pos = (rand(1:100), rand(1:100))
    
    # New firm starts small
    existing_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    avg_productivity = !isempty(existing_firms) ? mean(f.productivity for f in existing_firms) : 1.0
    
    new_firm = Firm2(
        new_id,                              # id
        pos,                                 # pos
        0,                                   # age
        0.01,                               # market_share (small)
        avg_productivity * 0.8,             # productivity
        500.0,                              # production_capacity
        0.0,                                # actual_production
        50.0,                               # inventory
        50.0,                               # desired_inventory
        Int[],                              # employees
        15,                                 # labor_demand
        0.0,                                # labor_cost
        1.0,                                # avg_wage
        Tuple{Int, Float64}[],              # hiring_queue
        Int[],                              # firing_candidates
        0.0,                                # revenue
        0.0,                                # costs
        0.0,                                # profits
        5000.0,                             # cash
        0.0,                                # debt
        0.0,                                # credit_demand
        !isempty(existing_firms) ? mean(f.price for f in existing_firms) : 5.0, # price
        model.params.sector2_price_sensitivity, # price_sensitivity
        0.0,                                # demand_received
        0.0,                                # unfilled_demand
        2500.0,                             # capital_stock
        rand(1:10, 5),                      # capital_age_distribution
        nothing,                            # supplier_id
        0.0,                                # capital_orders
        1.0,                                # competitiveness
        500.0,                              # bonus_budget
        0.05                                # bonus_rate
    )
    
    add_agent!(new_firm, model.model)
    println("New Sector 2 firm $(new_id) entered the market")
    
    # Assign supplier
    sector1_firms = [agent for agent in values(model.model.agents) if agent isa Firm1]
    if !isempty(sector1_firms)
        supplier = rand(sector1_firms)
        new_firm.supplier_id = supplier.id
        push!(supplier.customers, new_id)
    end
end

"""
    handle_worker_demographics!(model::KSModel)

Handle worker aging, retirement, and new entrants.
"""
function handle_worker_demographics!(model::KSModel)
    workers = [agent for agent in values(model.model.agents) if agent isa Worker]
    workers_to_retire = []
    
    # Age workers and handle retirement
    for worker in workers
        worker.age += 1/12  # Monthly aging
        
        # Retirement at age 65
        if worker.age >= 65
            push!(workers_to_retire, worker.id)
        end
    end
    
    # Remove retiring workers
    for worker_id in workers_to_retire
        if haskey(model.model.agents, worker_id)
            worker = model.model.agents[worker_id]
            
            # If employed, remove from employer
            if worker.employed && worker.employer_id !== nothing
                if haskey(model.model.agents, worker.employer_id)
                    employer = model.model.agents[worker.employer_id]
                    filter!(id -> id != worker_id, employer.employees)
                end
            end
            
            kill_agent!(worker, model.model)
        end
    end
    
    # Add new young workers to maintain population
    if !isempty(workers_to_retire)
        for _ in 1:length(workers_to_retire)
            create_new_worker!(model)
        end
    end
end

"""
    create_new_worker!(model::KSModel)

Create a new young worker entering the labor force.
"""
function create_new_worker!(model::KSModel)
    # Find next available ID
    max_id = maximum(keys(model.model.agents))
    new_id = max_id + 1
    
    pos = (rand(1:100), rand(1:100))
    
    # Young worker with basic skills
    initial_wage = 1.0 + 0.2 * randn()
    wage_memory = fill(initial_wage, model.params.worker_memory_length)
    
    new_worker = Worker(
        new_id,                             # id
        pos,                                # pos
        false,                              # employed
        nothing,                            # employer_id
        0.0,                                # wage
        initial_wage * 0.9,                 # reservation_wage
        wage_memory,                        # wage_memory
        1,                                  # memory_pointer
        0,                                  # contract_start_period
        0,                                  # contract_duration
        0,                                  # employment_duration
        0.5 + 0.3 * rand(),                # skill_level (lower for young workers)
        18 + rand(0:5),                    # age (18-23)
        false,                              # discouraged
        0,                                  # discouragement_periods
        0,                                  # applications_sent
        Tuple{Int, Float64}[],              # job_offers_received  
        500.0 + 300.0 * rand(),            # savings (lower for young)
        0.0,                                # consumption_budget
        0.0,                                # taxes_paid
        0.0,                                # unemployment_benefits
        0.0,                                # bonus_rate
        0.0                                 # bonus_received
    )
    
    add_agent!(new_worker, model.model)
end