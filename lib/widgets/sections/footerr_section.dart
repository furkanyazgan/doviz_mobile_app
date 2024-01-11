import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ornek_deneme_calisma/widgets/customcirclebutton.dart';

import '../../constants/projectcolors.dart';
import '../../cubit/prices_cubit.dart';
import '../map_box.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class FooterrSection extends StatelessWidget {
  FooterrSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProjectColors = Theme.of(context).extension<ProjectColors>()!;
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 2,
          color: themeProjectColors.sectionBackgroundColor,
          child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    themeProjectColors.ozakLogoPath as String,
                    width: 154,
                    height: 64,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: themeProjectColors.borderCircleColor
                                    as Color)),
                        child: Center(
                          child: Image.asset(
                            "assets/images/map.png",
                            width: 24,
                            height: 24,
                            color: themeProjectColors.iconColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            "Tayahatun Mah. Acı Çeşme",
                            style: TextStyle(
                                fontSize: 16,
                                color: themeProjectColors.titleDataTextColor),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Sok.No:7-11 İç Kapı No:5 Fatih",
                            style: TextStyle(
                                fontSize: 16,
                                color: themeProjectColors.titleDataTextColor),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "İSTANBUL",
                            style: TextStyle(
                                fontSize: 16,
                                color: themeProjectColors.titleDataTextColor),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: themeProjectColors.borderCircleColor
                                    as Color)),
                        child: Center(
                          child: Image.asset(
                            "assets/images/sms.png",
                            width: 24,
                            height: 24,
                            color: themeProjectColors.iconColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "info@ozakkiymetlimadenler.com",
                        style: TextStyle(
                            fontSize: 16,
                            color: themeProjectColors.titleDataTextColor),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: themeProjectColors.borderCircleColor
                                    as Color)),
                        child: Center(
                          child: Image.asset(
                            "assets/images/call.png",
                            width: 24,
                            height: 24,
                            color: themeProjectColors.iconColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      InkWell(
                        onTap: () async {
                          final Uri launchUri =
                              Uri(scheme: "tel", path: "02125131399");
                          if (await canLaunch(launchUri.toString())) {
                            await launch(launchUri.toString());
                          } else {
                            print("Arama desteklenmiyor!");
                          }
                        },
                        child: Text(
                          "0 212 513 1399",
                          style: TextStyle(
                              fontSize: 16,
                              color: themeProjectColors.titleDataTextColor),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCircleButton(
                          imagePath: "assets/images/facebook.png",
                          onTap: () {}),
                      CustomCircleButton(
                          imagePath: "assets/images/twitter.png", onTap: () {}),
                      CustomCircleButton(
                          imagePath: "assets/images/youtube.png", onTap: () {}),
                      CustomCircleButton(
                          imagePath: "assets/images/instagram.png",
                          onTap: () {}),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(16),
                    elevation: 2,
                    color: themeProjectColors.tabBarColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: SizedBox(
                        height: 148,
                        child: MapBox(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Bilgi Toplumu Hizmetleri",
                    style: TextStyle(color: Color(0xFFE7A707)),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text("© Copyright 2022",
                      style: TextStyle(
                          fontSize: 16,
                          color: themeProjectColors.titleDataTextColor)),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async{
                      await launch("http://www.ozakkiymetlimadenler.com");
                    },
                    child: Text("ozakkiymetlimadenler.com",
                        style: TextStyle(
                            fontSize: 16,
                            color: themeProjectColors.titleDataTextColor)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("All Rights Reserved",
                      style: TextStyle(
                          fontSize: 16,
                          color: themeProjectColors.titleDataTextColor))
                ],
              )),
        ));
  }
}
