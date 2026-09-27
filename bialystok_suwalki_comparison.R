library(tidyr)
library(dplyr)
library(tidyverse)
library(ggplot2)

avgTempB <- read.table("Avg_Temp_Bialystok.txt", header = TRUE, sep = "\t")
totPrecB <- read.table("Tot_Prec_Bialystok.txt", header = TRUE, sep = "\t")

avgTempS <- read.table("Avg_Temp_Suwalki.txt", header = TRUE, sep = "\t")
totPrecS <- read.table("Tot_Prec_Suwalki.txt", header = TRUE, sep = "\t")

avgTempB <- avgTempB %>%
  select(-Roczna, -DJF, -MAM, -JJA, -SON) %>%
  slice(-n())
totPrecB <- totPrecB %>%
  select(-Roczna, -DJF, -MAM, -JJA, -SON) %>%
  slice(-n())

avgTempS <- avgTempS %>%
  select(-Roczna, -DJF, -MAM, -JJA, -SON) %>%
  slice(-n())
totPrecS <- totPrecS %>%
  select(-Roczna, -DJF, -MAM, -JJA, -SON) %>%
  slice(-n())

avgTempB$X <- as.numeric(avgTempB$X)
avgTempB$XI <- as.numeric(avgTempB$XI)
avgTempB$XII <- as.numeric(avgTempB$XII)
totPrecB$X <- as.numeric(totPrecB$X)
totPrecB$XI <- as.numeric(totPrecB$XI)
totPrecB$XII <- as.numeric(totPrecB$XII)
avgTempS$X <- as.numeric(avgTempS$X)
avgTempS$XI <- as.numeric(avgTempS$XI)
avgTempS$XII <- as.numeric(avgTempS$XII)
totPrecS$X <- as.numeric(totPrecS$X)
totPrecS$XI <- as.numeric(totPrecS$XI)
totPrecS$XII <- as.numeric(totPrecS$XII)

#1 Analiza porównawcza charakterystyki klimatycznej wybranych stacji============

avgTempB <- avgTempB %>%
  pivot_longer(cols = I:XII, names_to = "Miesiąc", values_to = "Temperatura")
avgTempS <- avgTempS %>%
  pivot_longer(cols = I:XII, names_to = "Miesiąc", values_to = "Temperatura")
totPrecB <- totPrecB %>%
  pivot_longer(cols = I:XII, names_to = "Miesiąc", values_to = "Opady")
totPrecS <- totPrecS %>%
  pivot_longer(cols = I:XII, names_to = "Miesiąc", values_to = "Opady")

avgTempB <- avgTempB %>%
  mutate(Miesiąc = factor(Miesiąc,
                          levels = c("I", "II", "III", "IV", "V", "VI",
                                     "VII", "VIII", "IX", "X", "XI", "XII")))
avgTempS <- avgTempS %>%
  mutate(Miesiąc = factor(Miesiąc,
                          levels = c("I", "II", "III", "IV", "V", "VI",
                                     "VII", "VIII", "IX", "X", "XI", "XII")))
totPrecB <- totPrecB %>%
  mutate(Miesiąc = factor(Miesiąc,
                          levels = c("I", "II", "III", "IV", "V", "VI",
                                     "VII", "VIII", "IX", "X", "XI", "XII")))
totPrecS <- totPrecS %>%
  mutate(Miesiąc = factor(Miesiąc,
                          levels = c("I", "II", "III", "IV", "V", "VI",
                                     "VII", "VIII", "IX", "X", "XI", "XII")))

#Bialystok Temperatura

ggplot(avgTempB, aes(x = Miesiąc, y = Temperatura, fill = Miesiąc)) +
  geom_boxplot() +
  labs(title = "Rozkłady miesięcznych średnich temperatur w Białymstoku", 
       x = "Miesiąc",
       y = "Temperatura [°C]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", 
                       min(avgTempB$Rok), "-", max(avgTempB$Rok)))

#Suwalki Temperatura

ggplot(avgTempS, aes(x = Miesiąc, y = Temperatura, fill = Miesiąc)) +
  geom_boxplot() +
  labs(title = "Rozkłady miesięcznych średnich temperatur w Suwałkach", 
       x = "Miesiąc",
       y = "Temperatura [°C]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", 
                       min(avgTempS$Rok), "-", max(avgTempS$Rok)))

#Bialystok Opady

ggplot(totPrecB, aes(x = Miesiąc, y = Opady, fill = Miesiąc)) +
  geom_boxplot() +
  labs(title = "Rozkłady miesięcznych sum opadów w Białymstoku", 
       x = "Miesiąc",
       y = "Opady [mm]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", 
                       min(totPrecB$Rok), "-", max(totPrecB$Rok)))

#Suwalki Opady

ggplot(totPrecS, aes(x = Miesiąc, y = Opady, fill = Miesiąc)) +
  geom_boxplot() +
  labs(title = "Rozkłady miesięcznych sum opadów w Suwałkach", 
       x = "Miesiąc",
       y = "Opady [mm]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", 
                       min(totPrecS$Rok), "-", max(totPrecS$Rok)))

#3 Analiza korelacyjna dla danych ze stacji wybranej do projektu nr 1 oraz drugiej stacji

pearson <- list()
spearman <- list()

#Temperatura

tempWinter <- avgTempB %>%
  filter(Miesiąc == "II") %>%
  transmute(Rok, Białystok = Temperatura) %>%
  inner_join(avgTempS %>%
      filter(Miesiąc == "II") %>%
      transmute(Rok, Suwałki = Temperatura), by = "Rok")

tempSpring <- avgTempB %>%
  filter(Miesiąc == "V") %>%
  transmute(Rok, Białystok = Temperatura) %>%
  inner_join(avgTempS %>%
               filter(Miesiąc == "V") %>%
               transmute(Rok, Suwałki = Temperatura), by = "Rok")
tempSummer <- avgTempB %>%
  filter(Miesiąc == "VIII") %>%
  transmute(Rok, Białystok = Temperatura) %>%
  inner_join(avgTempS %>%
               filter(Miesiąc == "VIII") %>%
               transmute(Rok, Suwałki = Temperatura), by = "Rok")
tempAutumn <- avgTempB %>%
  filter(Miesiąc == "XI") %>%
  transmute(Rok, Białystok = Temperatura) %>%
  inner_join(avgTempS %>%
               filter(Miesiąc == "XI") %>%
               transmute(Rok, Suwałki = Temperatura), by = "Rok")

pearson$tempWinter <- cor.test(tempWinter$Białystok, tempWinter$Suwałki, method = "pearson")
spearman$tempWinter <- cor(tempWinter$Białystok, tempWinter$Suwałki, method = "spearman")

ggplot(tempWinter, aes(x = Białystok, y = Suwałki)) +
  geom_point(color = "steelblue1", size = 2, alpha = 0.8) +
  geom_smooth(method = "lm", color = "darkblue")  +
  labs(title = "Zależność między średnimi temperaturami Lutego w Białymstoku i Suwałkach",
    x = "Białystok – temperatura [°C]",
    y = "Suwałki – temperatura [°C]",
    caption = paste("Dane historyczne dla lat:", min(avgTempS$Rok), "-", max(avgTempS$Rok)))

pearson$tempSpring <- cor.test(tempSpring$Białystok, tempSpring$Suwałki, method = "pearson")
spearman$tempSpring <- cor(tempSpring$Białystok, tempSpring$Suwałki, method = "spearman")

ggplot(tempSpring, aes(x = Białystok, y = Suwałki)) +
  geom_point(color = "springgreen3", size = 2, alpha = 0.8) +
  geom_smooth(method = "lm", color = "darkgreen")  +
  labs(title = "Zależność między średnimi temperaturami Maja w Białymstoku i Suwałkach",
       x = "Białystok – temperatura [°C]",
       y = "Suwałki – temperatura [°C]",
       caption = paste("Dane historyczne dla lat:", min(avgTempS$Rok), "-", max(avgTempS$Rok)))

pearson$tempSummer <- cor.test(tempSummer$Białystok, tempSummer$Suwałki, method = "pearson")
spearman$tempSummer <- cor(tempSummer$Białystok, tempSummer$Suwałki, method = "spearman")

ggplot(tempSummer, aes(x = Białystok, y = Suwałki)) +
  geom_point(color = "goldenrod1", size = 2, alpha = 0.8) +
  geom_smooth(method = "lm", color = "darkgoldenrod")  +
  labs(title = "Zależność między średnimi temperaturami Sierpnia w Białymstoku i Suwałkach",
       x = "Białystok – temperatura [°C]",
       y = "Suwałki – temperatura [°C]",
       caption = paste("Dane historyczne dla lat:", min(avgTempS$Rok), "-", max(avgTempS$Rok)))

pearson$tempAutumn <- cor.test(tempAutumn$Białystok, tempAutumn$Suwałki, method = "pearson")
spearman$tempAutumn <- cor(tempAutumn$Białystok, tempAutumn$Suwałki, method = "spearman")

ggplot(tempAutumn, aes(x = Białystok, y = Suwałki)) +
  geom_point(color = "tomato1", size = 2, alpha = 0.8) +
  geom_smooth(method = "lm", color = "darkred")  +
  labs(title = "Zależność między średnimi temperaturami Listopada w Białymstoku i Suwałkach",
       x = "Białystok – temperatura [°C]",
       y = "Suwałki – temperatura [°C]",
       caption = paste("Dane historyczne dla lat:", min(avgTempS$Rok), "-", max(avgTempS$Rok)))

#Opady

precWinter <- totPrecB %>%
  filter(Miesiąc == "II") %>%
  transmute(Rok, Białystok = Opady) %>%
  inner_join(totPrecS %>%
               filter(Miesiąc == "II") %>%
               transmute(Rok, Suwałki = Opady), by = "Rok")
precSpring <- totPrecB %>%
  filter(Miesiąc == "V") %>%
  transmute(Rok, Białystok = Opady) %>%
  inner_join(totPrecS %>%
               filter(Miesiąc == "V") %>%
               transmute(Rok, Suwałki = Opady), by = "Rok")
precSummer <- totPrecB %>%
  filter(Miesiąc == "VIII") %>%
  transmute(Rok, Białystok = Opady) %>%
  inner_join(totPrecS %>%
               filter(Miesiąc == "VIII") %>%
               transmute(Rok, Suwałki = Opady), by = "Rok")
precAutumn <- totPrecB %>%
  filter(Miesiąc == "XI") %>%
  transmute(Rok, Białystok = Opady) %>%
  inner_join(totPrecS %>%
               filter(Miesiąc == "XI") %>%
               transmute(Rok, Suwałki = Opady), by = "Rok")


pearson$precWinter <- cor.test(precWinter$Białystok, precWinter$Suwałki, method = "pearson")
spearman$precWinter <- cor(precWinter$Białystok, precWinter$Suwałki, method = "spearman")

ggplot(precWinter, aes(x = Białystok, y = Suwałki)) +
  geom_point(color = "steelblue1", size = 2, alpha = 0.8) +
  geom_smooth(method = "lm", color = "darkblue")  +
  labs(title = "Zależność między sumami opadów Lutego w Białymstoku i Suwałkach",
       x = "Białystok – opady [mm]",
       y = "Suwałki – opady [mm]",
       caption = paste("Dane historyczne dla lat:", min(totPrecS$Rok), "-", max(totPrecS$Rok)))

pearson$precSpring <- cor.test(precSpring$Białystok, precSpring$Suwałki, method = "pearson")
spearman$precSpring <- cor(precSpring$Białystok, precSpring$Suwałki, method = "spearman")

ggplot(precSpring, aes(x = Białystok, y = Suwałki)) +
  geom_point(color = "springgreen3", size = 2, alpha = 0.8) +
  geom_smooth(method = "lm", color = "darkgreen")  +
  labs(title = "Zależność między sumami opadów Maja w Białymstoku i Suwałkach",
       x = "Białystok – opady [mm]",
       y = "Suwałki – opady [mm]",
       caption = paste("Dane historyczne dla lat:", min(totPrecS$Rok), "-", max(totPrecS$Rok)))

pearson$precSummer <- cor.test(precSummer$Białystok, precSummer$Suwałki, method = "pearson")
spearman$precSummer <- cor(precSummer$Białystok, precSummer$Suwałki, method = "spearman")

ggplot(precSummer, aes(x = Białystok, y = Suwałki)) +
  geom_point(color = "goldenrod1", size = 2, alpha = 0.8) +
  geom_smooth(method = "lm", color = "darkgoldenrod")  +
  labs(title = "Zależność między sumami opadów Sierpnia w Białymstoku i Suwałkach",
       x = "Białystok – opady [mm]",
       y = "Suwałki – opady [mm]",
       caption = paste("Dane historyczne dla lat:", min(totPrecS$Rok), "-", max(totPrecS$Rok)))

pearson$precAutumn <- cor.test(precAutumn$Białystok, precAutumn$Suwałki, method = "pearson")
spearman$precAutumn <- cor(precAutumn$Białystok, precAutumn$Suwałki, method = "spearman")

ggplot(precAutumn, aes(x = Białystok, y = Suwałki)) +
  geom_point(color = "tomato1", size = 2, alpha = 0.8) +
  geom_smooth(method = "lm", color = "darkred")  +
  labs(title = "Zależność między sumami opadów Listopada w Białymstoku i Suwałkach",
       x = "Białystok – opady [mm]",
       y = "Suwałki – opady [mm]",
       caption = paste("Dane historyczne dla lat:", min(totPrecS$Rok), "-", max(totPrecS$Rok)))

pearson
spearman
