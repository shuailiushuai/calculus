"""
Consumption goods market implementation for the K+S labor-augmented model.

Handles consumption demand, firm competition with replicator dynamics,
price setting, and market share evolution.
"""

using Agents
using Distributions
using Statistics

"""
    initialize_consumption_market!(model::KSModel)

Initialize consumption market parameters and firm market positions.
"""
function initialize_consumption_market!(model::KSModel)
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    # Initialize market shares equally
    if !isempty(sector2_firms)
        initial_share = 1.0 / length(sector2_firms)
        for firm in sector2_firms
            firm.market_share = initial_share
        end
    end
end

"""
    calculate_consumption_demand!(model::KSModel) -> Float64

Calculate total consumption demand from workers based on their budgets.
"""
function calculate_consumption_demand!(model::KSModel)
    total_demand = 0.0
    
    for worker in values(model.model.agents)
        if worker isa Worker
            total_demand += worker.consumption_budget
        end
    end
    
    return total_demand
end

"""
    update_firm_competitiveness!(firm::Firm2, model::KSModel)

Update firm competitiveness based on price, delivery capability, and quality.
"""
function update_firm_competitiveness!(firm::Firm2, model::KSModel)
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    if length(sector2_firms) <= 1
        firm.competitiveness = 1.0
        return
    end
    
    # Price competitiveness (lower price = higher competitiveness)
    avg_price = mean(f.price for f in sector2_firms)
    price_competitiveness = avg_price / firm.price
    
    # Delivery competitiveness (availability of goods)
    delivery_competitiveness = firm.inventory > 0 ? 1.0 : 0.1  # Big penalty for stockouts
    
    # Quality competitiveness (based on productivity/technology)
    max_productivity = maximum(f.productivity for f in sector2_firms)
    quality_competitiveness = max_productivity > 0 ? firm.productivity / max_productivity : 1.0
    
    # Combined competitiveness score
    firm.competitiveness = (price_competitiveness^firm.price_sensitivity * 
                           delivery_competitiveness * 
                           quality_competitiveness)
end

"""
    replicator_dynamics!(model::KSModel)

Implement replicator dynamics for market share evolution based on competitiveness.
"""
function replicator_dynamics!(model::KSModel)
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    if length(sector2_firms) <= 1
        return
    end
    
    # Calculate average competitiveness
    total_competitiveness = sum(f.competitiveness for f in sector2_firms)
    avg_competitiveness = total_competitiveness / length(sector2_firms)
    
    # Update market shares using replicator dynamics
    speed = model.params.replicator_dynamics_speed
    
    for firm in sector2_firms
        # Market share change proportional to competitiveness advantage
        competitiveness_advantage = firm.competitiveness - avg_competitiveness
        share_change = speed * firm.market_share * competitiveness_advantage / avg_competitiveness
        
        firm.market_share += share_change
    end
    
    # Normalize market shares to sum to 1
    total_share = sum(f.market_share for f in sector2_firms)
    if total_share > 0
        for firm in sector2_firms
            firm.market_share /= total_share
        end
    end
    
    # Apply minimum market share threshold - exit if too small
    for firm in sector2_firms
        if firm.market_share < model.params.market_share_threshold
            # Mark for exit (will be handled in entry_exit_phase!)
            firm.market_share = 0.0
        end
    end
end

"""
    allocate_consumption_demand!(model::KSModel, total_demand::Float64)

Allocate consumption demand to firms based on market shares and availability.
"""
function allocate_consumption_demand!(model::KSModel, total_demand::Float64)
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    # Reset demand for all firms
    for firm in sector2_firms
        firm.demand_received = 0.0
        firm.unfilled_demand = 0.0
    end
    
    if isempty(sector2_firms) || total_demand <= 0
        return
    end
    
    # First allocation based on market shares
    for firm in sector2_firms
        firm.demand_received = total_demand * firm.market_share
    end
    
    # Second pass: reallocate unfilled demand due to stockouts
    remaining_demand = 0.0
    available_firms = []
    
    for firm in sector2_firms
        if firm.inventory < firm.demand_received
            # Firm cannot satisfy all demand
            firm.unfilled_demand = firm.demand_received - firm.inventory
            firm.demand_received = firm.inventory  # Can only satisfy what's in stock
            remaining_demand += firm.unfilled_demand
        else
            # Firm has sufficient inventory
            push!(available_firms, firm)
        end
    end
    
    # Reallocate unfilled demand to firms with available inventory
    if remaining_demand > 0 && !isempty(available_firms)
        available_capacity = sum(max(0, f.inventory - f.demand_received) for f in available_firms)
        
        if available_capacity > 0
            for firm in available_firms
                additional_capacity = max(0, firm.inventory - firm.demand_received)
                additional_demand = remaining_demand * (additional_capacity / available_capacity)
                
                firm.demand_received += min(additional_demand, additional_capacity)
            end
        end
    end
end

"""
    execute_consumption_transactions!(model::KSModel)

Execute consumption transactions between workers and firms.
"""
function execute_consumption_transactions!(model::KSModel)
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    workers = [agent for agent in values(model.model.agents) if agent isa Worker]
    
    # Calculate total worker consumption budget
    total_budget = sum(w.consumption_budget for w in workers)
    
    if total_budget <= 0
        return
    end
    
    # Execute transactions with firms
    for firm in sector2_firms
        if firm.demand_received > 0 && firm.inventory >= firm.demand_received
            # Firm can satisfy demand
            revenue = firm.demand_received
            
            # Update firm finances
            firm.cash += revenue
            firm.revenue += revenue
            firm.inventory -= firm.demand_received
            
            # Distribute consumption cost among workers proportionally
            for worker in workers
                if worker.consumption_budget > 0
                    worker_share = worker.consumption_budget / total_budget
                    worker_cost = revenue * worker_share
                    
                    # Worker pays from consumption budget
                    actual_payment = min(worker_cost, worker.consumption_budget)
                    worker.consumption_budget -= actual_payment
                end
            end
        end
    end
    
    # Handle unsatisfied demand (consumers save money instead)
    for worker in workers
        if worker.consumption_budget > 0
            # Unspent consumption budget goes to savings
            worker.savings += worker.consumption_budget
            worker.consumption_budget = 0.0
        end
    end
end

"""
    update_prices!(model::KSModel)

Update firm prices based on demand conditions and competition.
"""
function update_prices!(model::KSModel)
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    for firm in sector2_firms
        # Price adjustment based on inventory and demand
        if firm.inventory < firm.desired_inventory
            # Low inventory - increase price
            price_increase = 0.02 * (1.0 - firm.inventory / firm.desired_inventory)
            firm.price *= (1.0 + price_increase)
        elseif firm.inventory > firm.desired_inventory * 1.5
            # Excess inventory - decrease price
            price_decrease = 0.02 * (firm.inventory / firm.desired_inventory - 1.0)
            firm.price *= (1.0 - min(0.1, price_decrease))  # Max 10% decrease
        end
        
        # Competition-based pricing
        if length(sector2_firms) > 1
            other_firms = filter(f -> f.id != firm.id, sector2_firms)
            avg_competitor_price = mean(f.price for f in other_firms)
            
            # Adjust towards competitive price
            price_gap = avg_competitor_price - firm.price
            firm.price += 0.1 * price_gap  # 10% adjustment towards competitors
        end
        
        # Ensure minimum profitability
        marginal_cost = calculate_marginal_cost(firm, model)
        min_price = marginal_cost * 1.1  # 10% markup minimum
        firm.price = max(firm.price, min_price)
    end
end

"""
    calculate_marginal_cost(firm::Firm2, model::KSModel) -> Float64

Calculate the marginal cost of production for a Sector 2 firm.
"""
function calculate_marginal_cost(firm::Firm2, model::KSModel)
    # Labor cost per unit
    labor_cost_per_unit = 0.0
    if firm.productivity > 0 && !isempty(firm.employees)
        total_wage_cost = sum(model.model[worker_id].wage for worker_id in firm.employees)
        labor_cost_per_unit = total_wage_cost / (firm.productivity * length(firm.employees))
    end
    
    # Capital cost per unit (depreciation and interest)
    capital_cost_per_unit = 0.0
    if firm.capital_stock > 0 && firm.productivity > 0
        depreciation_rate = 0.05 / 12  # 5% annual depreciation
        interest_rate = model.params.interest_rate_loans
        capital_cost_per_unit = firm.capital_stock * (depreciation_rate + interest_rate) / 
                               (firm.productivity * firm.capital_stock)
    end
    
    # Material costs (simplified)
    material_cost_per_unit = 0.1  # Fixed material cost
    
    return labor_cost_per_unit + capital_cost_per_unit + material_cost_per_unit
end

"""
    production_phase!(model::KSModel)

Execute production phase for all firms.
"""
function production_phase!(model::KSModel)
    # Sector 1 production (capital goods)
    for firm in values(model.model.agents)
        if firm isa Firm1
            # Production based on orders and capacity
            labor_constraint = length(firm.employees) * firm.productivity
            capacity_constraint = firm.production_capacity
            
            firm.actual_production = min(firm.orders_received, 
                                       min(labor_constraint, capacity_constraint))
            
            # Calculate costs
            if !isempty(firm.employees)
                firm.labor_cost = sum(model.model[worker_id].wage for worker_id in firm.employees)
            end
            
            firm.costs = firm.labor_cost + firm.rd_expenditure
            firm.profits = firm.revenue - firm.costs
        end
    end
    
    # Sector 2 production (consumption goods)
    for firm in values(model.model.agents)
        if firm isa Firm2
            # Determine production quantity
            desired_production = max(0, firm.desired_inventory - firm.inventory + firm.demand_received)
            
            labor_constraint = length(firm.employees) * firm.productivity
            capacity_constraint = firm.production_capacity
            
            firm.actual_production = min(desired_production,
                                       min(labor_constraint, capacity_constraint))
            
            # Update inventory
            firm.inventory += firm.actual_production
            
            # Calculate costs
            if !isempty(firm.employees)
                firm.labor_cost = sum(model.model[worker_id].wage for worker_id in firm.employees)
            end
            
            # Capital costs (simplified)
            capital_costs = firm.capital_stock * 0.01  # 1% per period
            
            firm.costs = firm.labor_cost + capital_costs
            firm.profits = firm.revenue - firm.costs
            
            # Distribute bonuses to workers if profitable
            if firm.profits > 0 && firm.bonus_budget > 0
                distribute_worker_bonuses!(firm, model)
            end
        end
    end
end

"""
    distribute_worker_bonuses!(firm::Firm2, model::KSModel)

Distribute bonuses to workers in profitable Sector 2 firms.
"""
function distribute_worker_bonuses!(firm::Firm2, model::KSModel)
    if isempty(firm.employees) || firm.bonus_budget <= 0
        return
    end
    
    # Calculate bonus pool based on profits and budget
    available_bonus = min(firm.bonus_budget, firm.profits * 0.2)  # Max 20% of profits
    
    if available_bonus <= 0
        return
    end
    
    # Distribute bonuses based on worker performance and tenure
    total_weight = 0.0
    worker_weights = Dict{Int, Float64}()
    
    for worker_id in firm.employees
        worker = model.model[worker_id]
        
        # Weight based on skill level and employment duration
        weight = worker.skill_level * (1.0 + 0.01 * worker.employment_duration)
        worker_weights[worker_id] = weight
        total_weight += weight
    end
    
    # Distribute bonuses
    if total_weight > 0
        for worker_id in firm.employees
            worker = model.model[worker_id]
            worker_share = worker_weights[worker_id] / total_weight
            bonus_amount = available_bonus * worker_share
            
            worker.bonus_received = bonus_amount
            worker.savings += bonus_amount
        end
        
        # Deduct bonus from firm cash
        firm.cash -= available_bonus
    end
end

"""
    consumption_market_phase!(model::KSModel)

Execute the complete consumption goods market phase.
"""
function consumption_market_phase!(model::KSModel)
    # Step 1: Calculate total consumption demand
    total_demand = calculate_consumption_demand!(model)
    
    # Step 2: Update firm competitiveness
    for firm in values(model.model.agents)
        if firm isa Firm2
            update_firm_competitiveness!(firm, model)
        end
    end
    
    # Step 3: Apply replicator dynamics to market shares
    replicator_dynamics!(model)
    
    # Step 4: Allocate demand to firms
    allocate_consumption_demand!(model, total_demand)
    
    # Step 5: Execute transactions
    execute_consumption_transactions!(model)
    
    # Step 6: Update prices for next period
    update_prices!(model)
end