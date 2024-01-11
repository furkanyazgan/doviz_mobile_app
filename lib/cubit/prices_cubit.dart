import 'package:bloc/bloc.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ornek_deneme_calisma/functions/curSeperator.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'prices_state.dart';

class PricesCubit extends Cubit<PricesState> {
  PricesCubit()
      : super(PricesState(
            oldState: StateData(
                data_source: "empty",
                isEmpty: true,
                currData: [],
                mineData: [],
                sarrData: [],
                gramData: [],
                pariteData: []),
            nowState: StateData(
                data_source: "empty",
                isEmpty: true,
                currData: [],
                mineData: [],
                sarrData: [],
                gramData: [],
                pariteData: [])));

  StateData oldState = StateData(
      isEmpty: true,
      data_source: "empty",
      currData: [],
      mineData: [],
      sarrData: [],
      gramData: [],
      pariteData: []);

  Future<void> getPrices() async {
    String url_aws = dotenv.get("URL_AWS", fallback: "URL_AWS not found");

    String adminUrl_aws =
        dotenv.get("ADMIN_URL_AWS", fallback: "URL_AWS not found");

    Future<String> adminRes() async {
      var body = {
        'user_id': "3",
      };
      var data = await http.post(Uri.parse(adminUrl_aws), body: body);
      return data.body;
    }

    Future<String> res(String userSourceData) async {
      var body = jsonEncode(<String, String>{
        'data_source': userSourceData,
      });
      var data = await http.post(
        Uri.parse(url_aws),
        body: body,
      );
      return data.body;
    }

    var adminResStr = await adminRes();

    var adminData = jsonDecode(jsonDecode(jsonDecode(adminResStr))["data"]);

    var userSource = adminData[0]["fields"]["source"];

    state.nowState.data_source = userSource;
    emit(state);


    var dataStr = jsonDecode(await res(userSource))["data"];

    var data = jsonDecode(dataStr);

    var curDatum;
    var stateData = [];
    var goldCalcData = [{}, {}, {}];

    for (int i = 0; i < adminData.length; i++) {
      if (adminData[i]["fields"]["symbol"] == "USDTRY") {
        goldCalcData[0] = data[i];
      } else if (adminData[i]["fields"]["symbol"] == "ONS") {
        goldCalcData[1] = data[i];
      } else if (adminData[i]["fields"]["symbol"] == "HAS") {
        goldCalcData[2] = data[i];
      }

      if (adminData[i]["fields"]["is_active"]) {
        curDatum = {
          "symbol": data[i]["symbol"],
          "buy": data[i]["buy"],
          "sell": data[i]["sell"],
          "buy_open": data[i]["buy_open"],
          "sell_open": data[i]["sell_open"],
          "buy_percentage": adminData[i]["fields"]["buy_percentage"],
          "sell_percentage": adminData[i]["fields"]["sell_percentage"],
          "tl_buy": adminData[i]["fields"]["tl_buy"],
          "tl_sell": adminData[i]["fields"]["tl_sell"],
          "is_percentage": adminData[i]["fields"]["is_percentage"],
          "milyem_buy": adminData[i]["fields"]["milyem_buy"],
          "milyem_sell": adminData[i]["fields"]["milyem_sell"],
          "milyem_fast_buy": adminData[i]["fields"]["milyem_fast_buy"],
          "milyem_fast_sell": adminData[i]["fields"]["milyem_fast_sell"],
          "is_fast_milyem": adminData[i]["fields"]["is_fast_milyem"],
          "milyem_bulk_buy": adminData[i]["fields"]["milyem_bulk_buy"],
          "milyem_bulk_sell": adminData[i]["fields"]["milyem_bulk_sell"],
          "weight": adminData[i]["fields"]["weight"],
        };

        stateData.add(curDatum);
      }
    }

    Map<String, List> curData =
        await seperateCursWithPush(stateData, userSource);

    oldState = state.nowState;

    var temp = PricesState(
        oldState: oldState,

        nowState: StateData(
            isEmpty: false,
            data_source: userSource,
            currData: curData["currData"] as List<dynamic>,
            mineData: curData["mineData"] as List<dynamic>,
            sarrData: curData["sarrData"] as List<dynamic>,
            gramData: curData["gramData"] as List<dynamic>,
            pariteData: curData["pariteData"] as List<dynamic>));

    emit(temp);
  }
}
