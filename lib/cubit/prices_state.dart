part of 'prices_cubit.dart';

class PricesState {
  StateData oldState;
  StateData nowState;

  PricesState({required this.oldState, required this.nowState});
}

class StateData {
  bool isEmpty;
  String data_source;
  List<dynamic> currData;
  List<dynamic> mineData;
  List<dynamic> sarrData;
  List<dynamic> gramData;
  List<dynamic> pariteData;

  StateData(
      {required this.isEmpty,
      required this.data_source,
      required this.currData,
      required this.mineData,
      required this.sarrData,
      required this.gramData,
      required this.pariteData});
}
