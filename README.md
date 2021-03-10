# Daisy's [WickHunter](https://github.com/WickHunter/Wick-Hunter) helper scripts

![](https://i.imgur.com/YSjTO9j.png)

- [AccountData](https://github.com/daisy613/accountData) - continuously downloads all Binance/Bybit income history from multiple accounts into a sqLite db.
Can be used in tandem with Darksheer's Crypto-PNL-Tracker or on its own.

- [AutoTransfer](https://github.com/daisy613/autoTransfer) -  continuously transfers a percentage of profits automatically on a Binance Futures account, from Futures to Spot wallet, at a predefined interval.

- [WHSettings](https://github.com/daisy613/whSettings) - allows user to export or import WickHunter settings or coins.

- [Crypto-PNL-Tracker](https://github.com/drksheer/Crypto-PNL-Tracker) - generic crypto PNL tracker which can work with Binance, Bybit or your own data.
 Use AccountData script in conjunction with the tracker for automatic imports.
 
## In Progress
- _AutoSettings_ 
  - will pause the bot and change settings on schedule.
  - margin-based settings profile switch to safer settings.
- _MarginAlarm_ 
  - alerts user via Discord when a defined Margin Ratio threshold is reached, possibly other triggers?.
- _AutoTransfer_
  - add reverse transfer feature that activates when Margin Ratio reaches a defined threshold.
  - add option to specify transfer in USD instead of percentage.
- _AutoCoins_
  - filter coins based on market cap (exclude any coin below a certain threshold)
  - coin age (exclude any coins below a certain age)
  - Near ATH (how to define?)
  - 24h (or longer) liquidations volume, specify max average liquidation volume.

## Tips
- BTC: 1PV97ppRdWeXw4TBXddAMNmwnknU1m37t5
- USDT (TRC20): TNuwZebdZmoDxrJRxUbyqzG48H4KRDR7wB
- USDT/ETH (ERC20): 0x56b2239c6bde5dc1d155b98867e839ac502f01ad
