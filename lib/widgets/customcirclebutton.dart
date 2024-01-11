import 'package:flutter/material.dart';

class CustomCircleButton extends StatefulWidget {
  CustomCircleButton({Key? key, required this.imagePath, required this.onTap})
      : super(key: key);
  String imagePath;
  Function onTap;

  @override
  _CustomCircleButtonState createState() => _CustomCircleButtonState();
}

class _CustomCircleButtonState extends State<CustomCircleButton> {
  Color nowColor = Color(0xFFE7A707);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: Color(0x25E7A707))),
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: () {
          widget.onTap();

        },
        onTapDown: (a) {

          nowColor = Colors.white;
          setState(() {});
        },
        onTapUp: (a) {

          nowColor = Color(0xFFE7A707);
          setState(() {});
        },
        onTapCancel: (){
          nowColor = Color(0xFFE7A707);
          setState(() {});
        },
        splashColor: Colors.transparent,
        highlightColor: Color(0xFFE7A707),
        child: Center(
          child: Image.asset(
            widget.imagePath as String,
            color: nowColor,
            width: 20,
            height: 20,
          ),
        ),
      ),
    );
  }
}
