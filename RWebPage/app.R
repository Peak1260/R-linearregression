library(shiny)
library(bslib)

# Load your dataset here or use a built-in dataset related to linear regression
data <- faithful  # Example dataset

# Define UI for the Shiny app
ui <- fluidPage(
  titlePanel("Linear Regression Analysis"),
  sidebarLayout(
    sidebarPanel(
      # Information about the dataset
      HTML("<p><b>Dataset Summary:</b> The 'faithful' dataset contains information about the eruption durations and waiting times between eruptions of the Old Faithful geyser in Yellowstone National Park.</p>"),
      # Inputs for the analysis
      checkboxGroupInput(
        inputId = "variables",
        label = "Select variables:",
        choices = c("Eruptions" = "eruptions", "Waiting" = "waiting"),
        selected = NULL  # No default selection
      ),
      selectInput(
        inputId = "transformation",
        label = "Select transformation:",
        choices = c("None", "Log", "Square root"),
        selected = "None"
      )
    ),
    mainPanel(
      tabsetPanel(
        # Output tabs for different results
        tabPanel(
          "Summary",
          verbatimTextOutput(outputId = "summary")
        ),
        tabPanel(
          "Diagnostic Plots",
          plotOutput(outputId = "residualPlot"),
          plotOutput(outputId = "qqPlot")
        )
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Perform linear regression and update outputs
  output$summary <- renderPrint({
    # Check if variables are selected and only one is selected
    selected_var <- input$variables
    if (is.null(selected_var) || length(selected_var) != 1) {
      return("Select exactly one variable.")
    }
    
    transformed_data <- data
    
    # Apply transformation if selected
    if (input$transformation == "Log") {
      transformed_data[[selected_var]] <- log(data[[selected_var]])
    } else if (input$transformation == "Square root") {
      transformed_data[[selected_var]] <- sqrt(data[[selected_var]])
    }
    
    formula <- as.formula(paste("waiting ~", selected_var))
    lm_model <- lm(formula, data = transformed_data)
    summary(lm_model)
  })
  
  # Render residual plot
  output$residualPlot <- renderPlot({
    # Check if variables are selected and only one is selected
    selected_var <- input$variables
    if (is.null(selected_var) || length(selected_var) != 1) {
      plot(0, type = "n", main = "Residual Plot", xlab = "", ylab = "")
      text(0, 0, "Select exactly one variable.", cex = 1.2)
      return()
    }
    
    transformed_data <- data
    
    # Apply transformation if selected
    if (input$transformation == "Log") {
      transformed_data[[selected_var]] <- log(data[[selected_var]])
    } else if (input$transformation == "Square root") {
      transformed_data[[selected_var]] <- sqrt(data[[selected_var]])
    }
    
    formula <- as.formula(paste("waiting ~", selected_var))
    lm_model <- lm(formula, data = transformed_data)
    plot(lm_model, which = 1)
  })
  
  # Render QQ plot of residuals
  output$qqPlot <- renderPlot({
    # Check if variables are selected and only one is selected
    selected_var <- input$variables
    if (is.null(selected_var) || length(selected_var) != 1) {
      plot(0, type = "n", main = "QQ Plot", xlab = "", ylab = "")
      text(0, 0, "Select exactly one variable.", cex = 1.2)
      return()
    }
    
    transformed_data <- data
    
    # Apply transformation if selected
    if (input$transformation == "Log") {
      transformed_data[[selected_var]] <- log(data[[selected_var]])
    } else if (input$transformation == "Square root") {
      transformed_data[[selected_var]] <- sqrt(data[[selected_var]])
    }
    
    formula <- as.formula(paste("waiting ~", selected_var))
    lm_model <- lm(formula, data = transformed_data)
    qqnorm(lm_model$residuals)
    qqline(lm_model$residuals)
  })
  
}

# Run the Shiny app
shinyApp(ui = ui, server = server)
