import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  double height;

  SmallText({Key? key, required this.text, this.color =const Color(0xFFccc7c5),
    this.height=1.2, this.size=12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontFamily: "Roboto",
        color: color,
        height: height
      ),
    );
  }
}
