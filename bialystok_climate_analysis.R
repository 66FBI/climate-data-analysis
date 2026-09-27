library(tidyr)
library(dplyr)
library(ggplot2)

avgTemp <- read.table("Avg_Temp_Bialystok.txt", header = TRUE, sep = "\t")
totRain <- read.table("Tot_Rain_Bialystok.txt", header = TRUE, sep = "\t")

avgTemp <- avgTemp %>%
  select(-Roczna, -DJF, -MAM, -JJA, -SON) %>%
  slice(-n())
totRain <- totRain %>%
  select(-Roczna, -DJF, -MAM, -JJA, -SON) %>%
  slice(-n())

avgTemp$X <- as.numeric(avgTemp$X)
avgTemp$XI <- as.numeric(avgTemp$XI)
avgTemp$XII <- as.numeric(avgTemp$XII)
totRain$X <- as.numeric(totRain$X)
totRain$XI <- as.numeric(totRain$XI)
totRain$XII <- as.numeric(totRain$XII)

#3 Czasowa zmienność zmiennych klimatycznych na przestrzeni lat =================

winterTemp <- avgTemp %>%
  select(Rok, II)
springTemp <- avgTemp %>%
  select(Rok, V)
summerTemp <- avgTemp %>%
  select(Rok, VIII)
autumnTemp <- avgTemp %>%
  select(Rok, XI)

springTemp$Month <- "Maj"
summerTemp$Month <- "Sierpień"
autumnTemp$Month <- "Listopad"
winterTemp$Month <- "Luty"

winterTemp <- rename(winterTemp, Temperatura = II)
springTemp <- rename(springTemp, Temperatura = V)
summerTemp <- rename(summerTemp, Temperatura = VIII)
autumnTemp <- rename(autumnTemp, Temperatura = XI)

seasonsTemp <- bind_rows(winterTemp, springTemp, summerTemp, autumnTemp)

ggplot(seasonsTemp, aes(x = Rok, y = Temperatura, color = Month)) +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  scale_color_manual(values = c(
    "Maj" = "springgreen3",
    "Sierpień" = "goldenrod1",
    "Listopad" = "tomato1",
    "Luty" = "steelblue1"
  )) +
  labs(title = "Średnie Temperatury dla Wybranych Miesięcy w Białymstoku", y = "Temperatura [°C]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(avgTemp$Rok), "-", max(avgTemp$Rok)))

ggplot(winterTemp, aes(x = Rok, y = Temperatura, color = Month)) +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  scale_color_manual(values = c(
    "Luty" = "steelblue1"
  )) +
  labs(title = "Średnie Temperatury dla Lutego w Białymstoku", y = "Temperatura [°C]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(avgTemp$Rok), "-", max(avgTemp$Rok)))

ggplot(springTemp, aes(x = Rok, y = Temperatura, color = Month)) +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  scale_color_manual(values = c(
    "Maj" = "springgreen3"
  )) +
  labs(title = "Średnie Temperatury dla Maja w Białymstoku", y = "Temperatura [°C]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(avgTemp$Rok), "-", max(avgTemp$Rok)))

ggplot(summerTemp, aes(x = Rok, y = Temperatura, color = Month)) +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  scale_color_manual(values = c(
    "Sierpień" = "goldenrod1"
  )) +
  labs(title = "Średnie Temperatury dla Sierpnia w Białymstoku", y = "Temperatura [°C]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(avgTemp$Rok), "-", max(avgTemp$Rok)))

ggplot(autumnTemp, aes(x = Rok, y = Temperatura, color = Month)) +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  scale_color_manual(values = c(
    "Listopad" = "tomato1"
  )) +
  labs(title = "Średnie Temperatury dla Listopada w Białymstoku", y = "Temperatura [°C]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(avgTemp$Rok), "-", max(avgTemp$Rok)))

#===============================================================================

winterRain <- totRain %>%
  select(Rok, II)
springRain <- totRain %>%
  select(Rok, V)
summerRain <- totRain %>%
  select(Rok, VIII)
autumnRain <- totRain %>%
  select(Rok, XI)

springRain$Month <- "Maj"
summerRain$Month <- "Sierpień"
autumnRain$Month <- "Listopad"
winterRain$Month <- "Luty"

winterRain <- rename(winterRain, Opady = II)
springRain <- rename(springRain, Opady = V)
summerRain <- rename(summerRain, Opady = VIII)
autumnRain <- rename(autumnRain, Opady = XI)

seasonsRain <- bind_rows(winterRain, springRain, summerRain, autumnRain)

ggplot(seasonsRain, aes(x = Rok, y = Opady, color = Month)) +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  scale_color_manual(values = c(
    "Maj" = "springgreen3",
    "Sierpień" = "goldenrod1",
    "Listopad" = "tomato1",
    "Luty" = "steelblue1")) +
  labs(title = "Suma Opadów dla Wybranych Miesięcy w Białymstoku", y = "Opady [mm]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(totRain$Rok), "-", max(totRain$Rok)))

ggplot(winterRain, aes(x = Rok, y = Opady, color = Month)) +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  scale_color_manual(values = c(
    "Luty" = "steelblue1")) +
  labs(title = "Suma Opadów dla Lutego w Białymstoku", y = "Opady [mm]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(totRain$Rok), "-", max(totRain$Rok)))

ggplot(springRain, aes(x = Rok, y = Opady, color = Month)) +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  scale_color_manual(values = c(
    "Maj" = "springgreen3")) +
  labs(title = "Suma Opadów dla Maja w Białymstoku", y = "Opady [mm]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(totRain$Rok), "-", max(totRain$Rok)))

ggplot(summerRain, aes(x = Rok, y = Opady, color = Month)) +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  scale_color_manual(values = c(
    "Sierpień" = "goldenrod1")) +
  labs(title = "Suma Opadów dla Sierpnia w Białymstoku", y = "Opady [mm]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(totRain$Rok), "-", max(totRain$Rok)))

ggplot(autumnRain, aes(x = Rok, y = Opady, color = Month)) +
  geom_line() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  scale_color_manual(values = c(
    "Listopad" = "tomato1")) +
  labs(title = "Suma Opadów dla Listopada w Białymstoku", y = "Opady [mm]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(totRain$Rok), "-", max(totRain$Rok)))

#4 Zmiany dekadowe ==============================================================
seasonsTemp <- seasonsTemp %>%
  filter(Rok < 2021)

seasonsTemp <- seasonsTemp %>%
  mutate(Dekada = paste0(1951 + floor((Rok - 1951) / 10) * 10, "–", 
                         1951 + floor((Rok - 1951) / 10) * 10 + 9))

decTemp <- seasonsTemp %>%
  group_by(Dekada, Month) %>%
  summarise(Średnia = mean(Temperatura, na.rm = TRUE), .groups = "drop")

ggplot(decTemp, aes(Dekada, Średnia, shape = Month, fill = Month, color = Month)) + 
  geom_line(aes(group = Month)) +
  geom_point(color = "black", size = 3, stroke = 0.9) +
  scale_shape_manual(values = c("Maj" = 21, 
                                "Sierpień" = 22, 
                                "Listopad" = 23, 
                                "Luty" = 24)) +
  scale_color_manual(values = c(
    "Maj" = "springgreen3",
    "Sierpień" = "goldenrod1",
    "Listopad" = "tomato1",
    "Luty" = "steelblue1")) +
  scale_fill_manual(values = c(
    "Maj" = "springgreen3",
    "Sierpień" = "goldenrod1",
    "Listopad" = "tomato1",
    "Luty" = "steelblue1")) +
  guides(color = guide_legend(title = "Miesiąc"),
         fill = guide_legend(title = "Miesiąc"),
         shape = guide_legend(title = "Miesiąc")) +
  labs(title = "Średnie Temperatury Dekadowe w Białymstoku", y = "Temperatura [°C]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(avgTemp$Rok), "-", max(avgTemp$Rok)))

ggplot(decTemp[decTemp$Month == "Luty",], aes(Dekada, Średnia, shape = Month, fill = Month, color = Month)) + 
  geom_line(aes(group = Month)) +
  geom_point(color = "black", size = 3, stroke = 0.9) +
  scale_shape_manual(values = c("Luty" = 24)) +
  scale_color_manual(values = c(
    "Luty" = "steelblue1")) +
  scale_fill_manual(values = c(
    "Luty" = "steelblue1")) +
  guides(color = guide_legend(title = "Miesiąc"),
         fill = guide_legend(title = "Miesiąc"),
         shape = guide_legend(title = "Miesiąc")) +
  labs(title = "Średnie Temperatury Dekadowe w Lutym w Białymstoku", y = "Temperatura [°C]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(avgTemp$Rok), "-", max(avgTemp$Rok)))

ggplot(decTemp[decTemp$Month == "Maj",], aes(Dekada, Średnia, shape = Month, fill = Month, color = Month)) + 
  geom_line(aes(group = Month)) +
  geom_point(color = "black", size = 3, stroke = 0.9) +
  scale_shape_manual(values = c("Maj" = 24)) +
  scale_color_manual(values = c(
    "Maj" = "springgreen3")) +
  scale_fill_manual(values = c(
    "Maj" = "springgreen3")) +
  guides(color = guide_legend(title = "Miesiąc"),
         fill = guide_legend(title = "Miesiąc"),
         shape = guide_legend(title = "Miesiąc")) +
  labs(title = "Średnie Temperatury Dekadowe w Maju w Białymstoku", y = "Temperatura [°C]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(avgTemp$Rok), "-", max(avgTemp$Rok)))

ggplot(decTemp[decTemp$Month == "Sierpień",], aes(Dekada, Średnia, shape = Month, fill = Month, color = Month)) + 
  geom_line(aes(group = Month)) +
  geom_point(color = "black", size = 3, stroke = 0.9) +
  scale_shape_manual(values = c("Sierpień" = 24)) +
  scale_color_manual(values = c(
    "Sierpień" = "goldenrod1")) +
  scale_fill_manual(values = c(
    "Sierpień" = "goldenrod1")) +
  guides(color = guide_legend(title = "Miesiąc"),
         fill = guide_legend(title = "Miesiąc"),
         shape = guide_legend(title = "Miesiąc")) +
  labs(title = "Średnie Temperatury Dekadowe w Sierpniu w Białymstoku", y = "Temperatura [°C]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(avgTemp$Rok), "-", max(avgTemp$Rok)))

ggplot(decTemp[decTemp$Month == "Listopad",], aes(Dekada, Średnia, shape = Month, fill = Month, color = Month)) + 
  geom_line(aes(group = Month)) +
  geom_point(color = "black", size = 3, stroke = 0.9) +
  scale_shape_manual(values = c("Listopad" = 24)) +
  scale_color_manual(values = c(
    "Listopad" = "tomato1")) +
  scale_fill_manual(values = c(
    "Listopad" = "tomato1")) +
  guides(color = guide_legend(title = "Miesiąc"),
         fill = guide_legend(title = "Miesiąc"),
         shape = guide_legend(title = "Miesiąc")) +
  labs(title = "Średnie Temperatury Dekadowe w Listopadzie w Białymstoku", y = "Temperatura [°C]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(avgTemp$Rok), "-", max(avgTemp$Rok)))

#===============================================================================
seasonsRain <- seasonsRain %>%
  filter(Rok < 2021)

seasonsRain <- seasonsRain %>%
  mutate(Dekada = paste0(1951 + floor((Rok - 1951) / 10) * 10, "–", 
                         1951 + floor((Rok - 1951) / 10) * 10 + 9))

decRain <- seasonsRain %>%
  group_by(Dekada, Month) %>%
  summarise(Średnia = mean(Opady, na.rm = TRUE), .groups = "drop")

ggplot(decRain, aes(Dekada, Średnia, shape = Month, fill = Month, color = Month)) + 
  geom_line(aes(group = Month)) +
  geom_point(color = "black", size = 3, stroke = 0.9) +
  scale_shape_manual(values = c("Maj" = 21, 
                                "Sierpień" = 22, 
                                "Listopad" = 23, 
                                "Luty" = 24)) +
  scale_color_manual(values = c(
    "Maj" = "springgreen3",
    "Sierpień" = "goldenrod1",
    "Listopad" = "tomato1",
    "Luty" = "steelblue1")) +
  scale_fill_manual(values = c(
    "Maj" = "springgreen3",
    "Sierpień" = "goldenrod1",
    "Listopad" = "tomato1",
    "Luty" = "steelblue1")) +
  guides(color = guide_legend(title = "Miesiąc"),
         fill = guide_legend(title = "Miesiąc"),
         shape = guide_legend(title = "Miesiąc")) +
  labs(title = "Średnie Sumy Opadów Dekadowych w Białymstoku", y = "Opady [mm]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(totRain$Rok), "-", max(totRain$Rok)))

ggplot(decRain[decRain$Month == "Luty",], aes(Dekada, Średnia, shape = Month, fill = Month, color = Month)) + 
  geom_line(aes(group = Month)) +
  geom_point(color = "black", size = 3, stroke = 0.9) +
  scale_shape_manual(values = c("Luty" = 24)) +
  scale_color_manual(values = c(
    "Luty" = "steelblue1")) +
  scale_fill_manual(values = c(
    "Luty" = "steelblue1")) +
  guides(color = guide_legend(title = "Miesiąc"),
         fill = guide_legend(title = "Miesiąc"),
         shape = guide_legend(title = "Miesiąc")) +
  labs(title = "Średnie Sumy Opadów Dekadowych w Lutym w Białymstoku", y = "Opady [mm]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(totRain$Rok), "-", max(totRain$Rok)))

ggplot(decRain[decRain$Month == "Maj",], aes(Dekada, Średnia, shape = Month, fill = Month, color = Month)) + 
  geom_line(aes(group = Month)) +
  geom_point(color = "black", size = 3, stroke = 0.9) +
  scale_shape_manual(values = c("Maj" = 24)) +
  scale_color_manual(values = c(
    "Maj" = "springgreen3")) +
  scale_fill_manual(values = c(
    "Maj" = "springgreen3")) +
  guides(color = guide_legend(title = "Miesiąc"),
         fill = guide_legend(title = "Miesiąc"),
         shape = guide_legend(title = "Miesiąc")) +
  labs(title = "Średnie Sumy Opadów Dekadowych w Maju w Białymstoku", y = "Opady [mm]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(totRain$Rok), "-", max(totRain$Rok)))

ggplot(decRain[decRain$Month == "Sierpień",], aes(Dekada, Średnia, shape = Month, fill = Month, color = Month)) + 
  geom_line(aes(group = Month)) +
  geom_point(color = "black", size = 3, stroke = 0.9) +
  scale_shape_manual(values = c("Sierpień" = 24)) +
  scale_color_manual(values = c(
    "Sierpień" = "goldenrod1")) +
  scale_fill_manual(values = c(
    "Sierpień" = "goldenrod1")) +
  guides(color = guide_legend(title = "Miesiąc"),
         fill = guide_legend(title = "Miesiąc"),
         shape = guide_legend(title = "Miesiąc")) +
  labs(title = "Średnie Sumy Opadów Dekadowych w Sierpniu w Białymstoku", y = "Opady [mm]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(totRain$Rok), "-", max(totRain$Rok)))

ggplot(decRain[decRain$Month == "Listopad",], aes(Dekada, Średnia, shape = Month, fill = Month, color = Month)) + 
  geom_line(aes(group = Month)) +
  geom_point(color = "black", size = 3, stroke = 0.9) +
  scale_shape_manual(values = c("Listopad" = 24)) +
  scale_color_manual(values = c(
    "Listopad" = "tomato1")) +
  scale_fill_manual(values = c(
    "Listopad" = "tomato1")) +
  guides(color = guide_legend(title = "Miesiąc"),
         fill = guide_legend(title = "Miesiąc"),
         shape = guide_legend(title = "Miesiąc")) +
  labs(title = "Średnie Sumy Opadów Dekadowych w Listopadzie w Białymstoku", y = "Opady [mm]", 
       color = "Miesiąc", 
       caption = paste("Dane historyczne dla lat:", min(totRain$Rok), "-", max(totRain$Rok)))
