import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ornek_deneme_calisma/pages/toptan_page.dart';
import '../constants/projectcolors.dart';
import '../cubit/thememanagement_cubit.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key, required this.scrollDown, required this.scrollUp})
      : super(key: key);
  Function scrollUp;
  Function scrollDown;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(
        const Duration(minutes: 1), (Timer t) => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProjectColors = Theme.of(context).extension<ProjectColors>()!;

    DateTime now = DateTime.now();
    String clock = DateFormat.Hm().format(now);

    String date = now.day.toString() +
        "." +
        now.month.toString() +
        "." +
        now.year.toString();

    return SafeArea(
      child: Drawer(
        width: double.infinity,
        backgroundColor: themeProjectColors.appBarColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: <Widget>[
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Align(
                  child: Image.asset(
                    themeProjectColors.ozakLogoPath as String,
                    width: 100,
                    height: 40,
                    fit: BoxFit.fill,
                  ),
                ),
                Spacer(),
                Align(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: themeProjectColors.borderColor as Color)),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      child: Center(
                        child: Image.asset(
                          themeProjectColors.themeChangeButtonImagePath
                              as String,
                          color: themeProjectColors.iconColor,
                          width: 20,
                          height: 20,
                        ),
                      ),
                      onTap: () {
                        if (context
                                .read<ThemeManagementCubit>()
                                .state
                                .themeMode ==
                            "light") {
                          context.read<ThemeManagementCubit>().setTheme("dark");
                        } else {
                          context
                              .read<ThemeManagementCubit>()
                              .setTheme("light");
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Align(
                  child: Ink.image(
                    image: AssetImage("assets/images/remove.png"),
                    width: 48,
                    height: 48,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              height: 56,
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Color(0x25E7A707),
                  onTap: () {
                    Navigator.pop(context);
                    widget.scrollUp();
                  },
                  borderRadius: BorderRadius.circular(30.0),
                  child: Center(
                    child: Text(
                      "Anasayfa",
                      style: TextStyle(
                        color: themeProjectColors.titleDataTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 56,
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Color(0x25E7A707),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ToptanPage()));
                  },
                  borderRadius: BorderRadius.circular(30.0),
                  child: Center(
                    child: Text(
                      "Toptan",
                      style: TextStyle(
                        color: themeProjectColors.titleDataTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 56,
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Color(0x25E7A707),
                  onTap: () {
                    Navigator.pop(context);
                    widget.scrollUp();
                  },
                  borderRadius: BorderRadius.circular(30.0),
                  child: Center(
                    child: Text(
                      "Perakende",
                      style: TextStyle(
                        color: themeProjectColors.titleDataTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 56,
              child: Material(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Color(0x25E7A707),
                  onTap: () {
                    Navigator.pop(context);
                    widget.scrollDown();
                  },
                  borderRadius: BorderRadius.circular(30.0),
                  child: Center(
                    child: Text(
                      "İletişim",
                      style: TextStyle(
                        color: themeProjectColors.titleDataTextColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_month,
                  color: Color(0xFFE7A707),
                ),
                SizedBox(
                  width: 11,
                ),
                Text(
                  "$date",
                  style: TextStyle(
                      fontSize: 20,
                      color: themeProjectColors.titleDataTextColor),
                ),
                SizedBox(
                  width: 27,
                ),
                Icon(
                  Icons.timer_outlined,
                  color: Color(0xFFE7A707),
                ),
                SizedBox(
                  width: 11,
                ),
                Text(
                  "$clock",
                  style: TextStyle(
                      fontSize: 20,
                      color: themeProjectColors.titleDataTextColor),
                )
              ],
            ),
            SizedBox(
              height: 42,
            )
          ]),
        ),
      ),
    );
  }
}
