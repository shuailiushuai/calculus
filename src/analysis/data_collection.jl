"""
Data collection and analysis functions for the K+S labor-augmented model.

Comprehensive data collection system for tracking all key macroeconomic
and agent-level variables over time.
"""

using DataFrames
using Statistics

"""
    collect_model_data!(model::KSModel)

Collect comprehensive data from the current model state and add to time series.
"""
function collect_model_data!(model::KSModel)
    # Create data row for current period
    data_row = Dict{Symbol, Any}()
    
    # Basic simulation info
    data_row[:step] = model.step_counter
    
    # Collect macroeconomic aggregates
    collect_macro_data!(data_row, model)
    
    # Collect labor market data
    collect_labor_data!(data_row, model)
    
    # Collect financial sector data
    collect_financial_data!(data_row, model)
    
    # Collect government data
    collect_government_data!(data_row, model)
    
    # Collect firm sector data
    collect_firm_data!(data_row, model)
    
    # Collect innovation and technology data
    collect_innovation_data!(data_row, model)
    
    # Add to time series
    if isempty(model.time_series_data)
        model.time_series_data = DataFrame()
        for (key, value) in data_row
            model.time_series_data[!, key] = [value]
        end
    else
        push!(model.time_series_data, data_row)
    end
end

"""
    collect_macro_data!(data_row::Dict, model::KSModel)

Collect macroeconomic aggregates including GDP, inflation, and productivity.
"""
function collect_macro_data!(data_row::Dict, model::KSModel)
    # GDP calculation (expenditure approach)
    consumption = calculate_total_consumption(model)
    investment = calculate_total_investment(model)
    government_spending = calculate_government_spending(model)
    
    gdp = consumption + investment + government_spending
    data_row[:gdp] = gdp
    data_row[:consumption] = consumption
    data_row[:investment] = investment
    data_row[:government_spending] = government_spending
    
    # Update model GDP
    model.gdp = gdp
    
    # GDP growth rate
    if length(model.time_series_data) > 0
        previous_gdp = model.time_series_data[end, :gdp]
        data_row[:gdp_growth] = previous_gdp > 0 ? (gdp - previous_gdp) / previous_gdp : 0.0
        model.gdp_growth_rate = data_row[:gdp_growth]
    else
        data_row[:gdp_growth] = 0.0
    end
    
    # Inflation calculation (simplified CPI)
    data_row[:inflation_rate] = calculate_inflation_rate(model)
    model.inflation_rate = data_row[:inflation_rate]
    
    # Productivity measures
    data_row[:aggregate_productivity] = calculate_aggregate_productivity(model)
    data_row[:productivity_growth] = calculate_productivity_growth(model)
    model.productivity_growth = data_row[:productivity_growth]
end

"""
    collect_labor_data!(data_row::Dict, model::KSModel)

Collect comprehensive labor market statistics.
"""
function collect_labor_data!(data_row::Dict, model::KSModel)
    employed = 0
    unemployed = 0
    discouraged = 0
    total_wages = 0.0
    total_hours = 0.0
    
    workers = [agent for agent in values(model.model.agents) if agent isa Worker]
    
    for worker in workers
        if worker.employed
            employed += 1
            total_wages += worker.wage
            total_hours += 1.0  # Simplified: 1 unit of labor per worker
        elseif worker.discouraged
            discouraged += 1
        else
            unemployed += 1
        end
    end
    
    total_labor_force = employed + unemployed  # Excluding discouraged
    total_population = employed + unemployed + discouraged
    
    # Labor market rates
    data_row[:unemployment_rate] = total_labor_force > 0 ? unemployed / total_labor_force : 0.0
    data_row[:employment_rate] = total_population > 0 ? employed / total_population : 0.0
    data_row[:participation_rate] = total_population > 0 ? total_labor_force / total_population : 0.0
    data_row[:discouragement_rate] = total_population > 0 ? discouraged / total_population : 0.0
    
    # Update model unemployment rate
    model.unemployment_rate = data_row[:unemployment_rate]
    
    # Wage statistics
    data_row[:average_wage] = employed > 0 ? total_wages / employed : 0.0
    data_row[:median_wage] = employed > 0 ? median([w.wage for w in workers if w.employed]) : 0.0
    data_row[:wage_growth] = calculate_wage_growth(model)
    
    # Update model average wage
    model.average_wage = data_row[:average_wage]
    
    # Labor market tightness
    data_row[:labor_market_tightness] = model.labor_market_tightness
    
    # Job flows
    data_row[:job_creation_rate] = calculate_job_creation_rate(model)
    data_row[:job_destruction_rate] = calculate_job_destruction_rate(model)
    
    # Wage dispersion
    if employed > 1
        wages = [w.wage for w in workers if w.employed]
        data_row[:wage_std] = std(wages)
        data_row[:wage_gini] = calculate_gini_coefficient(wages)
    else
        data_row[:wage_std] = 0.0
        data_row[:wage_gini] = 0.0
    end
end

"""
    collect_financial_data!(data_row::Dict, model::KSModel)

Collect banking and financial sector data.
"""
function collect_financial_data!(data_row::Dict, model::KSModel)
    banks = [agent for agent in values(model.model.agents) if agent isa Bank]
    
    if !isempty(banks)
        # Aggregate banking variables
        data_row[:total_bank_assets] = sum(b.bank_size for b in banks)
        data_row[:total_loans] = sum(b.total_loans for b in banks)
        data_row[:total_deposits] = sum(b.total_deposits for b in banks)
        data_row[:total_bank_equity] = sum(b.equity_capital + b.retained_earnings for b in banks)
        
        # Average banking ratios
        data_row[:avg_capital_ratio] = mean(b.capital_adequacy_ratio for b in banks)
        data_row[:avg_loan_rate] = mean(b.loan_rate_base for b in banks)
        data_row[:avg_deposit_rate] = mean(b.deposit_rate for b in banks)
        
        # Banking sector health
        undercapitalized = count(b -> b.capital_adequacy_ratio < b.required_capital_ratio, banks)
        data_row[:share_undercapitalized_banks] = undercapitalized / length(banks)
        data_row[:total_loan_losses] = sum(b.loan_losses for b in banks)
        data_row[:banking_sector_roe] = mean(b.return_on_equity for b in banks)
        
        # Credit market conditions
        data_row[:credit_growth] = calculate_credit_growth(model)
        data_row[:credit_rationing_index] = calculate_credit_rationing(model)
        
        # Update model credit conditions
        model.credit_market_conditions = data_row[:credit_rationing_index]
    else
        # No banks
        for var in [:total_bank_assets, :total_loans, :total_deposits, :total_bank_equity,
                   :avg_capital_ratio, :avg_loan_rate, :avg_deposit_rate, 
                   :share_undercapitalized_banks, :total_loan_losses, :banking_sector_roe,
                   :credit_growth, :credit_rationing_index]
            data_row[var] = 0.0
        end
    end
end

"""
    collect_government_data!(data_row::Dict, model::KSModel)

Collect government fiscal and policy data.
"""
function collect_government_data!(data_row::Dict, model::KSModel)
    government = nothing
    for agent in values(model.model.agents)
        if agent isa Government
            government = agent
            break
        end
    end
    
    if government !== nothing
        # Fiscal variables
        data_row[:tax_revenue] = government.total_tax_revenue
        data_row[:government_expenditure] = government.total_expenditures
        data_row[:fiscal_balance] = government.fiscal_balance
        data_row[:government_debt] = government.cumulative_debt
        data_row[:debt_gdp_ratio] = government.debt_gdp_ratio
        
        # Update model government variables
        model.government_debt = government.cumulative_debt
        model.government_deficit = -government.fiscal_balance
        
        # Social programs
        data_row[:unemployment_benefits] = government.unemployment_benefits_paid
        data_row[:training_program_participants] = length(government.training_participants)
        data_row[:public_investment] = government.public_investment
        
        # Policy indicators
        data_row[:fiscal_rule_active] = government.fiscal_rule_active ? 1.0 : 0.0
        data_row[:automatic_stabilizers] = government.automatic_stabilizers ? 1.0 : 0.0
        data_row[:social_safety_net_generosity] = government.social_safety_net_generosity
    else
        # No government agent
        for var in [:tax_revenue, :government_expenditure, :fiscal_balance, :government_debt,
                   :debt_gdp_ratio, :unemployment_benefits, :training_program_participants,
                   :public_investment, :fiscal_rule_active, :automatic_stabilizers,
                   :social_safety_net_generosity]
            data_row[var] = 0.0
        end
    end
end

"""
    collect_firm_data!(data_row::Dict, model::KSModel)

Collect firm sector data for both sectors.
"""
function collect_firm_data!(data_row::Dict, model::KSModel)
    sector1_firms = [agent for agent in values(model.model.agents) if agent isa Firm1]
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    # Sector 1 (Capital goods) data
    if !isempty(sector1_firms)
        data_row[:sector1_output] = sum(f.actual_production for f in sector1_firms)
        data_row[:sector1_employment] = sum(length(f.employees) for f in sector1_firms)
        data_row[:sector1_avg_productivity] = mean(f.productivity for f in sector1_firms)
        data_row[:sector1_avg_price] = mean(f.price for f in sector1_firms)
        data_row[:sector1_total_profits] = sum(f.profits for f in sector1_firms)
        data_row[:sector1_rd_expenditure] = sum(f.rd_expenditure for f in sector1_firms)
        data_row[:sector1_concentration] = calculate_herfindahl_index([f.market_share for f in sector1_firms])
    else
        for var in [:sector1_output, :sector1_employment, :sector1_avg_productivity,
                   :sector1_avg_price, :sector1_total_profits, :sector1_rd_expenditure,
                   :sector1_concentration]
            data_row[var] = 0.0
        end
    end
    
    # Sector 2 (Consumption goods) data
    if !isempty(sector2_firms)
        data_row[:sector2_output] = sum(f.actual_production for f in sector2_firms)
        data_row[:sector2_employment] = sum(length(f.employees) for f in sector2_firms)
        data_row[:sector2_avg_productivity] = mean(f.productivity for f in sector2_firms)
        data_row[:sector2_avg_price] = mean(f.price for f in sector2_firms)
        data_row[:sector2_total_profits] = sum(f.profits for f in sector2_firms)
        data_row[:sector2_inventory] = sum(f.inventory for f in sector2_firms)
        data_row[:sector2_concentration] = calculate_herfindahl_index([f.market_share for f in sector2_firms])
        data_row[:sector2_avg_competitiveness] = mean(f.competitiveness for f in sector2_firms)
    else
        for var in [:sector2_output, :sector2_employment, :sector2_avg_productivity,
                   :sector2_avg_price, :sector2_total_profits, :sector2_inventory,
                   :sector2_concentration, :sector2_avg_competitiveness]
            data_row[var] = 0.0
        end
    end
    
    # Cross-sector relationships
    data_row[:capital_orders] = sum(f.capital_orders for f in sector2_firms)
    data_row[:technology_gap] = calculate_technology_gap(model)
end

"""
    collect_innovation_data!(data_row::Dict, model::KSModel)

Collect innovation and technology diffusion data.
"""
function collect_innovation_data!(data_row::Dict, model::KSModel)
    sector1_firms = [agent for agent in values(model.model.agents) if agent isa Firm1]
    
    if !isempty(sector1_firms)
        data_row[:innovation_rate] = mean(f.innovation_success ? 1.0 : 0.0 for f in sector1_firms)
        data_row[:patent_stock] = sum(length(f.patent_portfolio) for f in sector1_firms)
        data_row[:rd_intensity] = mean(f.rd_intensity for f in sector1_firms)
        data_row[:technology_frontier] = maximum(f.productivity for f in sector1_firms)
        data_row[:productivity_dispersion] = std([f.productivity for f in sector1_firms])
    else
        for var in [:innovation_rate, :patent_stock, :rd_intensity, :technology_frontier,
                   :productivity_dispersion]
            data_row[var] = 0.0
        end
    end
end

# Helper functions for data collection

"""Calculate total consumption in the economy"""
function calculate_total_consumption(model::KSModel)
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    return sum(f.revenue for f in sector2_firms)
end

"""Calculate total investment in the economy"""
function calculate_total_investment(model::KSModel)
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    return sum(f.actual_investment for f in sector2_firms)
end

"""Calculate government spending"""
function calculate_government_spending(model::KSModel)
    for agent in values(model.model.agents)
        if agent isa Government
            return agent.total_expenditures
        end
    end
    return 0.0
end

"""Calculate inflation rate based on price changes"""
function calculate_inflation_rate(model::KSModel)
    if length(model.time_series_data) == 0
        return 0.0
    end
    
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    if isempty(sector2_firms)
        return 0.0
    end
    
    current_avg_price = mean(f.price for f in sector2_firms)
    
    if length(model.time_series_data) > 0 && haskey(model.time_series_data, :sector2_avg_price)
        previous_price = model.time_series_data[end, :sector2_avg_price]
        if previous_price > 0
            return (current_avg_price - previous_price) / previous_price
        end
    end
    
    return 0.0
end

"""Calculate aggregate productivity"""
function calculate_aggregate_productivity(model::KSModel)
    sector1_firms = [agent for agent in values(model.model.agents) if agent isa Firm1]
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    total_output = 0.0
    total_employment = 0.0
    
    for firm in vcat(sector1_firms, sector2_firms)
        total_output += firm.actual_production
        total_employment += length(firm.employees)
    end
    
    return total_employment > 0 ? total_output / total_employment : 0.0
end

"""Calculate productivity growth rate"""
function calculate_productivity_growth(model::KSModel)
    if length(model.time_series_data) == 0
        return 0.0
    end
    
    current_productivity = calculate_aggregate_productivity(model)
    
    if length(model.time_series_data) > 0 && haskey(model.time_series_data, :aggregate_productivity)
        previous_productivity = model.time_series_data[end, :aggregate_productivity]
        if previous_productivity > 0
            return (current_productivity - previous_productivity) / previous_productivity
        end
    end
    
    return 0.0
end

"""Calculate wage growth rate"""
function calculate_wage_growth(model::KSModel)
    if length(model.time_series_data) == 0
        return 0.0
    end
    
    workers = [agent for agent in values(model.model.agents) if agent isa Worker && agent.employed]
    current_avg_wage = !isempty(workers) ? mean(w.wage for w in workers) : 0.0
    
    if length(model.time_series_data) > 0 && haskey(model.time_series_data, :average_wage)
        previous_wage = model.time_series_data[end, :average_wage]
        if previous_wage > 0
            return (current_avg_wage - previous_wage) / previous_wage
        end
    end
    
    return 0.0
end

"""Calculate job creation rate"""
function calculate_job_creation_rate(model::KSModel)
    # Simplified: percentage of unemployed who found jobs this period
    if length(model.time_series_data) == 0
        return 0.0
    end
    
    current_employment = sum(1 for agent in values(model.model.agents) 
                           if agent isa Worker && agent.employed)
    
    if length(model.time_series_data) > 0 && haskey(model.time_series_data, :employment_rate)
        previous_employment_rate = model.time_series_data[end, :employment_rate]
        current_employment_rate = current_employment / length([a for a in values(model.model.agents) if a isa Worker])
        return current_employment_rate - previous_employment_rate
    end
    
    return 0.0
end

"""Calculate job destruction rate"""
function calculate_job_destruction_rate(model::KSModel)
    # This would require tracking job separations - simplified for now
    return 0.0
end

"""Calculate Gini coefficient for wage distribution"""
function calculate_gini_coefficient(wages::Vector{Float64})
    if length(wages) <= 1
        return 0.0
    end
    
    n = length(wages)
    sorted_wages = sort(wages)
    
    cumulative_sum = 0.0
    gini_sum = 0.0
    
    for (i, wage) in enumerate(sorted_wages)
        cumulative_sum += wage
        gini_sum += (2 * i - n - 1) * wage
    end
    
    if cumulative_sum > 0
        return gini_sum / (n * cumulative_sum)
    else
        return 0.0
    end
end

"""Calculate credit growth rate"""
function calculate_credit_growth(model::KSModel)
    if length(model.time_series_data) == 0
        return 0.0
    end
    
    banks = [agent for agent in values(model.model.agents) if agent isa Bank]
    current_total_loans = sum(b.total_loans for b in banks)
    
    if length(model.time_series_data) > 0 && haskey(model.time_series_data, :total_loans)
        previous_loans = model.time_series_data[end, :total_loans]
        if previous_loans > 0
            return (current_total_loans - previous_loans) / previous_loans
        end
    end
    
    return 0.0
end

"""Calculate credit rationing index"""
function calculate_credit_rationing(model::KSModel)
    banks = [agent for agent in values(model.model.agents) if agent isa Bank]
    if isempty(banks)
        return 0.0
    end
    
    total_applications = sum(length(b.credit_applications) for b in banks)
    total_rejections = sum(length(b.rejected_applications) for b in banks)
    
    return total_applications > 0 ? total_rejections / total_applications : 0.0
end

"""Calculate Herfindahl-Hirschman Index for market concentration"""
function calculate_herfindahl_index(market_shares::Vector{Float64})
    return sum(share^2 for share in market_shares)
end

"""Calculate technology gap between sectors"""
function calculate_technology_gap(model::KSModel)
    sector1_firms = [agent for agent in values(model.model.agents) if agent isa Firm1]
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    if isempty(sector1_firms) || isempty(sector2_firms)
        return 0.0
    end
    
    sector1_avg_productivity = mean(f.productivity for f in sector1_firms)
    sector2_avg_productivity = mean(f.productivity for f in sector2_firms)
    
    return sector1_avg_productivity - sector2_avg_productivity
end