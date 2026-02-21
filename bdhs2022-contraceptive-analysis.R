library(haven)
bdir <- haven::read_dta("E:/study files/AST330 Stata for Data Science/BDIR81FL.DTA")

# data cleaning
library(tidyverse)
fertility_vars <- bdir |> 
    select(v012, v024, v025, v106, v190, 
           v201, v212, v312)

fertility <- fertility_vars %>%
    mutate(
        v024 = as_factor(v024), 
        v025 = as_factor(v025),  
        v106 = as_factor(v106),  
        v190 = as_factor(v190),  
        v312 = as_factor(v312)
    ) %>%
    mutate(
        across(c(v012, v201, v212), ~na_if(., 99))
    )

fertility <- fertility %>%
    mutate(
        contraceptive = case_when(
            is.na(v312) | v312 == "not using" ~ "Not Using",
            TRUE ~ "Using"
        ),
        contraceptive = factor(contraceptive, levels = c("Using", "Not Using"))
    )

# visualisations
library(ggplot2)
fertility |> 
    ggplot(aes(x = v201)) +
    geom_histogram(binwidth = 1, fill = "steelblue", color = "black") +
    labs(
        title = "Dist of total child ever born", 
        x = "total child ever born", 
        y = "count"
    ) +
    scale_x_continuous(breaks = 0:12)

fertility |> 
    ggplot(aes(x = v212)) +
    geom_histogram(binwidth = 1, fill = "skyblue", color = "black") +
    labs(
        title = "Dist of age of mother at first birth", 
        x = "age at first birth", 
        y = "count"
    ) +
    scale_x_continuous(breaks = seq(5, 40, 5))

# Boxplot of total children by education
fertility |> 
    ggplot(aes(v106, v201, fill = v106)) +
    geom_boxplot() +
    labs(
        title = "Total child ever born by education", 
        x = "Education level", 
        y = "Total child born"
    ) +
    theme(legend.position = "none")

# Boxplot of age at first birth by education
fertility |> 
    ggplot(aes(v106, v212, fill = v106)) +
    geom_boxplot() +
    labs(
        title = "Age at first birth by education level", 
        x = "Education level", 
        y = "Age at first birth"
    ) +
    theme(legend.position = "none")

# Boxplot of age at first birth by Wealth
fertility |> 
    ggplot(aes(v190, v212, fill = v190)) +
    geom_boxplot() +
    labs(
        title = "Age at first birth by Wealth", 
        x = "Wealth", 
        y = "Age at first birth"
    ) +
    theme(legend.position = "none")

# Boxplot of age at first birth by Division
fertility |> 
    ggplot(aes(v024, v212, fill = v024)) +
    geom_boxplot() +
    labs(
        title = "Age at first birth by Division", 
        x = "Division", 
        y = "Age at first birth"
    ) +
    theme(legend.position = "none")

# Bar plot of contraceptive use by wealth
fertility %>%
    ggplot(aes(x = v190, fill = contraceptive)) +
    geom_bar(position = "fill") +  
    scale_fill_manual(values = c("Using" = "darkgreen", "Not Using" = "lightgray")) +
    labs(
        title = "Current Contraceptive Use by Wealth Index",
        x = "Wealth Index",
        y = "Percentage",
        fill = "Contraceptive Use"
    ) 

# Bar plot of contraceptive use by Education level
fertility %>%
    ggplot(aes(x = v106, fill = contraceptive)) +
    geom_bar(position = "fill") + 
    scale_fill_manual(values = c("Using" = "forestgreen", "Not Using" = "lightgray")) +
    labs(
        title = "Current Contraceptive Use by Education level",
        x = "Education level",
        y = "Percentage",
        fill = "Contraceptive Use"
    ) 

# Bar plot of contraceptive use by place of residence
fertility %>%
    ggplot(aes(x = v025, fill = contraceptive)) +
    geom_bar(position = "fill") + 
    scale_fill_manual(values = c("Using" = "forestgreen", "Not Using" = "lightgray")) +
    labs(
        title = "Current Contraceptive Use by place of residence",
        x = "Place of residenc",
        y = "Percentage",
        fill = "Contraceptive Use"
    ) 


# Bar plot of contraceptive use by Division
fertility %>%
    ggplot(aes(x = v024, fill = contraceptive)) +
    geom_bar(position = "fill") + 
    scale_fill_manual(values = c("Using" = "forestgreen", "Not Using" = "lightgray")) +
    labs(
        title = "Current Contraceptive Use by Division",
        x = "Division",
        y = "Percentage",
        fill = "Contraceptive Use"
    )


## Statistical tests:
table_education <- table(fertility$contraceptive, fertility$v106)
chi_edu <- chisq.test(table_education)
chi_edu

table_wealth <- table(fertility$contraceptive, fertility$v190)
chi_wealth <- chisq.test(table_wealth)
chi_wealth

table_residence <- table(fertility$contraceptive, fertility$v025)
chisq.test(table_residence)

table_division <- table(fertility$contraceptive, fertility$v024)
chisq.test(table_division)

fertility %>%
    filter(!is.na(v012), !is.na(contraceptive)) %>%
    ggplot(aes(x = v012, y = as.numeric(contraceptive == "Using"))) +
    geom_smooth(method = "loess", color = "forestgreen", se = FALSE) +
    labs(
        title = "Trend of Contraceptive Use by Age",
        x = "Age",
        y = "Probability of Using"
    ) +
    scale_y_continuous(labels = scales::percent_format())


## Logistic regression
fertility <- fertility %>%
    mutate(age_sq = v012^2)

model_logit <- glm(
    contraceptive ~ v012 + age_sq + v106 + v190 + v025 + v024,
    data = fertility,
    family = binomial
)

summary(model_logit