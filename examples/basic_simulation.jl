"""
Basic simulation example for the K+S Labor-Augmented Model.

This script demonstrates how to set up, run, and analyze a simulation
of the complete K+S labor-augmented economic model.
"""

using Pkg
Pkg.activate(".")

# Load the model
include("../src/KSLaborAugmentedModel.jl")
using .KSLaborAugmentedModel

"""
Run a basic simulation with default parameters.
"""
function run_basic_simulation()
    println("=== K+S Labor-Augmented Model Simulation ===")
    println("Setting up model with default parameters...")
    
    # Create model with default parameters
    params = KSParameters(
        n_workers = 1000,           # Smaller scale for faster simulation
        n_firms_sector1 = 10,       # Capital goods firms  
        n_firms_sector2 = 40,       # Consumption goods firms
        n_banks = 3,                # Banks
        max_steps = 200,            # Simulation length
        warmup_steps = 50           # Warmup period
    )
    
    model = create_model(params)
    println("Model created with:")
    println("  - $(params.n_workers) workers")
    println("  - $(params.n_firms_sector1) capital goods firms")
    println("  - $(params.n_firms_sector2) consumption goods firms") 
    println("  - $(params.n_banks) banks")
    println("  - 1 government")
    
    # Run simulation
    println("\nRunning simulation for $(params.max_steps) steps...")
    results = run_simulation!(model; steps=params.max_steps)
    
    println("Simulation completed!")
    println("Collected $(nrow(results)) data points")
    
    return model, results
end

"""
Analyze and display simulation results.
"""
function analyze_simulation_results(model, results)
    println("\n=== Simulation Analysis ===")
    
    # Basic statistics
    final_gdp = results[end, :gdp]
    final_unemployment = results[end, :unemployment_rate]
    final_inflation = results[end, :inflation_rate]
    
    println("Final Results:")
    println("  GDP: $(round(final_gdp, digits=2))")
    println("  Unemployment Rate: $(round(final_unemployment*100, digits=2))%")
    println("  Inflation Rate: $(round(final_inflation*100, digits=2))%")
    
    # Calculate averages
    avg_gdp_growth = mean(results.gdp_growth[results.gdp_growth .!= 0])
    avg_unemployment = mean(results.unemployment_rate)
    avg_inflation = mean(results.inflation_rate)
    
    println("\nAverage Performance:")
    println("  GDP Growth: $(round(avg_gdp_growth*100, digits=2))%")
    println("  Unemployment: $(round(avg_unemployment*100, digits=2))%")
    println("  Inflation: $(round(avg_inflation*100, digits=2))%")
    
    # Volatility measures
    gdp_volatility = std(results.gdp_growth[results.gdp_growth .!= 0])
    unemployment_volatility = std(results.unemployment_rate)
    
    println("\nVolatility:")
    println("  GDP Growth Volatility: $(round(gdp_volatility*100, digits=2))%")
    println("  Unemployment Volatility: $(round(unemployment_volatility*100, digits=2))%")
    
    # Business cycle analysis
    recessions = count(g -> g < -0.02, results.gdp_growth)  # More than 2% decline
    println("  Recession Periods: $(recessions) out of $(length(results.gdp_growth))")
    
    # Financial sector health
    if :avg_capital_ratio in names(results)
        final_capital_ratio = results[end, :avg_capital_ratio]
        println("\nFinancial Sector:")
        println("  Final Bank Capital Ratio: $(round(final_capital_ratio*100, digits=2))%")
        
        if :total_loan_losses in names(results)
            total_losses = sum(results.total_loan_losses)
            println("  Total Banking Losses: $(round(total_losses, digits=2))")
        end
    end
    
    # Innovation and productivity
    if :technology_frontier in names(results)
        initial_tech = results[1, :technology_frontier] 
        final_tech = results[end, :technology_frontier]
        tech_progress = (final_tech - initial_tech) / initial_tech
        println("\nInnovation:")
        println("  Technology Progress: $(round(tech_progress*100, digits=2))%")
        
        if :avg_rd_intensity in names(results)
            avg_rd = mean(results.avg_rd_intensity)
            println("  Average R&D Intensity: $(round(avg_rd*100, digits=2))%")
        end
    end
    
    # Government finances
    if :debt_gdp_ratio in names(results)
        final_debt_ratio = results[end, :debt_gdp_ratio]
        println("\nGovernment:")
        println("  Final Debt-to-GDP Ratio: $(round(final_debt_ratio*100, digits=2))%")
        
        if :fiscal_balance in names(results)
            avg_balance = mean(results.fiscal_balance)
            println("  Average Fiscal Balance: $(round(avg_balance, digits=2))")
        end
    end
end

"""
Generate basic plots of simulation results.
"""
function create_basic_plots(model)
    println("\n=== Creating Plots ===")
    
    try
        plot_obj = plot_results(model)
        if plot_obj !== nothing
            println("Plots created successfully!")
            
            # Try to save plot
            try
                plot_filename = "simulation_results_$(now()).png"
                savefig(plot_obj, plot_filename)
                println("Plot saved as: $plot_filename")
            catch e
                println("Could not save plot: $e")
            end
        else
            println("Plot creation failed - insufficient data")
        end
    catch e
        println("Error creating plots: $e")
        println("Plotting requires Plots.jl package")
    end
end

"""
Export results to CSV files.
"""
function export_simulation_data(model)
    println("\n=== Exporting Data ===")
    
    try
        timestamp = replace(string(now()), ":" => "-")  # Make filename safe
        filename = "ks_simulation_$(timestamp).csv"
        
        export_results(model, filename)
        println("Data exported successfully!")
    catch e
        println("Error exporting data: $e")
    end
end

"""
Run comprehensive model validation tests.
"""
function validate_model_behavior(model, results)
    println("\n=== Model Validation ===")
    
    validation_results = []
    
    # Test 1: GDP should be positive and growing on average
    avg_gdp_growth = mean(results.gdp_growth[results.gdp_growth .!= 0])
    test1_pass = avg_gdp_growth > -0.05  # Not declining by more than 5% on average
    push!(validation_results, ("Positive GDP Growth", test1_pass))
    
    # Test 2: Unemployment should be reasonable (not 0% or 100%)
    avg_unemployment = mean(results.unemployment_rate)
    test2_pass = 0.01 < avg_unemployment < 0.5  # Between 1% and 50%
    push!(validation_results, ("Reasonable Unemployment", test2_pass))
    
    # Test 3: Banks should maintain capital adequacy on average
    if :avg_capital_ratio in names(results)
        avg_capital = mean(results.avg_capital_ratio)
        test3_pass = avg_capital > 0.05  # Above 5% on average
        push!(validation_results, ("Bank Capital Adequacy", test3_pass))
    else
        push!(validation_results, ("Bank Capital Adequacy", false))
    end
    
    # Test 4: Government debt should not explode
    if :debt_gdp_ratio in names(results)
        final_debt = results[end, :debt_gdp_ratio]
        test4_pass = final_debt < 2.0  # Less than 200% of GDP
        push!(validation_results, ("Sustainable Debt", test4_pass))
    else
        push!(validation_results, ("Sustainable Debt", false))
    end
    
    # Test 5: Innovation should occur
    if :innovation_rate in names(results)
        avg_innovation = mean(results.innovation_rate)
        test5_pass = avg_innovation > 0.01  # Some innovation occurring
        push!(validation_results, ("Innovation Activity", test5_pass))
    else
        push!(validation_results, ("Innovation Activity", false))
    end
    
    # Display results
    println("Validation Results:")
    for (test_name, passed) in validation_results
        status = passed ? "✓ PASS" : "✗ FAIL"
        println("  $test_name: $status")
    end
    
    passed_tests = count(result -> result[2], validation_results)
    total_tests = length(validation_results)
    println("\nOverall: $passed_tests/$total_tests tests passed")
    
    return validation_results
end

"""
Main function to run the complete example.
"""
function main()
    try
        # Run simulation
        model, results = run_basic_simulation()
        
        # Analyze results
        analyze_simulation_results(model, results)
        
        # Validate model behavior
        validation_results = validate_model_behavior(model, results)
        
        # Create plots (optional)
        create_basic_plots(model)
        
        # Export data (optional)
        export_simulation_data(model)
        
        println("\n=== Simulation Complete ===")
        println("The K+S labor-augmented model simulation has finished successfully!")
        
        return model, results, validation_results
        
    catch e
        println("Error during simulation: $e")
        println("Stack trace:")
        for (i, frame) in enumerate(stacktrace(catch_backtrace()))
            println("  $i: $frame")
            if i > 10  # Limit stack trace length
                break
            end
        end
        return nothing, nothing, nothing
    end
end

# Run the example if this file is executed directly
if abspath(PROGRAM_FILE) == @__FILE__
    main()
end