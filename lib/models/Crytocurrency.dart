class CryptoCurrency {
  // final String id;
  bool isFavorite;
  final String symbol;
  final String
      fullName; // Assuming fullname corresponds to the name_full from the list API
  final String
      icon; // Assuming icon corresponds to the icon_url from the list API
  final String exchangeRate; // Using 6 decimal places for exchangeRate
  //double? marketCap; // You can calculate this based on the rates and max_supply if needed
  // int? marketCapRank; // This might be provided separately in another API
  // double? high24; // This might be provided separately in another API
  // double? low24; // This might be provided separately in another API
  // double? priceChange24; // This might be provided separately in another API
  // double? priceChangePercentage24; // This might be provided separately in another API
  // double? circulatingSupply; // This might be provided separately in another API
  // double? ath; // This might be provided separately in another API
  // double? atl; // This might be provided separately in another API

  CryptoCurrency(
      {
      // required this.id,
      required this.symbol,
      required this.fullName,
      required this.icon,
      required this.exchangeRate,
      this.isFavorite = false //Added default value
      // this.marketCap,
      // this.marketCapRank,
      // this.high24,
      // this.low24,
      // this.priceChange24,
      // this.priceChangePercentage24,
      // this.circulatingSupply,
      // this.ath,
      // this.atl,
      });

  // factory CryptoCurrency.fromJSON(Map<String, dynamic> map) {
  //   return CryptoCurrency(
  //     id: map['symbol'],
  //     symbol: map['symbol'],
  //     fullname: map['name_full'],
  //     icon: map['icon_url'],
  //     exchangeRate: double.parse((map['exchangeRate'] ?? 0.0).toStringAsFixed(6)),
  //     // Other fields can be initialized similarly or left as null.
  //   );
  // }
}
