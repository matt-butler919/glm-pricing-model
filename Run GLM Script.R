library(dplyr)

data(dataCar)

dataCar <- dataCar %>%
  mutate (
    agecat = factor(agecat),
    veh_age = factor(veh_age),
    gender = factor(gender),
    area = factor(area),
    veh_body = factor(veh_body),
    log_veh_value = log(veh_value + 1)
  )

#Set reference levels
dataCar$agecat <- relevel(dataCar$agecat, ref = "3")
dataCar$area <- relevel(dataCar$area, ref = "C")
dataCar$gender <- relevel(dataCar$gender, ref = "F")
dataCar$veh_age <- relevel(dataCar$veh_age, ref = "3")
dataCar$veh_body <- relevel(dataCar$veh_body, ref = "SEDAN")

#Frequency GLM
glm_freq <- glm(
  numclaims ~ offset(log(exposure)) + agecat + gender + area + veh_age + + veh_body + log_veh_value,
  data = dataCar,
  family = poisson(link = "log")
  )

#Severity GLM
claims_only <- dataCar %>%
  filter(clm == 1)

glm_sev <- glm(
  claimcst0 ~agecat + gender + area + veh_age + veh_body + log_veh_value,
  data = claims_only,
  family = Gamma(link = "log")
  )

#Extract coefficients and relativities
freq_results <- data.frame(
  variable = names(coef(glm_freq)),
  freq_coefficient = round(coef(glm_freq), 4),
  freq_relativity = round(exp(coef(glm_freq)), 4),
  freq_lower95 = round(exp(confint(glm_freq)[,1]), 4),
  freq_upper95 = round(exp(confint(glm_freq)[,2]), 4)
  )

sev_results <- data.frame(
  variable = names(coef(glm_sev)),
  sev_coefficient = round(coef(glm_sev), 4),
  sev_relativity = round(exp(coef(glm_sev)), 4),
  sev_lower95 = round(exp(confint(glm_sev)[,1]), 4),
  sev_upper95 = round(exp(confint(glm_sev)[,2]), 4)
  )

#Export
write.csv(freq_results, "frequency_results.csv", row.names = FALSE)
write.csv(sev_results, "severity_results.csv", row.names = FALSE)

dataCar$pred_freq <- predict(glm_freq, type = "response") / dataCar$exposure
dataCar$pred_sev <- predict(glm_sev, newdata = dataCar, type = "response")
dataCar$pure_premium <- dataCar$pred_freq * dataCar$pred_sev

write.csv(dataCar, "dataCar_with_predictions.csv", row.names = FALSE)
