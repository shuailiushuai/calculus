"""
Capital goods market implementation for the K+S labor-augmented model.

Handles capital goods production, supplier selection, investment decisions,
and technology diffusion between Sector 1 and Sector 2 firms.
"""

using Agents
using Distributions
using Statistics

"""
    initialize_capital_market!(model::KSModel)

Initialize capital market parameters and supplier relationships.
"""
function initialize_capital_market!(model::KSModel)
    # Assign initial suppliers to Sector 2 firms
    sector1_firms = [agent for agent in values(model.model.agents) if agent isa Firm1]
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    for firm2 in sector2_firms
        if !isempty(sector1_firms)
            # Assign random initial supplier
            supplier = rand(sector1_firms)
            firm2.supplier_id = supplier.id
            push!(supplier.customers, firm2.id)
        end
    end
end

"""
    update_capital_productivity!(capital_age::Vector{Int}, sector1_productivity::Float64) -> Float64

Calculate the productivity of capital stock based on age distribution and technology.
"""
function update_capital_productivity!(capital_age::Vector{Int}, sector1_productivity::Float64)
    if isempty(capital_age)
        return 1.0
    end
    
    # Newer capital is more productive
    total_weight = 0.0
    productivity_sum = 0.0
    
    for age in capital_age
        # Capital depreciates in productivity over time
        productivity = sector1_productivity * exp(-0.05 * age)
        weight = 1.0 / (1.0 + age)  # Newer capital has higher weight
        
        productivity_sum += productivity * weight
        total_weight += weight
    end
    
    return total_weight > 0 ? productivity_sum / total_weight : 1.0
end

"""
    evaluate_suppliers!(firm2::Firm2, model::KSModel)

Evaluate potential suppliers based on price, quality, and delivery performance.
"""
function evaluate_suppliers!(firm2::Firm2, model::KSModel)
    sector1_firms = [agent for agent in values(model.model.agents) if agent isa Firm1]
    
    if isempty(sector1_firms)
        return
    end
    
    # Evaluate current supplier performance
    current_supplier_score = 0.0
    if firm2.supplier_id !== nothing && haskey(model.model.agents, firm2.supplier_id)
        current_supplier = model.model.agents[firm2.supplier_id]
        current_supplier_score = evaluate_supplier_performance(firm2, current_supplier, model)
    end
    
    # Evaluate alternative suppliers
    best_alternative = nothing
    best_alternative_score = current_supplier_score
    
    for supplier in sector1_firms
        if supplier.id != firm2.supplier_id
            score = evaluate_supplier_performance(firm2, supplier, model)
            
            # Add switching cost penalty
            switching_penalty = 0.1  # 10% penalty for switching
            adjusted_score = score - switching_penalty
            
            if adjusted_score > best_alternative_score
                best_alternative = supplier
                best_alternative_score = adjusted_score
            end
        end
    end
    
    # Switch supplier if significantly better alternative exists
    if best_alternative !== nothing && best_alternative_score > current_supplier_score * 1.05
        # Remove from current supplier's customer list
        if firm2.supplier_id !== nothing && haskey(model.model.agents, firm2.supplier_id)
            current_supplier = model.model.agents[firm2.supplier_id]
            filter!(id -> id != firm2.id, current_supplier.customers)
        end
        
        # Switch to new supplier
        firm2.supplier_id = best_alternative.id
        push!(best_alternative.customers, firm2.id)
        
        println("Firm $(firm2.id) switched supplier from $(firm2.supplier_id) to $(best_alternative.id)")
    end
end

"""
    evaluate_supplier_performance(firm2::Firm2, supplier::Firm1, model::KSModel) -> Float64

Evaluate a supplier's performance based on multiple criteria.
"""
function evaluate_supplier_performance(firm2::Firm2, supplier::Firm1, model::KSModel)
    score = 0.0
    
    # Price competitiveness (30% weight)
    if !isempty([f for f in values(model.model.agents) if f isa Firm1])
        avg_sector1_price = mean(f.price for f in values(model.model.agents) if f isa Firm1)
        price_score = avg_sector1_price / supplier.price  # Higher score for lower prices
        score += price_score * 0.3
    end
    
    # Technology/productivity quality (40% weight)
    max_productivity = maximum(f.productivity for f in values(model.model.agents) if f isa Firm1)
    if max_productivity > 0
        quality_score = supplier.productivity / max_productivity
        score += quality_score * 0.4
    end
    
    # Delivery reliability (20% weight)
    delivery_score = 1.0 / (1.0 + supplier.delivery_delay)
    score += delivery_score * 0.2
    
    # Financial stability/reputation (10% weight)
    if supplier.profits > 0 && supplier.cash > 0
        stability_score = min(1.0, supplier.cash / 10000.0)
        score += stability_score * 0.1
    end
    
    return score
end

"""
    process_capital_orders!(model::KSModel)

Process capital goods orders from Sector 2 to Sector 1 firms.
"""
function process_capital_orders!(model::KSModel)
    sector1_firms = [agent for agent in values(model.model.agents) if agent isa Firm1]
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    # Clear previous orders
    for firm1 in sector1_firms
        firm1.orders_received = 0.0
    end
    
    # Process orders from Sector 2 firms
    for firm2 in sector2_firms
        if firm2.capital_orders > 0 && firm2.supplier_id !== nothing
            if haskey(model.model.agents, firm2.supplier_id)
                supplier = model.model.agents[firm2.supplier_id]
                supplier.orders_received += firm2.capital_orders
            end
        end
    end
    
    # Sector 1 firms adjust production based on orders
    for firm1 in sector1_firms
        # Production capacity constraint
        max_production = firm1.production_capacity
        firm1.actual_production = min(firm1.orders_received, max_production)
        
        # Update inventory
        firm1.inventory += firm1.actual_production
    end
end

"""
    execute_capital_deliveries!(model::KSModel)

Execute capital goods deliveries and update Sector 2 capital stocks.
"""
function execute_capital_deliveries!(model::KSModel)
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    for firm2 in sector2_firms
        if firm2.capital_orders > 0 && firm2.supplier_id !== nothing
            if haskey(model.model.agents, firm2.supplier_id)
                supplier = model.model.agents[firm2.supplier_id]
                
                # Check if supplier can deliver
                delivery_amount = min(firm2.capital_orders, supplier.inventory)
                
                if delivery_amount > 0
                    # Calculate payment
                    total_cost = delivery_amount * supplier.price
                    
                    if firm2.cash >= total_cost
                        # Execute transaction
                        firm2.cash -= total_cost
                        supplier.cash += total_cost
                        supplier.revenue += total_cost
                        supplier.inventory -= delivery_amount
                        
                        # Update Sector 2 firm's capital stock
                        firm2.capital_stock += delivery_amount
                        firm2.actual_investment = delivery_amount
                        
                        # Update capital age distribution (new capital has age 0)
                        new_capital_units = round(Int, delivery_amount / 100)  # Normalize
                        for _ in 1:new_capital_units
                            push!(firm2.capital_age_distribution, 0)
                        end
                        
                        # Update firm2's productivity based on new capital
                        firm2.productivity = update_capital_productivity!(
                            firm2.capital_age_distribution, supplier.productivity)
                        
                        # Update production capacity
                        firm2.production_capacity = firm2.capital_stock * firm2.productivity
                    end
                end
            end
        end
        
        # Reset orders for next period
        firm2.capital_orders = 0.0
    end
end

"""
    age_capital_stock!(firm2::Firm2, model::KSModel)

Age the capital stock and remove obsolete capital.
"""
function age_capital_stock!(firm2::Firm2, model::KSModel)
    # Age all capital by one period
    firm2.capital_age_distribution .+= 1
    
    # Remove capital that's too old (over 20 years)
    max_age = 240  # 20 years in months
    old_capital_count = count(age -> age > max_age, firm2.capital_age_distribution)
    
    if old_capital_count > 0
        # Remove old capital
        firm2.capital_age_distribution = filter(age -> age <= max_age, firm2.capital_age_distribution)
        
        # Reduce capital stock
        capital_per_unit = firm2.capital_stock / length(firm2.capital_age_distribution + old_capital_count)
        firm2.capital_stock -= old_capital_count * capital_per_unit
        firm2.capital_stock = max(0.0, firm2.capital_stock)
        
        # Update production capacity
        if firm2.supplier_id !== nothing && haskey(model.model.agents, firm2.supplier_id)
            supplier = model.model.agents[firm2.supplier_id]
            firm2.productivity = update_capital_productivity!(
                firm2.capital_age_distribution, supplier.productivity)
        end
        
        firm2.production_capacity = firm2.capital_stock * firm2.productivity
    end
end

"""
    technology_diffusion!(model::KSModel)

Implement technology diffusion through capital goods purchases.
"""
function technology_diffusion!(model::KSModel)
    sector1_firms = [agent for agent in values(model.model.agents) if agent isa Firm1]
    sector2_firms = [agent for agent in values(model.model.agents) if agent isa Firm2]
    
    if isempty(sector1_firms)
        return
    end
    
    # Find best technology in Sector 1
    best_technology = maximum(f.productivity for f in sector1_firms)
    
    # Sector 2 firms benefit from their supplier's technology
    for firm2 in sector2_firms
        if firm2.supplier_id !== nothing && haskey(model.model.agents, firm2.supplier_id)
            supplier = model.model.agents[firm2.supplier_id]
            
            # Technology spillover from supplier
            spillover_rate = 0.02  # 2% per period
            technology_gap = supplier.productivity - firm2.productivity
            
            if technology_gap > 0
                productivity_gain = technology_gap * spillover_rate
                firm2.productivity += productivity_gain
                firm2.production_capacity = firm2.capital_stock * firm2.productivity
            end
        end
    end
end

"""
    sector1_innovation_competition!(model::KSModel)

Handle innovation competition and patent dynamics in Sector 1.
"""
function sector1_innovation_competition!(model::KSModel)
    sector1_firms = [agent for agent in values(model.model.agents) if agent isa Firm1]
    
    # Innovation race - firms compete for technology leadership
    for firm in sector1_firms
        if firm.innovation_success
            # Successful innovator gains market share
            productivity_advantage = firm.productivity / mean(f.productivity for f in sector1_firms)
            
            if productivity_advantage > 1.1  # 10% advantage
                # Gain market share from less productive competitors
                market_share_gain = min(0.05, (productivity_advantage - 1.0) * 0.1)
                firm.market_share += market_share_gain
                
                # Other firms lose market share proportionally
                total_other_share = sum(f.market_share for f in sector1_firms if f.id != firm.id)
                if total_other_share > 0
                    loss_proportion = market_share_gain / total_other_share
                    
                    for other_firm in sector1_firms
                        if other_firm.id != firm.id
                            other_firm.market_share *= (1.0 - loss_proportion)
                        end
                    end
                end
            end
        end
    end
    
    # Normalize market shares
    total_share = sum(f.market_share for f in sector1_firms)
    if total_share > 0
        for firm in sector1_firms
            firm.market_share /= total_share
        end
    end
end

"""
    capital_market_phase!(model::KSModel)

Execute the complete capital market phase.
"""
function capital_market_phase!(model::KSModel)
    # Step 1: Evaluate and potentially switch suppliers
    for firm in values(model.model.agents)
        if firm isa Firm2
            evaluate_suppliers!(firm, model)
        end
    end
    
    # Step 2: Process capital goods orders
    process_capital_orders!(model)
    
    # Step 3: Execute deliveries and update capital stocks
    execute_capital_deliveries!(model)
    
    # Step 4: Age capital stock
    for firm in values(model.model.agents)
        if firm isa Firm2
            age_capital_stock!(firm, model)
        end
    end
    
    # Step 5: Technology diffusion
    technology_diffusion!(model)
    
    # Step 6: Innovation competition in Sector 1
    sector1_innovation_competition!(model)
end