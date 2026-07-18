# GASRATS Project Monorepo Configuration

This monorepo contains the simulations and designs for the Utah State University GAS (Get Away Special) team's 3U CubeSat.

## Repository Structure

* **`shared_parameters/`**: Single source of truth for physical constants and parameters.
  * [`cubesat_properties.json`](file:///C:/200-Projects/GAS/Oz_GASRATS/shared_parameters/cubesat_properties.json): Contains CubeSat physical characteristics (mass, dimensions, inertia tensor).
* **`legacy_monte_carlo/`**: MATLAB script-based orbit and attitude simulations.
* **`mathworks_aerospace/`**: Simulink/Aerospace Blockset simulations and models.

## Development Guidelines

1. **Parameters**: Always read core satellite parameters from `shared_parameters/cubesat_properties.json` in both MATLAB and Simulink simulations to maintain a single source of truth.
2. **Ignored Files**: Keep MATLAB and Simulink cache files (such as `slprj/`, `*.slxc`, `*.asv`) out of Git using the root `.gitignore`.
