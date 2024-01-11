Map<String, dynamic> getSymbolFind(
    String cur1, String cur2, List<dynamic> data) {
  String symbol = "";
  if (cur1.contains("*") && cur2 =="TRY") {
    cur2 = "";
  }
  symbol = cur1 + cur2;

  if(symbol.contains("-")){
    return {"symbol": "null", "buy": 0.0, "sell": 0.0};
  }

  for (int i = 0; i < data.length; i++) {
    if (symbol == data[i]["symbol"]) {
      return data[i];
    }
  }

  return {"symbol": "null", "buy": "Bu değer şuan için hesaplanamıyor.", "sell": "Bu değer şuan için hesaplanamıyor."};
}
