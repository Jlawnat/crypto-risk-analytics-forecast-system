library(PerformanceAnalytics)
library(moments)

summary_statistics <- data.frame(
  
  Mean      = colMeans(log_returns),
  
  Median    = apply(log_returns, 2, median),
  
  SD        = apply(log_returns, 2, sd),
  
  Minimum   = apply(log_returns, 2, min),
  
  Maximum   = apply(log_returns, 2, max),
  
  Skewness  = apply(log_returns, 2, skewness),
  
  Kurtosis  = apply(log_returns, 2, kurtosis)
  
)

print(summary_statistics)

write.csv(
  summary_statistics,
  "outputs/tables/summary_statistics.csv",
  row.names = TRUE
)


correlation_matrix <- cor(log_returns)

print(correlation_matrix)

write.csv(
  correlation_matrix,
  "outputs/tables/correlation_matrix.csv"
)


png("figures/log_returns.png",
    width = 1400,
    height = 900)

plot(log_returns,
     main = "Daily Log Returns",
     major.ticks = "years",
     col = 1:4)

dev.off()

png("figures/performance_summary.png",
    width = 1400,
    height = 900)

charts.PerformanceSummary(log_returns)

dev.off()

png("figures/return_histograms.png",
    width = 1400,
    height = 900)

par(mfrow = c(2,2))

for(i in 1:ncol(log_returns)){
  
  hist(log_returns[,i],
       
       main = colnames(log_returns)[i],
       
       xlab = "Daily Log Return",
       
       col = "lightblue",
       
       border = "white")
  
}

dev.off()

par(mfrow=c(1,1))

library(tseries)
library(dplyr)
adf_results <- data.frame(
  Cryptocurrency = character(),
  ADF_Statistic = numeric(),
  P_Value = numeric(),
  Stationary = character(),
  stringsAsFactors = FALSE
)
for (coin in colnames(log_returns)) {
  
  test <- adf.test(log_returns[, coin])
  
  adf_results <- rbind(
    adf_results,
    data.frame(
      Cryptocurrency = coin,
      ADF_Statistic = unname(test$statistic),
      P_Value = test$p.value,
      Stationary = ifelse(test$p.value < 0.05, "Yes", "No")
    )
  )
}
write.csv(
    adf_results,
    "outputs/tables/adf_results.csv",
    row.names = FALSE )

library(FinTS)
arch_results <- data.frame(
  Cryptocurrency = character(),
  LM_Statistic = numeric(),
  P_Value = numeric(),
  ARCH_Effect = character(),
  stringsAsFactors = FALSE
)
for (coin in colnames(log_returns)) {
  
  mean_model <- lm(log_returns[, coin] ~ 1)
  
  test <- ArchTest(residuals(mean_model), lags = 12)
  
  arch_results <- rbind(
    arch_results,
    data.frame(
      Cryptocurrency = coin,
      LM_Statistic = unname(test$statistic),
      P_Value = test$p.value,
      ARCH_Effect = ifelse(test$p.value < 0.05, "Yes", "No")
    )
  )
}
write.csv(
  arch_results,
  "outputs/tables/arch_test_results.csv",
  row.names = FALSE
)


















