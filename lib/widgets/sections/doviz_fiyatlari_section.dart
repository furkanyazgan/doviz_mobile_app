import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ornek_deneme_calisma/cubit/prices_cubit.dart';
import 'package:ornek_deneme_calisma/widgets/custom_tabbar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:ornek_deneme_calisma/functions/dispNameIconSetter.dart';

import '../../constants/projectcolors.dart';

class DovizFiyatlariSection extends StatefulWidget {
  const DovizFiyatlariSection({Key? key}) : super(key: key);

  @override
  _DovizFiyatlariSectionState createState() => _DovizFiyatlariSectionState();
}

class _DovizFiyatlariSectionState extends State<DovizFiyatlariSection> {
  int selectIndex = 1;
  late List<dynamic> nowData;
  late List<dynamic> oldData;
  late List<String> strList = ["-", "-"];

  // backend verileri hangi siteden çekiyor ?
  late Widget sourceTextWidget;

  //----------------------

  //dispNameIconSetter dosyasından data türene göre seçilen function
  late var dispNameIconSetterFunctionSelect;

  //virgülden sonra kaç basamak gözükecek?
  late int virgulSonrasiBasamak;

  late ProjectColors themeProjectColors;

  @override
  void initState() {
    super.initState();
  }

  void changeData() {

    String temp = context.read<PricesCubit>().state.nowState.data_source;

    //Piyasa verilerinin nerden geldiği dataya göre değişecekse  alttakini açın sabit olanı yoruma satırına alın.
    // String source = temp;
    String source = "SABIT";

    switch (source) {
      case "SABIT":
        {
          sourceTextWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Piyasa verileri",
                    style: TextStyle(color: themeProjectColors.titleTextColor),
                  ),
                  Text(
                    " bilgilendirme ",
                    style: TextStyle(color: themeProjectColors.titleTextColor),
                  ),
                  Text(
                    "amacıyla",
                    style: TextStyle(color: themeProjectColors.titleTextColor),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "verilmektedir.",
                style: TextStyle(color: themeProjectColors.titleTextColor),
              ),
            ],
          );
        }
        break;

      case "FOREX":
        {
          sourceTextWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Piyasa verileri",
                    style: TextStyle(color: themeProjectColors.titleTextColor),
                  ),
                  Text(
                    " Foreks.com ",
                    style: TextStyle(color: Color(0xFFE7A707)),
                  ),
                  Text(
                    "tarafından",
                    style: TextStyle(color: themeProjectColors.titleTextColor),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "sağlanmaktadır.",
                style: TextStyle(color: themeProjectColors.titleTextColor),
              ),
            ],
          );
          ;
        }
        break;
      case "HAREM":
        {
          sourceTextWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Piyasa verileri",
                    style: TextStyle(color: themeProjectColors.titleTextColor),
                  ),
                  Text(
                    " Haremaltin.com ",
                    style: TextStyle(color: Color(0xFFE7A707)),
                  ),
                  Text(
                    "tarafından",
                    style: TextStyle(color: themeProjectColors.titleTextColor),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "sağlanmaktadır.",
                style: TextStyle(color: themeProjectColors.titleTextColor),
              ),
            ],
          );
        }
        break;
      case "SAGLAMOGLU":
        {
          sourceTextWidget = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Piyasa verileri",
                    style: TextStyle(color: themeProjectColors.titleTextColor),
                  ),
                  Text(
                    " Saglamoglualtin.com ",
                    style: TextStyle(color: Color(0xFFE7A707)),
                  ),
                  Text(
                    "tarafından",
                    style: TextStyle(color: themeProjectColors.titleTextColor),
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "sağlanmaktadır.",
                style: TextStyle(color: themeProjectColors.titleTextColor),
              ),
            ],
          );
        }
        break;
    }

    switch (temp) {
      case "FOREX":
        {
          strList = ["Genel", "Döviz"];
        }
        break;
      case "HAREM":
        {
          strList = ["Genel", "Döviz", "Parite"];
        }
        break;
      case "SAGLAMOGLU":
        {
          strList = ["Genel", "Döviz", "Parite"];
        }
        break;
    }

    switch (selectIndex) {
      case 0:
        {
          nowData = context.read<PricesCubit>().state.nowState.mineData;
          oldData = context.read<PricesCubit>().state.oldState.mineData;
          dispNameIconSetterFunctionSelect = setMineDisp;
          virgulSonrasiBasamak = 2;
        }
        break;
      case 1:
        {
          nowData = context.read<PricesCubit>().state.nowState.currData;
          oldData = context.read<PricesCubit>().state.oldState.currData;
          dispNameIconSetterFunctionSelect = setCurrencyDisp;
          virgulSonrasiBasamak = 3;
        }
        break;
      case 2:
        {
          nowData = context.read<PricesCubit>().state.nowState.pariteData;
          oldData = context.read<PricesCubit>().state.oldState.pariteData;
          dispNameIconSetterFunctionSelect = setCurrencyDisp;
          virgulSonrasiBasamak = 3;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    themeProjectColors = Theme.of(context).extension<ProjectColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 2,
          color: themeProjectColors.sectionBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                              child: Image.asset(
                                "assets/images/dovizLogo-dark-theme.png",
                                height: 56,
                                width: 56,
                              )),
                          SizedBox(
                            width: 35,
                          ),
                          Expanded(
                            child: CustomTabBar(
                              strList: strList,
                              selectIndex: selectIndex,
                              onTap: (index) {
                                selectIndex = index;
                                changeData();
                                // context.read<PricesCubit>().emit(state);
                                setState(() {});
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        strList[selectIndex],
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: themeProjectColors.titleDataTextColor),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      sourceTextWidget,
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        child: Center(
                          child: Row(children: [
                            Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Text(
                                    "Sembol",
                                    style: TextStyle(
                                        color:
                                            themeProjectColors.titleTextColor),
                                  ),
                                )),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 17),
                                  child: Align(
                                    child: Text(
                                      "Alış",
                                      style: TextStyle(
                                          color: themeProjectColors
                                              .titleTextColor),
                                    ),
                                    alignment: AlignmentDirectional.centerEnd,
                                  ),
                                )),
                            SizedBox(
                              width: 7.33,
                            ),
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 17),
                                  child: Align(
                                    child: Text(
                                      "Satış",
                                      style: TextStyle(
                                          color: themeProjectColors
                                              .titleTextColor),
                                    ),
                                    alignment: AlignmentDirectional.centerEnd,
                                  ),
                                )),
                            // ÜST BAR ----------------------------------
                            SizedBox(
                              width: 20,
                            )
                          ]),
                        ),
                        height: 56,
                        decoration: BoxDecoration(
                          color: themeProjectColors.containerColor,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: nowData.length,
                              itemBuilder: (context, index) {
                                //dispNameIconSetter dosyasından data türene göre seçilen function
                                Map<String, String> tempData =
                                    dispNameIconSetterFunctionSelect(
                                        nowData[index]["symbol"]);

                                return Column(
                                  children: [
                                    Container(
                                      child: Center(
                                        child: Row(children: [
                                          Expanded(
                                              flex: 6,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: Row(
                                                    children: [
                                                      Stack(
                                                        clipBehavior: Clip.none,
                                                        children: [
                                                          Image.asset(
                                                              tempData["icon1"]
                                                                  .toString()),
                                                          Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                              child: tempData[
                                                                          "icon2"] ==
                                                                      ""
                                                                  ? SizedBox(
                                                                      width: 24,
                                                                    )
                                                                  : Image.asset(
                                                                      tempData[
                                                                              "icon2"]
                                                                          .toString())),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        tempData["cur1"]
                                                                .toString() +
                                                            tempData["cur2"]
                                                                .toString(),
                                                        style: TextStyle(
                                                            color: themeProjectColors
                                                                .titleDataTextColor),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                reverse: true,
                                                child: Align(
                                                  child: getBuyWidget(index),
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerEnd,
                                                ),
                                              )),
                                          SizedBox(
                                            width: 7.33,
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                reverse: true,
                                                child: Align(
                                                  child: getSellWidget(index),
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerEnd,
                                                ),
                                              )),
//ELEMAN BAR -------------------------
                                          SizedBox(
                                            width: 20,
                                          )
                                        ]),
                                      ),
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: index % 2 == 0
                                            ? themeProjectColors.containerColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                  ],
                                );
                              }))
                    ],
                  );
                }
              },
            ),
          )),
    );
  }

  // sell için artış azalış gösterme methodu
  Widget getSellWidget(int index) {
    String tempOldData = "";

    if (oldData.length != 0) {
      //seçilen dataya göre virgülden sonra kaç hane gözükecek
      tempOldData =
          (oldData[index]["sell"]).toStringAsFixed(virgulSonrasiBasamak);
    }

    //seçilen dataya göre virgülden sonra kaç hane gözükecek
    String tempNowData =
        (nowData[index]["sell"]).toStringAsFixed(virgulSonrasiBasamak);

    //virgülden sonra .00 veya .000 varsa tam sayı yapıyor
    if (tempOldData.contains("." + "0" * virgulSonrasiBasamak)) {
      tempOldData =
          tempOldData.replaceAll("." + "0" * virgulSonrasiBasamak, "");
    }
    if (tempNowData.contains("." + "0" * virgulSonrasiBasamak)) {
      tempNowData =
          tempNowData.replaceAll("." + "0" * virgulSonrasiBasamak, "");
    }

    //uygulamanın ilk açılış kontorlü ? olddata boş ise
    if (oldData.length == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            tempNowData,
            style: TextStyle(color: Color(0xFFE7A707)),
          ),
          SizedBox(
            width: 7.33,
          ),

          //kısa çizgi
          SizedBox(
            width: 8,
            child: Divider(
              height: 1.5,
              color: Color(0xFFE7A707),
            ),
          )
        ],
      );
    } else {
      if (double.parse(tempNowData) > double.parse(tempOldData)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              tempNowData,
              style: TextStyle(color: Color(0xFF16C784)),
            ),
            SizedBox(
              width: 7.33,
            ),
            Image.asset(
              "assets/images/up_icon.png",
              width: 8,
              height: 4,
            )
          ],
        );
      } else if (double.parse(tempNowData) < double.parse(tempOldData)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              tempNowData,
              style: TextStyle(color: Color(0xFFEA3943)),
            ),
            SizedBox(
              width: 7.33,
            ),
            Image.asset(
              "assets/images/down_icon.png",
              width: 8,
              height: 4,
            )
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              tempNowData,
              style: TextStyle(color: Color(0xFFE7A707)),
            ),
            SizedBox(
              width: 7.33,
            ),

            //kısa çizgi
            SizedBox(
              width: 8,
              child: Divider(
                height: 1.5,
                color: Color(0xFFE7A707),
              ),
            )
          ],
        );
      }
    }
  }

  // buy için artış azalış gösterme methodu
  Widget getBuyWidget(int index) {
    String tempOldData = "";

    if (oldData.length != 0) {
      //seçilen dataya göre virgülden sonra kaç hane gözükecek
      tempOldData =
          (oldData[index]["buy"]).toStringAsFixed(virgulSonrasiBasamak);
    }

    //seçilen dataya göre virgülden sonra kaç hane gözükecek
    String tempNowData =
        (nowData[index]["buy"]).toStringAsFixed(virgulSonrasiBasamak);

    //virgülden sonra .00 veya .000 varsa tam sayı yapıyor
    if (tempOldData.contains("." + "0" * virgulSonrasiBasamak)) {
      tempOldData =
          tempOldData.replaceAll("." + "0" * virgulSonrasiBasamak, "");
    }
    if (tempNowData.contains("." + "0" * virgulSonrasiBasamak)) {
      tempNowData =
          tempNowData.replaceAll("." + "0" * virgulSonrasiBasamak, "");
    }

    //uygulamanın ilk açılış kontorlü ? olddata boş ise
    if (oldData.length == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            tempNowData,
            style: TextStyle(color: Color(0xFFE7A707)),
          ),
          SizedBox(
            width: 7.33,
          ),

          //kısa çizgi
          SizedBox(
            width: 8,
            child: Divider(
              height: 1.5,
              color: Color(0xFFE7A707),
            ),
          )
        ],
      );
    } else {
      if (double.parse(tempNowData) > double.parse(tempOldData)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              tempNowData,
              style: TextStyle(color: Color(0xFF16C784)),
            ),
            SizedBox(
              width: 7.33,
            ),
            Image.asset(
              "assets/images/up_icon.png",
              width: 8,
              height: 4,
            )
          ],
        );
      } else if (double.parse(tempNowData) < double.parse(tempOldData)) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              tempNowData,
              style: TextStyle(color: Color(0xFFEA3943)),
            ),
            SizedBox(
              width: 7.33,
            ),
            Image.asset(
              "assets/images/down_icon.png",
              width: 8,
              height: 4,
            )
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              tempNowData,
              style: TextStyle(color: Color(0xFFE7A707)),
            ),
            SizedBox(
              width: 7.33,
            ),

            //kısa çizgi
            SizedBox(
              width: 8,
              child: Divider(
                height: 1.5,
                color: Color(0xFFE7A707),
              ),
            )
          ],
        );
      }
    }
  }
}
