# Load necessary libraries
install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)
install.packages("rtools")
library(jtools)
install.packages("car")
library(car)

# Read the data
data <- read.csv("C:/Users/Zuzia/Documents/sem VI/licencjat/danedoanalizy_doR.txt", sep="")

# Rename the variables
data <- data %>%
  rename(ekonomiczneispoleczne = unknown,
         trybstudiow = trybstudiaw)


# Define variables
variables <- c("FTP", "czasaktywnosci", "sq_wsparciefinansowe", "dochodrozporzadzalny", 
               "edukacjarodzicow", "sq_IQ", "otwartoscnadoswiadczenia", "sumiennosc", 
               "ekstrawersja", "ugodowosc", "neurotyzm", "plec", "wiek", "trybstudiow", 
               "zamieszkanie", "humanistyczne", "inzynieryjnotechniczne", "medyczneinaukiozdrowiu", 
               "ekonomiczneispoleczne", "scisleiprzyrodnicze")

# Initialize a list to store models
interaction_results <- list()

# Loop through each pair of variables
for (i in 1:(length(variables)-1)) {
  for (j in (i+1):length(variables)) {
    # Define the formula
    formula <- as.formula(paste("l_zaangazowanie ~", variables[i], "*", variables[j], 
                                "+ FTP + czasaktywnosci + sq_wsparciefinansowe + dochodrozporzadzalny + edukacjarodzicow + sq_IQ + otwartoscnadoswiadczenia + sumiennosc + ekstrawersja + ugodowosc + neurotyzm + plec + wiek + trybstudiow + zamieszkanie + humanistyczne + inzynieryjnotechniczne + medyczneinaukiozdrowiu + ekonomiczneispoleczne + scisleiprzyrodnicze"))
    
    # Fit the model
    interaction_model <- lm(formula, data = data)
    
    # Store the model summary
    interaction_results[[paste(variables[i], variables[j], sep = "_")]] <- summary(interaction_model)
    
    # Create interaction plot
    interaction_plot <- data %>%
      mutate(predicted = predict(interaction_model, newdata = data)) %>%
      ggplot(aes_string(x = variables[i], y = "l_zaangazowanie")) +
      geom_point(aes_string(color = variables[j])) +
      geom_line(aes(y = predicted), linetype = "solid", color = "blue") +
      labs(title = paste("Interaction between", variables[i], "and", variables[j]),
           x = variables[i],
           y = "l_zaangazowanie") +
      theme_minimal()
    
    # Print the plot
    print(interaction_plot)
  }
}

# Print results
interaction_results

# Define the path for the output file
output_file <- "~/studia/sem VI/licencjat/interaction_results2.txt"

# Open the sink connection to the output file
sink(output_file)

# Loop through the results and print them to the file
for (interaction in names(interaction_results)) {
  cat("Interaction:", interaction, "\n")
  print(interaction_results[[interaction]])
  cat("\n\n")
}

# Close the sink connection
sink()

# Define the path for the output PDF file
pdf_file <- "~/studia/sem VI/licencjat/interaction_plots2.pdf"

# Open a PDF device
pdf(pdf_file)

# Loop through each pair of variables to create and save the plots
for (i in 1:(length(variables)-1)) {
  for (j in (i+1):length(variables)) {
    # Define the formula
    formula <- as.formula(paste("l_zaangazowanie ~", variables[i], "*", variables[j], 
                                "+ FTP + czasaktywnosci + sq_wsparciefinansowe + dochodrozporzadzalny + edukacjarodzicow + sq_IQ + otwartoscnadoswiadczenia + sumiennosc + ekstrawersja + ugodowosc + neurotyzm + plec + wiek + trybstudiow + zamieszkanie + humanistyczne + inzynieryjnotechniczne + medyczneinaukiozdrowiu + ekonomiczneispoleczne + scisleiprzyrodnicze"))
    
    # Fit the model
    interaction_model <- lm(formula, data = data)
    
    # Create interaction plot
    interaction_plot <- data %>%
      mutate(predicted = predict(interaction_model, newdata = data)) %>%
      ggplot(aes_string(x = variables[i], y = "l_zaangazowanie")) +
      geom_point(aes_string(color = variables[j])) +
      geom_line(aes(y = predicted), linetype = "solid", color = "blue") +
      labs(title = paste("Interaction between", variables[i], "and", variables[j]),
           x = variables[i],
           y = "l_zaangazowanie") +
      theme_minimal()
    
    # Print the plot to the PDF
    print(interaction_plot)
  }
}

# Close the PDF device
dev.off()

# Initialize an empty list to store significant interactions
significant_interactions <- list()

# Loop through the results and check for significant interactions
for (interaction in names(interaction_results)) {
  # Extract the summary
  summary_res <- interaction_results[[interaction]]
  
  # Check if the interaction term is significant (p < 0.05)
  interaction_term <- grep(":", rownames(summary_res$coefficients), value = TRUE)
  if (length(interaction_term) > 0 && summary_res$coefficients[interaction_term, "Pr(>|t|)"] < 0.05) {
    significant_interactions[[interaction]] <- summary_res
  }
}

# Define the path for the output file
output_file <- "~/studia/sem VI/licencjat/significant_interaction_results.txt"

# Open the sink connection to the output file
sink(output_file)

# Loop through the significant interactions and print them to the file
for (interaction in names(significant_interactions)) {
  cat("Significant Interaction:", interaction, "\n")
  print(significant_interactions[[interaction]])
  cat("\n\n")
}

# Close the sink connection
sink()

# Define the updated model formula with significant interactions
updated_formula <- as.formula("l_zaangazowanie ~ FTP * czasaktywnosci + FTP * otwartoscnadoswiadczenia + dochodrozporzadzalny * trybstudiow + FTP + czasaktywnosci + sq_wsparciefinansowe + dochodrozporzadzalny + edukacjarodzicow + sq_IQ + otwartoscnadoswiadczenia + sumiennosc + ekstrawersja + ugodowosc + neurotyzm + plec + wiek + trybstudiow + zamieszkanie + humanistyczne + inzynieryjnotechniczne + medyczneinaukiozdrowiu + ekonomiczneispoleczne + scisleiprzyrodnicze")

# Fit the updated linear model
updated_model <- lm(updated_formula, data = data)

# Summarize the model results
summary(updated_model)

ggplot(data, aes(x = FTP, y = l_zaangazowanie, color = as.factor(czasaktywnosci))) +
  geom_point() +
  geom_smooth(method = "lm", aes(group = as.factor(czasaktywnosci)), se = FALSE) +
  labs(title = "Interakcja między FTP a czasem aktywności na zaangażowaniem studentów do nauki",
       x = "FTP",
       y = "Zaangażowanie (l_zaangazowanie)",
       color = "Czas aktywności") +
  theme_minimal()

ggplot(data, aes(x = FTP, y = l_zaangazowanie, color = as.factor(otwartoscnadoswiadczenia))) +
  geom_point() +
  geom_smooth(method = "lm", aes(group = as.factor(otwartoscnadoswiadczenia)), se = FALSE) +
  labs(title = "Interakcja między FTP a otwartością na doświadczenia na zaangażowaniem studentów do nauki",
       x = "FTP",
       y = "Zaangażowanie (l_zaangazowanie)",
       color = "Otwartość na doświadczenia") +
  theme_minimal()

ggplot(data, aes(x = dochodrozporzadzalny, y = l_zaangazowanie, color = as.factor(trybstudiow))) +
  geom_point() +
  geom_smooth(method = "lm", aes(group = as.factor(trybstudiow)), se = FALSE) +
  labs(title = "Interakcja między dochodem rozporządzalnym a trybem studiów na zaangażowanie studentów do nauki",
       x = "Dochód rozporządzalny",
       y = "Zaangażowanie (l_zaangazowanie)",
       color = "Tryb studiów") +
  theme_minimal()

# Instalacja i załadowanie niezbędnych pakietów
install.packages("ggplot2")
install.packages("lmtest")
install.packages("car")
library(ggplot2)
library(lmtest)
library(car)

# Wczytanie danych
data <- read.csv("~/studia/sem VI/licencjat/danedoanalizy_doR.txt", sep="")

# Zmiana nazw zmiennych (jeśli potrzebne)
data <- data %>%
  rename(spoleczneiekonomiczna = unknown,
         trybstudiow = trybstudiaw)

# Definicja modelu z uwzględnieniem istotnych interakcji
updated_formula <- as.formula("l_zaangazowanie ~ FTP * otwartoscnadoswiadczenia + dochodrozporzadzalny * trybstudiow + FTP + czasaktywnosci + sq_wsparciefinansowe + dochodrozporzadzalny + edukacjarodzicow + sq_IQ + otwartoscnadoswiadczenia + sumiennosc + ekstrawersja + ugodowosc + neurotyzm + plec + wiek + trybstudiow + zamieszkanie + humanistyczne + inzynieryjnotechniczne + medyczneinaukiozdrowiu + ekonomiczneispoleczne + scisleiprzyrodnicze")

# Estymacja modelu
updated_model <- lm(updated_formula, data = data)

# Test na liniowość modelu
plot(updated_model$fitted.values, residuals(updated_model), 
     main = "Reszty vs Dopasowane Wartości",
     xlab = "Dopasowane wartości", 
     ylab = "Reszty")
abline(h = 0, col = "red")

# Test Durbin-Watsona na autokorelację reszt
dwtest(updated_model)

# Test Breuscha-Pagana na homoskedastyczność
bptest(updated_model)

# Test Shapiro-Wilka na normalność reszt
shapiro.test(residuals(updated_model))

# Test na multikolinearność (VIF)
vif(updated_model)

# Test RESET Ramsey'a na specyfikację modelu
resettest(updated_model)

library(car)

# Obliczanie wskaźnika VIF z opcją type = "predictor"
vif_values <- vif(updated_model, type = "predictor")

# Wyświetlenie wyników
vif_values

