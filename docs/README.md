# K+S Labor-Augmented Economic Model

A comprehensive implementation of the Dosi, Fagiolo, and Roventini (2010) K+S labor-augmented agent-based macroeconomic model in Julia using the Agents.jl framework.

## Overview

This model implements a complete agent-based macroeconomic system featuring:

- **Heterogeneous Workers** with reservation wage dynamics, employment contracts, and job search behavior
- **Heterogeneous Firms** in capital goods (Sector 1) and consumption goods (Sector 2) sectors
- **Banks** with capital adequacy requirements and credit rationing mechanisms  
- **Government** with fiscal policy, unemployment benefits, and training programs
- **Complex Market Interactions** including labor, capital, and consumption goods markets
- **Innovation and Technology Diffusion** through R&D and capital goods purchases
- **Financial Stability** mechanisms including bank bailouts and regulatory intervention

## Key Features

### Worker Behavior
- **Reservation Wage Dynamics**: Workers adapt reservation wages based on job market experience
- **Satisficing Wage Calculation**: Memory-based wage expectations with exponential weighting
- **Employment Contracts**: Fixed-term contracts with protection periods
- **Discouragement Mechanism**: Workers can become discouraged after prolonged unemployment
- **Skill-based Matching**: Workers' skills affect hiring probabilities and wages
- **Tax Payment**: Progressive income taxation on wages and bonuses

### Firm Operations
- **Hiring/Firing Rules**: Seven different firing rules (0-6) including work-sharing
- **Production Planning**: Capacity-constrained production with labor demand forecasting
- **Innovation (Sector 1)**: R&D activities with patent protection and technology spillovers
- **Market Competition (Sector 2)**: Replicator dynamics for market share evolution
- **Supplier Selection**: Capital goods firms compete on price, quality, and delivery
- **Investment Decisions**: Endogenous capital investment based on demand conditions

### Banking System
- **Capital Adequacy**: Basel-like capital requirements with risk-weighted assets
- **Credit Scoring**: Firm-specific risk assessment and interest rate determination
- **Credit Rationing**: Lending constrained by capital adequacy and risk standards
- **Deposit Collection**: Worker savings automatically flow to bank deposits
- **Bailout Mechanisms**: Government intervention for systemically important banks

### Government Policy
- **Fiscal Rules**: Automatic stabilizers and debt sustainability constraints  
- **Unemployment Benefits**: Duration-limited benefits with replacement rates
- **Training Programs**: Government-sponsored skill enhancement programs
- **Tax Collection**: Progressive taxation on workers and corporate profits
- **Public Investment**: Infrastructure spending with productivity spillovers

### Market Mechanisms
- **Labor Market**: Job search with application queues and wage bargaining
- **Capital Market**: Supplier competition with technology diffusion
- **Consumption Market**: Demand allocation with replicator dynamics
- **Credit Market**: Bank-firm lending relationships with risk assessment

## Installation and Setup

### Requirements
- Julia 1.9 or higher
- Required packages (automatically installed):
  - Agents.jl 6.2.9
  - DataFrames.jl
  - Distributions.jl
  - Statistics.jl
  - StatsBase.jl
  - LinearAlgebra.jl
  - Plots.jl (optional, for visualization)

### Installation
```julia
# Clone or download the repository
# Navigate to the model directory
cd("path/to/calculus")

# Activate the project environment
using Pkg
Pkg.activate(".")
Pkg.instantiate()  # Install all dependencies
```

## Usage

### Basic Simulation
```julia
# Load the model
include("src/KSLaborAugmentedModel.jl")
using .KSLaborAugmentedModel

# Create model with default parameters
model = create_model()

# Run simulation for 1000 steps
results = run_simulation!(model; steps=1000)

# Analyze results
analysis = analyze_results(model)
println(analysis)

# Create plots
plot_results(model; save_path="results.png")

# Export data
export_results(model, "simulation_data.csv")
```

### Custom Parameters
```julia
# Define custom parameters
params = KSParameters(
    n_workers = 5000,
    n_firms_sector1 = 25,
    n_firms_sector2 = 100,
    n_banks = 5,
    max_steps = 2000,
    warmup_steps = 200,
    unemployment_benefit_rate = 0.5,
    bank_capital_ratio = 0.10,
    sector1_rd_intensity = 0.05
)

# Create and run model
model = create_model(params)
results = run_simulation!(model; steps=params.max_steps)
```

### Running the Example
```julia
# Run the comprehensive example
include("examples/basic_simulation.jl")
model, results, validation = main()
```

## Model Parameters

### Basic Model Dimensions
- `n_workers::Int = 10000` - Number of worker agents
- `n_firms_sector1::Int = 50` - Number of capital goods firms  
- `n_firms_sector2::Int = 200` - Number of consumption goods firms
- `n_banks::Int = 10` - Number of bank agents
- `max_steps::Int = 1000` - Simulation length
- `warmup_steps::Int = 100` - Warmup period

### Worker Parameters  
- `worker_memory_length::Int = 26` - Periods workers remember wages
- `reservation_wage_adaptation::Float64 = 0.02` - Reservation wage adjustment speed
- `unemployment_benefit_rate::Float64 = 0.4` - Unemployment benefit replacement rate
- `worker_search_intensity::Float64 = 0.1` - Job search intensity
- `wage_bargaining_power::Float64 = 0.5` - Worker wage bargaining power

### Firm Parameters
- `sector1_rd_intensity::Float64 = 0.04` - R&D spending as share of revenue
- `sector1_innovation_prob::Float64 = 0.3` - Innovation success probability
- `sector1_imitation_prob::Float64 = 0.7` - Imitation success probability  
- `sector2_desired_inventories::Float64 = 0.1` - Target inventory-to-sales ratio
- `sector2_price_sensitivity::Float64 = 2.0` - Price sensitivity in market competition

### Financial Parameters
- `interest_rate_deposits::Float64 = 0.01` - Deposit interest rate
- `interest_rate_loans::Float64 = 0.04` - Base lending rate
- `bank_capital_ratio::Float64 = 0.08` - Required capital adequacy ratio
- `credit_rationing_threshold::Float64 = 1.5` - Credit rationing threshold

### Government Parameters
- `tax_rate_workers::Float64 = 0.2` - Worker income tax rate
- `tax_rate_firms::Float64 = 0.25` - Corporate tax rate
- `government_spending_gdp_ratio::Float64 = 0.2` - Government spending as % of GDP
- `debt_gdp_target::Float64 = 0.6` - Target debt-to-GDP ratio

## Output Data

The model collects comprehensive time series data including:

### Macroeconomic Aggregates
- GDP, consumption, investment, government spending
- GDP growth rate and inflation
- Aggregate productivity and productivity growth

### Labor Market
- Unemployment, employment, and participation rates
- Average wages, wage growth, and wage inequality
- Job creation and destruction rates
- Labor market tightness

### Financial Sector
- Bank capital ratios and loan portfolios
- Credit growth and rationing indicators
- Banking sector profitability and stability

### Government Finances  
- Tax revenues and government expenditures
- Fiscal balance and debt-to-GDP ratio
- Social program participation and costs

### Innovation and Technology
- Innovation rates and patent stocks
- R&D intensity and technology diffusion
- Productivity dispersion across firms

### Market Structure
- Firm concentration ratios
- Market shares and competitiveness
- Entry and exit rates

## Model Validation

The model includes built-in validation tests for:

1. **Macroeconomic Stability**: GDP growth within reasonable bounds
2. **Labor Market Functioning**: Unemployment rates between 1-50%
3. **Financial Stability**: Bank capital adequacy maintained
4. **Fiscal Sustainability**: Government debt under control
5. **Innovation Activity**: Positive innovation rates

## Stylized Facts

The model is designed to reproduce key macroeconomic stylized facts:

- **Business Cycles**: Persistent fluctuations in GDP and employment
- **Okun's Law**: Negative correlation between unemployment and output growth
- **Phillips Curve**: Short-run inflation-unemployment tradeoff
- **Kaldor Facts**: Stable labor share and capital-output ratio
- **Financial Accelerator**: Credit amplifies business cycles
- **Innovation Clustering**: Uneven technological progress over time

## Advanced Features

### Scenario Analysis
```julia
# Compare different policy scenarios
baseline_params = KSParameters()
high_benefits_params = KSParameters(unemployment_benefit_rate = 0.6)
tight_monetary_params = KSParameters(bank_capital_ratio = 0.12)

# Run multiple scenarios
scenarios = [
    ("Baseline", baseline_params),
    ("High Benefits", high_benefits_params), 
    ("Tight Regulation", tight_monetary_params)
]

for (name, params) in scenarios
    model = create_model(params)
    results = run_simulation!(model; steps=1000)
    println("$name: Final unemployment = $(results[end, :unemployment_rate])")
end
```

### Monte Carlo Analysis
```julia
# Run multiple replications
n_replications = 50
results_collection = []

for i in 1:n_replications
    model = create_model()
    results = run_simulation!(model; steps=1000)
    push!(results_collection, results)
    println("Completed replication $i")
end

# Analyze distribution of outcomes
final_gdps = [results[end, :gdp] for results in results_collection]
println("Mean final GDP: $(mean(final_gdps))")
println("GDP standard deviation: $(std(final_gdps))")
```

## References

- Dosi, G., Fagiolo, G., & Roventini, A. (2010). Schumpeter meeting Keynes: A policy-friendly model of endogenous growth and business cycles. *Journal of Economic Dynamics and Control*, 34(9), 1748-1767.

- Dosi, G., Fagiolo, G., Napoletano, M., Roventini, A., & Treibich, T. (2015). Fiscal and monetary policies in complex evolving economies. *Journal of Economic Dynamics and Control*, 52, 166-189.

- Assenza, T., Delli Gatti, D., & Grazzini, J. (2015). Emergent dynamics of a macroeconomic agent based model with capital and credit. *Journal of Economic Dynamics and Control*, 50, 5-28.

## License

This implementation is provided for academic and research purposes. Please cite the original K+S model papers when using this code in research.

## Contributing

Contributions are welcome! Please submit issues and pull requests through the GitHub repository.

## Support

For questions about the model implementation or usage, please:
1. Check the documentation and examples
2. Review the validation tests
3. Open an issue with a minimal reproducible example

---

*This implementation faithfully reproduces the original K+S labor-augmented model while being optimized for the Julia/Agents.jl ecosystem.*