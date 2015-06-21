if(!require(mlbench)) {
  install.packages("mlbench")
  }
library(mlbench)

if(!require(caret)) {
  install.packages("caret")
  }
library(caret)

if(!require(randomForest)) {
  install.packages("randomForest")
  }
library(randomForest)

if(!require(caTools)) {
  install.packages("caTools")
  }
library(caTools)

if(!require(e1071)) {
  install.packages("e1071")
}
library(e1071)

if(!require(kernlab)) {
  install.packages("kernlab")
}
library(kernlab)

if(!require(pROC)) {
  install.packages("pROC")
}
library(pROC)

diabetesRisk <- function(k, reps, mod = "rpart") {
  data(PimaIndiansDiabetes)
  # prepare training scheme
  ctrl <- trainControl(method="repeatedcv", number=k, repeats=reps)
  # train the model
  set.seed(1)
  fit <- train(diabetes ~ ., data=PimaIndiansDiabetes, method=mod, trControl=ctrl)
}

library(shiny)

shinyServer(function(input, output) {
  # Reactive output here so that we don't have to train the model twice; 
  # once for the text results and once for the plot
  x <- reactive({diabetesRisk(input$k, input$reps, input$mod)})
  
  # Show user what they selected:
  output$k <- renderPrint({input$k})
  output$reps <- renderPrint({input$reps})
  output$mod <- renderPrint({input$mod})
  
  # Output the results (text and plot):
  
  # Text:
  output$resultsText <- renderPrint({
    if(length(input$mod) == 0) { 
      "No model selected"
    } else { 
      if(length(input$mod) > 1) {
        "Choose only one!"
      } else {
        print(x())
      } 
    }
  })

  # Plot:
  output$thePlot <- renderPlot({
    if(length(input$mod) == 0) { 
    } else { 
      if(length(input$mod) > 1) {
      } else {
        importance <- varImp(x(), scale = FALSE)
        plot(importance)
      } 
    }
  })
})
