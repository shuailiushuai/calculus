"""
Labor market implementation for the K+S labor-augmented model.

Handles job search, application processing, matching between workers and firms,
and wage determination with complete search probabilities and queue-based processing.
"""

using Agents
using Distributions
using Statistics
using StatsBase

"""
    initialize_labor_market!(model::KSModel)

Initialize labor market parameters and structures.
"""
function initialize_labor_market!(model::KSModel)
    # Labor market is primarily coordinated through agent interactions
    # This function sets up any global labor market parameters
    model.labor_market_tightness = 1.0  # Initialize to neutral
end

"""
    calculate_search_probabilities!(model::KSModel)

Calculate job search probabilities based on market tightness and worker characteristics.
"""
function calculate_search_probabilities!(model::KSModel)
    # Count unemployed workers and job vacancies
    unemployed_workers = 0
    total_vacancies = 0
    
    for agent in values(model.model.agents)
        if agent isa Worker && !agent.employed && !agent.discouraged
            unemployed_workers += 1
        elseif agent isa Firm1 || agent isa Firm2
            vacancies = max(0, agent.labor_demand - length(agent.employees))
            total_vacancies += vacancies
        end
    end
    
    # Calculate market tightness (vacancies per unemployed worker)
    if unemployed_workers > 0
        model.labor_market_tightness = total_vacancies / unemployed_workers
    else
        model.labor_market_tightness = 0.0
    end
    
    return model.labor_market_tightness
end

"""
    worker_job_search!(worker::Worker, model::KSModel)

Implement worker job search behavior with application decisions and targeting.
"""
function worker_job_search!(worker::Worker, model::KSModel)
    if worker.employed || worker.discouraged
        return
    end
    
    # Clear previous period applications
    empty!(worker.job_offers_received)
    worker.applications_sent = 0
    
    # Determine search intensity based on unemployment duration and benefits
    base_search_intensity = model.params.worker_search_intensity
    
    # Increase search intensity if:
    # - Longer unemployment
    # - Lower savings
    # - Higher reservation wage vs market wages
    if worker.savings < 500.0
        base_search_intensity *= 1.5  # More desperate search
    end
    
    if length(worker.wage_memory) > 0
        avg_market_wage = mean(worker.wage_memory)
        if worker.reservation_wage > avg_market_wage * 1.2
            base_search_intensity *= 0.7  # Less search if reservation wage too high
        end
    end
    
    # Search probability based on market tightness
    search_success_prob = min(0.8, base_search_intensity * (1.0 + model.labor_market_tightness))
    
    if rand() > search_success_prob
        return  # No search this period
    end
    
    # Find firms with vacancies
    firms_with_vacancies = []
    for agent in values(model.model.agents)
        if (agent isa Firm1 || agent isa Firm2)
            vacancies = max(0, agent.labor_demand - length(agent.employees))
            if vacancies > 0
                push!(firms_with_vacancies, agent)
            end
        end
    end
    
    if isempty(firms_with_vacancies)
        return  # No vacancies available
    end
    
    # Worker applies to multiple firms (1-5 applications)
    max_applications = min(5, length(firms_with_vacancies))
    num_applications = rand(1:max_applications)
    
    # Select firms to apply to (prefer nearby firms and those with higher wages)
    selected_firms = select_target_firms(worker, firms_with_vacancies, num_applications, model)
    
    for firm in selected_firms
        # Submit application
        wage_request = calculate_wage_request(worker, firm, model)
        push!(firm.hiring_queue, (worker.id, wage_request))
        worker.applications_sent += 1
        
        # Update worker's wage memory with requested wage
        update_wage_memory!(worker, wage_request)
    end
end

"""
    select_target_firms(worker::Worker, available_firms::Vector, num_applications::Int, model::KSModel) -> Vector

Select which firms the worker will apply to based on distance, wage expectations, and firm characteristics.
"""
function select_target_firms(worker::Worker, available_firms::Vector, num_applications::Int, model::KSModel)
    if length(available_firms) <= num_applications
        return available_firms
    end
    
    # Score firms based on multiple criteria
    firm_scores = []
    for firm in available_firms
        score = 0.0
        
        # Distance factor (prefer closer firms)
        distance = sqrt((worker.pos[1] - firm.pos[1])^2 + (worker.pos[2] - firm.pos[2])^2)
        distance_score = 1.0 / (1.0 + distance / 20.0)  # Normalized distance penalty
        score += distance_score * 0.3
        
        # Wage factor (prefer higher-paying firms)
        wage_score = firm.avg_wage / maximum(f.avg_wage for f in available_firms)
        score += wage_score * 0.4
        
        # Firm size/stability factor (prefer larger, more stable firms)
        size_score = length(firm.employees) / maximum(length(f.employees) + 1 for f in available_firms)
        score += size_score * 0.2
        
        # Sector preference (workers might prefer certain sectors)
        if firm isa Firm2 && worker.skill_level > 0.7
            score += 0.1  # Skilled workers prefer consumer goods sector
        elseif firm isa Firm1 && worker.skill_level < 0.5
            score += 0.1  # Less skilled workers prefer capital goods sector
        end
        
        push!(firm_scores, (firm, score))
    end
    
    # Sort by score and select top firms
    sorted_firms = sort(firm_scores, by = x -> x[2], rev = true)
    return [firm for (firm, score) in sorted_firms[1:num_applications]]
end

"""
    calculate_wage_request(worker::Worker, firm::Union{Firm1, Firm2}, model::KSModel) -> Float64

Calculate the wage the worker will request from a specific firm.
"""
function calculate_wage_request(worker::Worker, firm::Union{Firm1, Firm2}, model::KSModel)
    # Base request on reservation wage
    base_request = worker.reservation_wage
    
    # Adjust based on firm characteristics
    if firm.avg_wage > base_request
        # Firm pays above reservation - request premium
        premium = (firm.avg_wage - base_request) * model.params.wage_bargaining_power
        base_request += premium
    end
    
    # Adjust based on worker skill relative to firm's current workforce
    if !isempty(firm.employees)
        avg_firm_skill = mean(model.model[emp_id].skill_level for emp_id in firm.employees)
        if worker.skill_level > avg_firm_skill
            base_request *= (1.0 + 0.1 * (worker.skill_level - avg_firm_skill))
        end
    end
    
    # Sector-specific adjustments
    if firm isa Firm2
        # Consumption goods sector - potential for bonuses
        base_request *= 0.95  # Accept slightly lower base wage for bonus potential
    elseif firm isa Firm1
        # Capital goods sector - more stable employment
        base_request *= 1.02  # Request premium for stability
    end
    
    # Add small random component
    base_request *= (0.95 + 0.1 * rand())
    
    return max(0.5, base_request)  # Minimum wage floor
end

"""
    labor_market_phase!(model::KSModel)

Coordinate the complete labor market phase including search, applications, and matching.
"""
function labor_market_phase!(model::KSModel)
    # Step 1: Calculate market conditions
    market_tightness = calculate_search_probabilities!(model)
    
    # Step 2: Workers search for jobs and submit applications
    for worker in values(model.model.agents)
        if worker isa Worker
            worker_job_search!(worker, model)
        end
    end
    
    # Step 3: Firms process hiring queues and make offers
    for firm in values(model.model.agents)
        if firm isa Firm1 || firm isa Firm2
            process_hiring_queue!(firm, model)
        end
    end
    
    # Step 4: Workers evaluate offers and make decisions
    process_job_offers!(model)
    
    # Step 5: Execute final hiring decisions
    for firm in values(model.model.agents)
        if firm isa Firm1 || firm isa Firm2
            execute_hiring_decisions!(firm, model)
        end
    end
    
    # Step 6: Update labor market statistics
    update_labor_market_statistics!(model)
end

"""
    process_job_offers!(model::KSModel)

Process job offers and worker acceptance decisions.
"""
function process_job_offers!(model::KSModel)
    for worker in values(model.model.agents)
        if worker isa Worker && !worker.employed && !isempty(worker.job_offers_received)
            # Worker has received offers - decide which to accept
            best_offer = nothing
            best_wage = 0.0
            
            for (firm_id, offered_wage) in worker.job_offers_received
                if offered_wage >= worker.reservation_wage && offered_wage > best_wage
                    best_offer = firm_id
                    best_wage = offered_wage
                end
            end
            
            if best_offer !== nothing
                # Accept best offer
                # The actual hiring will be processed in execute_hiring_decisions!
                # Here we just mark the worker's preference
                worker.job_offers_received = [(best_offer, best_wage)]
            else
                # Reject all offers - they don't meet reservation wage
                empty!(worker.job_offers_received)
            end
        end
    end
end

"""
    update_labor_market_statistics!(model::KSModel)

Update aggregate labor market statistics and indicators.
"""
function update_labor_market_statistics!(model::KSModel)
    employed_workers = 0
    unemployed_workers = 0
    discouraged_workers = 0
    total_wages = 0.0
    job_seekers = 0
    
    for worker in values(model.model.agents)
        if worker isa Worker
            if worker.employed
                employed_workers += 1
                total_wages += worker.wage
            elseif worker.discouraged
                discouraged_workers += 1
            else
                unemployed_workers += 1
                if worker.applications_sent > 0
                    job_seekers += 1
                end
            end
        end
    end
    
    total_workers = employed_workers + unemployed_workers + discouraged_workers
    
    # Update model statistics
    if total_workers > 0
        model.unemployment_rate = unemployed_workers / total_workers
    else
        model.unemployment_rate = 0.0
    end
    
    if employed_workers > 0
        model.average_wage = total_wages / employed_workers
    else
        model.average_wage = 0.0
    end
    
    # Labor market tightness already calculated in calculate_search_probabilities!
end

"""
    production_planning_phase!(model::KSModel)

Phase 1: Firms plan production and determine labor demand.
"""
function production_planning_phase!(model::KSModel)
    for firm in values(model.model.agents)
        if firm isa Firm1 || firm isa Firm2
            calculate_labor_demand!(firm, model)
        end
    end
end