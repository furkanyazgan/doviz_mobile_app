import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ornek_deneme_calisma/cubit/prices_cubit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../constants/projectcolors.dart';
import '../custom_tabbar.dart';
import 'package:ornek_deneme_calisma/functions/calculationValueIconSetter.dart';
import 'package:ornek_deneme_calisma/functions/calculationsymbolfind.dart';

class CalculationSection extends StatefulWidget {
  const CalculationSection({Key? key}) : super(key: key);

  @override
  _CalculationSectionState createState() => _CalculationSectionState();
}

class _CalculationSectionState extends State<CalculationSection> {
  //customtabbar seçilen index
  int selectIndex = 0;
  late List<dynamic> data;

  List<String> strList = ["Döviz", "Gram", "Sarrafiye"];

  //dispNameIconSetter dosyasından data türene göre seçilen function
  late var calculationValueIconSetterFunctionSelect;

  //virgülden sonra kaç basamak gözükecek?
  late int virgulSonrasiBasamak;

  // dropdownbutton1 için değişkenler
  late String selectedItem = "-";
  List<String> itemsControl = ["-"];
  late List<DropdownMenuItem<String>> items;

  //----------------------------

  // dropdownbutton2için değişkenler
  late String selectedItem2 = "-";
  List<String> items2Control = ["-"];
  late List<DropdownMenuItem<String>> items2;

  //----------------------------

  //textfield için miktar değişkeni
  String textFieldValue = "1";

  late ProjectColors themeProjectColors;

  @override
  void initState() {
    super.initState();
  }

  void changeData() {
    String temp = context.read<PricesCubit>().state.nowState.data_source;
    switch (temp) {
      case "FOREX":
        {
          strList = ["Genel", "Döviz", "Sarrafiye", "Gram Altın"];
          switch (selectIndex) {
            case 0:
              {
                data = context.read<PricesCubit>().state.nowState.mineData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationMineDisp;
                virgulSonrasiBasamak = 2;
              }
              break;
            case 1:
              {
                data = context.read<PricesCubit>().state.nowState.currData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationCurrencyDisp;
                virgulSonrasiBasamak = 3;
              }
              break;
            case 2:
              {
                data = context.read<PricesCubit>().state.nowState.sarrData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationSarrDisp;
                virgulSonrasiBasamak = 3;
              }
              break;
            case 3:
              {
                data = context.read<PricesCubit>().state.nowState.gramData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationGramDisp;
                virgulSonrasiBasamak = 3;
              }
              break;
          }
        }
        break;
      case "HAREM":
        {
          strList = ["Genel", "Döviz", "Parite", "Sarrafiye"];
          switch (selectIndex) {
            case 0:
              {
                data = context.read<PricesCubit>().state.nowState.mineData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationMineDisp;
                virgulSonrasiBasamak = 2;
              }
              break;
            case 1:
              {
                data = context.read<PricesCubit>().state.nowState.currData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationCurrencyDisp;
                virgulSonrasiBasamak = 3;
              }
              break;
            case 2:
              {
                data = context.read<PricesCubit>().state.nowState.pariteData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationCurrencyDisp;
                virgulSonrasiBasamak = 3;
              }
              break;

            case 3:
              {
                data = context.read<PricesCubit>().state.nowState.sarrData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationSarrDisp;
                virgulSonrasiBasamak = 3;
              }
              break;
          }
        }
        break;
      case "SAGLAMOGLU":
        {
          strList = ["Genel", "Döviz", "Parite", "Sarrafiye", "Gram"];
          switch (selectIndex) {
            case 0:
              {
                data = context.read<PricesCubit>().state.nowState.mineData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationMineDisp;
                virgulSonrasiBasamak = 2;
              }
              break;
            case 1:
              {
                data = context.read<PricesCubit>().state.nowState.currData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationCurrencyDisp;
                virgulSonrasiBasamak = 3;
              }
              break;
            case 2:
              {
                data = context.read<PricesCubit>().state.nowState.pariteData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationCurrencyDisp;
                virgulSonrasiBasamak = 3;
              }
              break;
            case 3:
              {
                data = context.read<PricesCubit>().state.nowState.sarrData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationSarrDisp;
                virgulSonrasiBasamak = 3;
              }
              break;
            case 4:
              {
                data = context.read<PricesCubit>().state.nowState.gramData;
                calculationValueIconSetterFunctionSelect =
                    setCalculationGramDisp;
                virgulSonrasiBasamak = 3;
              }
              break;
          }
        }
        break;
    }

    //listelerin içini ilk haline getiriyoruz...
    items = [
      DropdownMenuItem<String>(
        child: Text(
          "-",
          style: TextStyle(
              fontSize: 14, color: themeProjectColors.titleDataTextColor),
        ),
        value: "-",
      )
    ];
    items2 = [
      DropdownMenuItem<String>(
        child: Text(
          "-",
          style: TextStyle(
              fontSize: 14, color: themeProjectColors.titleDataTextColor),
        ),
        value: "-",
      )
    ];
    itemsControl = ["-"];
    items2Control = ["-"];
    //-----------------------------------

    for (int i = 0; i < data.length; i++) {
      var temp = calculationValueIconSetterFunctionSelect(data[i]["symbol"]);

      //eğer birim önceden eklenmiş ise birdaha ekleme
      String cur1 = temp["cur1"];

      if (!itemsControl.contains(cur1)) {
        itemsControl.add(cur1);
        items.add(DropdownMenuItem<String>(
          child: Row(
            children: [
              SizedBox(
                child: Image.asset(temp["icon1"]),
                width: 14,
                height: 14,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                //cur2 si boş olan birimin arayüzdeki "*" işareti kaldırılıyor.
                cur1.replaceAll("*", ""),
                style: TextStyle(
                    fontSize: 14, color: themeProjectColors.titleDataTextColor),
              ),
            ],
          ),
          value: cur1,
        ));
      }

      //eğer birim önceden eklenmiş ise birdaha ekleme
      if (!items2Control.contains(temp["cur2"] == "" ? "TRY" : temp["cur2"]) &&
          selectedItem == cur1) {
        items2Control.add(temp["cur2"] == "" ? "TRY" : temp["cur2"]);
        items2.add(DropdownMenuItem<String>(
          child: Row(
            children: [
              SizedBox(
                child: Image.asset(temp["icon2"] == ""
                    ? "assets/images/currency_and_mine_icons/TRY.png"
                    : temp["icon2"]),
                width: 14,
                height: 14,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                temp["cur2"] == "" ? "TRY" : temp["cur2"],
                style: TextStyle(
                    fontSize: 14, color: themeProjectColors.titleDataTextColor),
              )
            ],
          ),
          value: temp["cur2"] == "" ? "TRY" : temp["cur2"],
        ));
      }
    }
    //selectedItem2 selectedItem a göre oluşan items2Control listesinde varsa devam etsin yoksa selectedItem2 yi varsayılan değere döndürsün.
    if (!items2Control.contains(selectedItem2)) {
      selectedItem2 = "-";
    }

    //sunucudan gelen data symbolleri arayüze çeklirken revize ediliyor bu yüzden değişen symbolleri dataya erişmek için referans olarak kullanamıyoruz.
    //burada değişmiş symboller ile datayı  tektar oluşturuyoruz
    var newdata = [];
    for (int i = 0; i < data.length; i++) {
      newdata.add({
        "symbol": calculationValueIconSetterFunctionSelect(
                data[i]["symbol"])["cur1"] +
            calculationValueIconSetterFunctionSelect(data[i]["symbol"])["cur2"],
        "buy": data[i]["buy"],
        "sell": data[i]["sell"],
      });
    }

    data = newdata;
  }

  @override
  Widget build(BuildContext context) {
    themeProjectColors = Theme.of(context).extension<ProjectColors>()!;
    return Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 2,
          color: themeProjectColors.sectionBackgroundColor,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: BlocBuilder<PricesCubit, PricesState>(
              builder: (context, state) {
                if (state.nowState.isEmpty == true) {
                  return Center(
                      child: Stack(children: [
                    CircularProgressIndicator(
                      color: Color(0xFFE7A707),
                    )
                  ]));
                } else {
                  changeData();
                  return Column(
                    children: [
                      Container(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Align(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 12),
                                child: Text(
                                  "KATEGORİ SEÇİN",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: themeProjectColors.titleTextColor),
                                ),
                              ),
                              alignment: AlignmentDirectional.topStart,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<int>(
                                value: selectIndex,
                                items: strList
                                    .map((value) => DropdownMenuItem<int>(
                                        value: strList.indexOf(value),
                                        child: Text(value,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: themeProjectColors
                                                    .titleDataTextColor))))
                                    .toList(),
                                onChanged: (value) => setState(() {
                                  selectIndex = value!;
                                  selectedItem = "-";
                                  selectedItem2 = "-";
                                  textFieldValue = "1";
                                  changeData();
                                }),
                                dropdownMaxHeight: 400,
                                isExpanded: true,
                                focusColor: Colors.transparent,
                                icon: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 9, right: 16),
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                ),
                                buttonPadding:
                                    EdgeInsets.only(left: 16, top: 15),
                                buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14)),
                                dropdownElevation: 1,
                                offset: Offset(0, -4),
                                dropdownDecoration: BoxDecoration(
                                  color:
                                      themeProjectColors.buySellContainerColor,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            )
                          ],
                        ),
                        height: 56,
                        decoration: BoxDecoration(
                          color: themeProjectColors.buySellContainerColor,
                          border: Border.all(
                              color: themeProjectColors.borderColor as Color),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Container(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Align(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 12),
                                child: Text(
                                  "${strList[selectIndex].toUpperCase()} SEÇİN",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: themeProjectColors.titleTextColor),
                                ),
                              ),
                              alignment: AlignmentDirectional.topStart,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                value: selectedItem,
                                items: items,
                                onChanged: (value) => setState(() {
                                  selectedItem = value!;
                                }),
                                dropdownMaxHeight: 400,
                                isExpanded: true,
                                focusColor: Colors.transparent,
                                icon: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 9, right: 16),
                                    child: Icon(Icons.keyboard_arrow_down),
                                  ),
                                ),
                                buttonPadding:
                                    EdgeInsets.only(left: 16, top: 15),
                                buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14)),
                                dropdownElevation: 1,
                                offset: Offset(0, -4),
                                dropdownDecoration: BoxDecoration(
                                  color:
                                      themeProjectColors.buySellContainerColor,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            )
                          ],
                        ),
                        height: 56,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: themeProjectColors.borderColor as Color),
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Align(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, top: 12),
                                        child: Text(
                                          "MİKTAR GİRİN",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: themeProjectColors
                                                  .titleTextColor),
                                        ),
                                      ),
                                      alignment: AlignmentDirectional.topStart,
                                    ),
                                    Align(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, top: 29),
                                        child: TextField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'(^\d*\.?\d*)'))
                                          ],
                                          controller: TextEditingController
                                              .fromValue(TextEditingValue(
                                                  text:
                                                      textFieldValue.toString(),
                                                  selection:
                                                      TextSelection.collapsed(
                                                          offset: textFieldValue
                                                              .toString()
                                                              .length))),
                                          cursorColor: Color(0xFFE7A707),
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: themeProjectColors
                                                  .titleDataTextColor),
                                          decoration:
                                              new InputDecoration.collapsed(
                                            hintText: "",
                                          ),
                                          onChanged: (value) {
                                            if (value == ".") {
                                              value = "";
                                            }
                                            value = value.replaceAll(",", ".");
                                            textFieldValue = value;
                                            setState(() {});
                                          },
                                          onSubmitted: (value) {
                                            if (value == ".") {
                                              value = "";
                                            }
                                            textFieldValue = value;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      alignment: AlignmentDirectional.topStart,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            height: 56,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      themeProjectColors.borderColor as Color),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                          )),
                          SizedBox(
                            width: 9,
                          ),
                          Expanded(
                              child: Container(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Align(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, top: 12),
                                    child: Text(
                                      "PARİTE SEÇİN",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: themeProjectColors
                                              .titleTextColor),
                                    ),
                                  ),
                                  alignment: AlignmentDirectional.topStart,
                                ),
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    value: selectedItem2,
                                    items: items2,
                                    onChanged: (value) => setState(() {
                                      selectedItem2 = value!;
                                    }),
                                    isExpanded: true,
                                    focusColor: Colors.transparent,
                                    icon: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 9, right: 16),
                                        child: Icon(Icons.keyboard_arrow_down),
                                      ),
                                    ),
                                    buttonPadding:
                                        EdgeInsets.only(left: 16, top: 15),
                                    buttonDecoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    dropdownElevation: 1,
                                    offset: Offset(0, -4),
                                    dropdownDecoration: BoxDecoration(
                                      color: themeProjectColors
                                          .buySellContainerColor,
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            height: 56,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      themeProjectColors.borderColor as Color),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Align(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, top: 12),
                                        child: Text(
                                          "ALIŞ",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: themeProjectColors
                                                  .titleTextColor),
                                        ),
                                      ),
                                      alignment: AlignmentDirectional.topStart,
                                    ),
                                    Align(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, top: 26.5),
                                        child: Text(
                                          ((getSymbolFind(
                                                      selectedItem,
                                                      selectedItem2,
                                                      data)["buy"]) *
                                                  double.parse(
                                                      textFieldValue == ""
                                                          ? "0"
                                                          : textFieldValue))
                                              .toStringAsFixed(
                                                  virgulSonrasiBasamak),
                                          style: TextStyle(
                                              color: themeProjectColors
                                                  .titleDataTextColor),
                                        ),
                                      ),
                                      alignment: AlignmentDirectional.topStart,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            height: 56,
                            decoration: BoxDecoration(
                              color: themeProjectColors.buySellContainerColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                          )),
                          SizedBox(
                            width: 9,
                          ),
                          Expanded(
                              child: Container(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Align(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, top: 12),
                                        child: Text(
                                          "SATIŞ",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: themeProjectColors
                                                  .titleTextColor),
                                        ),
                                      ),
                                      alignment: AlignmentDirectional.topStart,
                                    ),
                                    Align(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 6, top: 26.5),
                                        child: Text(
                                          ((getSymbolFind(
                                                      selectedItem,
                                                      selectedItem2,
                                                      data)["sell"]) *
                                                  double.parse(
                                                      textFieldValue == ""
                                                          ? "0"
                                                          : textFieldValue))
                                              .toStringAsFixed(
                                                  virgulSonrasiBasamak),
                                          style: TextStyle(
                                              color: themeProjectColors
                                                  .titleDataTextColor),
                                        ),
                                      ),
                                      alignment: AlignmentDirectional.topStart,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            height: 56,
                            decoration: BoxDecoration(
                              color: themeProjectColors.buySellContainerColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                          ))
                        ],
                      )
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }
}
