import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/projectcolors.dart';


class CustomTabBar extends StatefulWidget  {
  CustomTabBar(
      {required this.strList, required this.selectIndex, required this.onTap});

  final Function(int) onTap;
  int selectIndex;
  List<String> strList;

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>  {


  @override

  @override
  Widget build(BuildContext context) {
    final themeProjectColors = Theme.of(context).extension<ProjectColors>()!;
    List<Expanded> listWidget = [];
    for (int i = 0; i < widget.strList.length; i++) {
      listWidget.add(Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.onTap(i);
              widget.selectIndex = i;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
            child: Container(
              child: Center(
                child: Text(widget.strList[i],
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.selectIndex == i
                          ? Color(0xFFFFFFFF)
                          : themeProjectColors.titleTextColor,
                    )),
              ),
              decoration: BoxDecoration(
                color: widget.selectIndex == i
                    ? themeProjectColors.buttonSelectColor
                    : Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
        ),
      ));
    }

    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: listWidget,
          ),
        ),
      ),
      height: 56,
      decoration: BoxDecoration(
        color: themeProjectColors.tabBarColor,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}