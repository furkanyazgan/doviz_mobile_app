var forexAllCurs = {
  "currencies": [
    "USDTRY",
    "EURTRY",
    "GBPTRY",
    "CHFTRY",
    "SARTRY",
    "SEKTRY",
    "NOKTRY",
    "AUDTRY",
    "CADTRY",
  ],
  "mines": [
    "HAS",
    "ONS",
    "USDTRY",
    "EURTRY",
    "EURUSD",
    "KGUSD",
    "KGEUR",
    "XAGUSD",
    "GUMUSD",
    "GUMEUR",
    "GUMTRY",
  ],
  "sarrafiyeler": [
    "YENI CEYREK",
    "ESKI CEYREK",
    "YENI YARIM",
    "ESKI YARIM",
    "YENI TAM",
    "ESKI TAM",
    "YENI GREMSE",
    "ESKI GREMSE",
    "YENI ATA(CUMHURIYET)",
    "ESKI ATA(CUMHURIYET)",
    "YENI ATA 5",
    "ESKI ATA 5",
    "ESKI RESAT",
    "ESKI RESAT 2.5",
    "ESKI RESAT 5",
  ],
  "gramlar": [
    "HASGRAM",
    "USDTRY",
    "EURTRY",
    "1 Gr (24)",
    "22AYAR",
    "1 Gr (22)",
    "18AYAR",
    "14AYAR",
    "0.5 Gr (24)",
    "0.5 Gr (22)",
    "2.5 Gr (24)",
    "5 Gr (24)",
    "10 Gr (24)",
    "20 Gr (24)",
    "50 Gr (24)",
    "100 Gr (24)",
  ],
  "pariteler": [],
};

var haremAllCurs = {
  "currencies": [
    "USDTRY",
    "EURTRY",
    "EURUSD",
    "JPYTRY",
    "GBPTRY",
    "DKKTRY",
    "SEKTRY",
    "NOKTRY",
    "CHFTRY",
    "AUDTRY",
    "CADTRY",
    "SARTRY",
    "RUBTRY",
    "BGNTRY",
    "AEDTRY",
    "QARTRY",
    "CNYTRY",
  ],
  "mines": [
    "HAS",
    "ONS",
    "KGUSD",
    "KGEUR",
    "14AYAR",
    "22AYAR",
    "XAUXAG",
    "XAGUSD",
    "GUMUSD",
    "GUMTRY",
    "XPTUSD",
    "XPDUSD",
    "PLATIN",
    "PALADYUM",
  ],
  "sarrafiyeler": [
    "YENI CEYREK",
    "ESKI CEYREK",
    "YENI YARIM",
    "ESKI YARIM",
    "YENI TAM",
    "ESKI TAM",
    "YENI ATA",
    "ESKI ATA",
    "YENI GREMSE",
    "ESKI GREMSE",
    "YENI ATA 5",
    "ESKI ATA 5",
  ],
  "gramlar": [],
  "pariteler": [
    "GBPUSD",
    "USDCHF",
    "AUDUSD",
    "USDDKK",
    "USDCAD",
    "USDJPY",
    "USDSAR",
    "USDSEK",
    "USDNOK",
    "USDRUB",
    "USDBGN",
    "JODUSD",
    "OMRUSD",
    "USDQAR",
    "AEDUSD",
    "KWDUSD",
    "USDDILS",
    "USDMAD",
  ],
};

var saglamAllCurs = {
  "currencies": [
    "USDTRY",
    "EURTRY",
    "EURUSD",
    "GBPTRY",
    "DKKTRY",
    "SEKTRY",
    "NOKTRY",
    "CHFTRY",
    "JPYTRY",
    "AUDTRY",
    "CADTRY",
    "SARTRY",
  ],
  "mines": [
    "HAS",
    "ONS",
    "KGUSD",
    "KGEUR",
    "XAGUSD",
    "GUMTRY",
    "GUMUSD",
    "GUMEUR",
  ],
  "sarrafiyeler": [
    "YENI CEYREK",
    "ESKI CEYREK",
    "YENI YARIM",
    "ESKI YARIM",
    "YENI TAM",
    "ESKI TAM",
    "YENI GREMSE",
    "ESKI GREMSE",
    "YENI ZIYNET 5",
    "ESKI ZIYNET 5",
    "YENI ATA CEYREK",
    "ESKI ATA CEYREK",
    "YENI ATA YARIM",
    "ESKI ATA YARIM",
    "YENI ATA",
    "ESKI ATA",
    "YENI ATA 2.5",
    "ESKI ATA 2.5",
    "YENI ATA 5",
    "ESKI ATA 5",
    "ESKI RESAT CEYREK",
    "ESKI RESAT YARIM",
    "ESKI RESAT",
    "ESKI RESAT 2.5",
    "ESKI RESAT 5",
  ],
  "gramlar": [
    "0.25 Paketli (22)",
    "0.50 Paketli (22)",
    "0.50 Kulplu (22)",
    "1 Gr Paketli (22)",
    "1 Gr Kulplu (22)",
    "2 Gr Kulplu (22)",
    "0.5 Gr (24)",
    "1 Gr (24)",
    "2 Gr (24)",
    "2.5 Gr (24)",
    "5 Gr (24)",
    "10 Gr (24)",
    "20 Gr (24)",
    "50 Gr (24)",
    "100 Gr (24)",
    "250 Gr (24)",
    "500 Gr (24)",
  ],
  "pariteler": [
    "GBPUSD",
    "USDCHF",
    "AUDUSD",
    "USDDKK",
    "USDCAD",
    "USDJPY",
    "USDSAR",
    "USDSEK",
    "USDNOK",
  ],
};

Future<Map<String, List>> seperateCursWithPush(curArray, source) async {
  var currData = [];
  var mineData = [];
  var sarrData = [];
  var gramData = [];
  var pariteData = [];
  var allCurs = {};

  if (source == "FOREX") {
    allCurs = forexAllCurs;
  } else if (source == "HAREM") {
    allCurs = haremAllCurs;
  } else if (source == "SAGLAMOGLU") {
    allCurs = saglamAllCurs;
  }

  for (int i = 0; i < allCurs["currencies"].length; i++) {
    int curIndex =
        curArray.indexWhere((item) => item["symbol"] == allCurs["currencies"][i]);
    if (curIndex != -1) {
      currData.add(curArray[curIndex]);
    }
  }

  for (int i = 0; i < allCurs["mines"].length; i++) {
    int curIndex =
        curArray.indexWhere((item) => item["symbol"] == allCurs["mines"][i]);
    if (curIndex != -1) {
      mineData.add(curArray[curIndex]);
    }
  }

  for (int i = 0; i < allCurs["sarrafiyeler"].length; i++) {
    int curIndex = curArray
        .indexWhere((item) => item["symbol"] == allCurs["sarrafiyeler"][i]);
    if (curIndex != -1) {
      sarrData.add(curArray[curIndex]);
    }
  }

  for (int i = 0; i < allCurs["gramlar"].length; i++) {
    int curIndex =
        curArray.indexWhere((item) => item["symbol"] == allCurs["gramlar"][i]);
    if (curIndex != -1) {
      gramData.add(curArray[curIndex]);
    }
  }

  for (int i = 0; i < allCurs["pariteler"].length; i++) {
    int curIndex =
        curArray.indexWhere((item) => item["symbol"] == allCurs["pariteler"][i]);
    if (curIndex != -1) {
      pariteData.add(curArray[curIndex]);
    }
  }
  return {
    "currData": currData,
    "mineData": mineData,
    "sarrData": sarrData,
    "gramData": gramData,
    "pariteData": pariteData
  };
}
