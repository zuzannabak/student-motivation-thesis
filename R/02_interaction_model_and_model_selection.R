install.packages("MASS")
library(MASS)
library(MASS)

# Model bazowy - najprostszy model bez interakcji
model_bazowy = lm(l_zaangazowanie ~ FTP + czasaktywnosci + sq_wsparciefinansowe + dochodrozporzadzalny + edukacjarodzicow + sq_IQ + otwartoscnadoswiadczenia + sumiennosc + ekstrawersja + ugodowosc + neurotyzm + plec + wiek + trybstudiow + zamieszkanie + humanistyczne + inzynieryjnotechniczne + medyczneinaukiozdrowiu + ekonomiczneispoleczne + scisleiprzyrodnicze, data=data)

# Model końcowy - zawierający wszystkie możliwe interakcje
model_koncowy = lm(l_zaangazowanie ~ (FTP + czasaktywnosci + sq_wsparciefinansowe + dochodrozporzadzalny + edukacjarodzicow + sq_IQ + otwartoscnadoswiadczenia + sumiennosc + ekstrawersja + ugodowosc + neurotyzm + plec + wiek + trybstudiow + zamieszkanie + humanistyczne + inzynieryjnotechniczne + medyczneinaukiozdrowiu + ekonomiczneispoleczne + scisleiprzyrodnicze)^2, data=data)

# Użycie stepAIC z prawidłowym zakresem i kierunkiem
model_stepwise = stepAIC(model_bazowy, scope = list(lower = model_bazowy, upper = model_koncowy), direction = "both")

summary(model_stepwise)
