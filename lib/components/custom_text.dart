import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  CustomText({
    super.key,
    required this.text,
    required this.fontFamily,
    required this.fontSize,
    required this.fontWeight,
    this.color,
  });

  final String text;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? const Color.fromARGB(255, 46, 46, 46),
        height: 1.7,
      ),
      textScaler: const TextScaler.linear(1),
    );
  }
}
