# :blossom: Daisy's Helper Scripts

- [AccountData](https://github.com/daisy613/accountData) - continuously downloads all Binance/Bybit income history from multiple accounts into a sqLite db.
Can be used in tandem with Darksheer's [Crypto-PNL-Tracker](https://github.com/drksheer/Crypto-PNL-Tracker) or on its own.

- [AutoTransfer](https://github.com/daisy613/autoTransfer) - transfers a percentage of profits automatically, from Binance Futures to Spot wallet, at a predefined interval.

- [AutoCoins](https://github.com/daisy613/autoCoins) - dynamically controls the coin list in WickHunter bot to blacklist/un-blacklist coins based on the following conditions: 1hr price change percentage, proximity to All Time High and minimum coin age.

- [WHSettings](https://github.com/daisy613/whSettings) - allows user to export or import WickHunter settings or coins.

- [Crypto-PNL-Tracker](https://github.com/drksheer/Crypto-PNL-Tracker) - generic crypto PNL tracker which can work with Binance, Bybit or your own data.
 Use AccountData script in conjunction with the tracker for automatic imports.
 
- [IP Proxy Instructions](https://gist.github.com/daisy613/ea803117a3d33418a3a03dbeb0553be3#file-proxy-ip-instructions-md) - Using proxy IPs to make your bot appear to be running from another country or using multiple instances of the bot on different IPs to prevent running up against API limits at the exchange.
 
## In Progress
- _AutoSettings_ 
  - will pause the bot and change settings on schedule.
  - margin-based settings profile switch to safer settings.
- _MarginAlarm_ 
  - alerts user via Discord when a defined Margin Ratio threshold is reached, possibly other triggers?
- _AutoTransfer_
  - add reverse transfer feature that activates when Margin Ratio reaches a defined threshold.
  - add option to specify transfer in USD instead of percentage.
  - option to transfer from Spot to external wallet.

## Tips
![](https://i.imgur.com/M46tl6t.png)
- USDT (TRC20): TNuwZebdZmoDxrJRxUbyqzG48H4KRDR7wB
- USDT/ETH (ERC20): 0x56b2239c6bde5dc1d155b98867e839ac502f01ad
- BTC: 1PV97ppRdWeXw4TBXddAMNmwnknU1m37t5
