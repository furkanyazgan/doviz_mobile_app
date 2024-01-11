Map<String, String> setCurrencyDisp(String symbol) {
  String cur1 = symbol.substring(0, 3);
  String cur2 = symbol.substring(3, symbol.length);
  String icon1 = "assets/images/currency_and_mine_icons/${cur1}.png";
  String icon2 = "assets/images/currency_and_mine_icons/${cur2}.png";
  cur1 = cur1 + "/";
  return {"cur1": cur1, "cur2": cur2, "icon1": icon1, "icon2": icon2};
}

Map<String, String> setMineDisp(String symbol) {
  String cur1 = "";
  String cur2 = "";
  String icon1 = "";
  String icon2 = "";
  if (symbol == "ONS") {
    cur1 = "ONS";
    icon1 = "assets/images/currency_and_mine_icons/XAU.png";
  } else if (symbol == "HAS") {
    cur1 = "HAS ALTIN";
    icon1 = "assets/images/currency_and_mine_icons/XAU.png";
  } else if (symbol.contains("AYAR")) {
    cur1 = symbol.substring(0, 2) + " " + symbol.substring(2, symbol.length);
    icon1 = "assets/images/currency_and_mine_icons/XAU.png";
  } else if (symbol == "PLATIN" || symbol == "PALADYUM") {
    cur1 = symbol;
    icon1 = "assets/images/currency_and_mine_icons/XAG.png";
  } else {
    cur1 = symbol.substring(0, symbol.length - 3);
    cur2 = symbol.substring(symbol.length - 3, symbol.length);
    if (cur1 == "XPT" || cur1 == "XPD") {
      icon1 = "assets/images/currency_and_mine_icons/XAG.png";
    } else {
      icon1 = "assets/images/currency_and_mine_icons/${cur1}.png";
    }
    icon2 = "assets/images/currency_and_mine_icons/${cur2}.png";
  }
  if (cur2 != "") {
    cur1 = cur1 + "/";
  }
  return {"cur1": cur1, "cur2": cur2, "icon1": icon1, "icon2": icon2};
}

Map<String, String> setSarrDisp(String symbol) {
  String cur1 = "";
  String icon1 = "assets/images/currency_and_mine_icons/XAU.png";
  String cur2 = "";
  String icon2 = "";
  if (symbol.contains("ATA(CUMHURIYET)")) {
    cur1 = symbol.replaceAll("(CUMHURIYET)", "");
  } else {
    cur1 = symbol;
  }
  return {"cur1": cur1, "cur2": cur2, "icon1": icon1, "icon2": icon2};
}

Map<String, String> setGramDisp(String symbol) {
  String cur2 = "";
  String icon2 = "";
  String icon1 = "assets/images/currency_and_mine_icons/XAU.png";
  String cur1 = "";
  if (symbol == "HASGRAM") {
    cur1 = "24 AYAR HAS";
  } else if (symbol.contains("AYAR")) {
    cur1 = symbol.substring(0, 2) + " " + symbol.substring(2, symbol.length);
  } else {
    cur1 = symbol;
  }
  if (symbol.contains("TRY")) {
    cur1 = symbol.substring(0, 3);
    cur2 = symbol.substring(3, symbol.length);
    icon1 = "assets/images/currency_and_mine_icons/${cur1}.png";
    icon2 = "assets/images/currency_and_mine_icons/${cur2}.png";
    cur1 = cur1 + "/";
  }

  return {"cur1": cur1, "cur2": cur2, "icon1": icon1, "icon2": icon2};
}
