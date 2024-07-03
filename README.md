# Linear Regression Analysis Shiny App

## Overview
This Shiny app allows users to perform linear regression analysis on the Old Faithful geyser dataset (`faithful`). The dataset includes information about the eruption durations and waiting times between eruptions of the Old Faithful geyser in Yellowstone National Park.

Users can select one variable (`Eruptions` or `Waiting`) for analysis and apply transformations such as `None`, `Log`, or `Square root` to explore different aspects of the data and regression results.

## Features
- **Dataset**: Uses the built-in `faithful` dataset from R.
- **Input Selection**:
  - Checkbox group input to select between `Eruptions` and `Waiting`.
  - Dropdown select input for transformation options (`None`, `Log`, `Square root`).
- **Outputs**:
  - Summary statistics of linear regression model.
  - Residual plot for diagnostics.
  - QQ plot for residual normality assessment.
- **Validation**:
  - Ensures users select exactly one variable for analysis.

## Installation and Usage
1. Ensure you have R and RStudio installed on your machine.
2. Clone or download the repository containing `app.R`.
3. Open `app.R` in RStudio.
4. Install necessary packages (`shiny`, `bslib`) if not already installed.
5. Run the Shiny app by clicking the 'Run App' button in RStudio.

