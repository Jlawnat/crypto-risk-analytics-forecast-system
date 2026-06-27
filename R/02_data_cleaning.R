library(quantmod)
library(xts)
library(tidyverse)

crypto_prices <- merge(BTC, ETH, SOL, BNB)
colnames(crypto_prices) <- c("BTC", "ETH", "SOL", "BNB")
crypto_prices=na.omit(crypto_prices)
log_returns =na.omit(diff(log(crypto_prices)))
dir.create("data/processed", showWarnings = FALSE, recursive = TRUE)
log_returns_df <- data.frame(
  Date = index(log_returns),
  coredata(log_returns)
)

write_csv(
  log_returns_df,
  "data/processed/cleaned_returns.csv"
)

library(ggplot2)
library(tidyr)

plot_data <- log_returns_df |>
  pivot_longer(
    cols = c(BTC, ETH, SOL, BNB),
    names_to = "Cryptocurrency",
    values_to = "Log_Return"
  )

p <- ggplot(plot_data,
            aes(Date, Log_Return, colour = Cryptocurrency)) +
  geom_line(linewidth = 0.4) +
  labs(
    title = "Daily Log Returns",
    x = "Date",
    y = "Log Return"
  ) +
  theme_minimal()

dir.create("figures", showWarnings = FALSE)

ggsave(
  "figures/log_returns.png",
  plot = p,
  width = 10,
  height = 5,
  dpi = 300
)
