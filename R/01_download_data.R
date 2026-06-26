library(quantmod)
BTC <- Ad(getSymbols("BTC-USD",
                     src = "yahoo",
                     from = "2020-01-01",
                     auto.assign = FALSE))
ETH <- Ad(getSymbols("ETH-USD",
                     src = "yahoo",
                     from = "2020-01-01",
                     auto.assign = FALSE))
SOL <- Ad(getSymbols("SOL-USD",
                     src = "yahoo",
                     from = "2020-01-01",
                     auto.assign = FALSE))
BNB <- Ad(getSymbols("BNB-USD",
                     src = "yahoo",
                     from = "2020-01-01",
                     auto.assign = FALSE))

write_csv(
  data.frame(
    Date = index(BTC),
    Price = coredata(BTC)
  ),
  "data/raw/BTC_prices.csv"
)

write_csv(
  data.frame(
    Date = index(ETH),
    Price = coredata(ETH)
  ),
  "data/raw/ETH_prices.csv"
)

write_csv(
  data.frame(
    Date = index(SOL),
    Price = coredata(SOL)
  ),
  "data/raw/SOL_prices.csv"
)

write_csv(
  data.frame(
    Date = index(BNB),
    Price = coredata(BNB)
  ),
  "data/raw/BNB_prices.csv"
)

