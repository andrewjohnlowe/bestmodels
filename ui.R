library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Comparision of models for predicting diabetes"),
  
  sidebarPanel(
    h2('Training options'),
    h3('Repeated k-fold cross validation'),
    numericInput('k', 'k?', 2, min = 2, max = 10, step = 1),
    
    numericInput('reps', 'Number of repeats?', 1, min = 1, max = 10, step = 1),
    h3('Model selection'),
    checkboxGroupInput("mod", "Choose model (and wait for results):",
                       c("Learning Vector Quantisation" = "lvq",
                         "LogitBoost" = "LogitBoost",
                         "Single decision tree" = "rpart",
                         "Support Vector Machine" = "svmRadial",
                         "Random Forest" = "rf"))
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Application",
               h3('User inputs:'),
               h4('k-fold cross validation with k = '),
               verbatimTextOutput("k"),
               h4('Number of repeats:'),
               verbatimTextOutput("reps"),
               h4('Selected model:'),
               verbatimTextOutput("mod"),
               h4('Model accuracy:'),
               verbatimTextOutput("resultsText"),
               h4('Variable importance plot'),
               plotOutput('thePlot')
      ),
      tabPanel("Documentation",
               h2("An app for comparing a small number of machine learning classifiers for predicting diabetes"),
               h3("About this app"),
               p("The app presented in class contained an overly-simplistic model for predicting diabetes. It is reasonable to ask if a better model is possible. That is, can we build a model with greater prediction accuracy than that shown in class? This app expands on the app shown in class by allowing the user to compare the accuracy of a number of different machine learning models for predicting diabetes. The data was collected from a population of women who were at least 21 years old, of Pima Indian heritage and living near Phoenix, Arizona, who were tested for diabetes according to World Health Organization criteria. The data were collected by the US National Institute of Diabetes and Digestive and Kidney Diseases. The data consists of 768 observations on 9 variables."),
               h3("Usage:"),
               p("The user should select training options for the model. The chosen model is trained using k-fold cross validation with an optional number of repeats so that the resultant model is robust against overfitting. Select the number of folds (k) and the number of repeats. Then select a single model. Training takes a few seconds. The accuracy of the model and other statistics are printed. Additionally, a variable importance plot is displayed that shows the importance of each variable in the final model."),
               strong("Note: for the sake of expediency, these numbers have not been evaluated using an independent hold-out test set.")
      )
    )
  )
)
)
