import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  CustomText({
    super.key,
    required this.text,
    required this.fontFamily,
    required this.fontSize,
    required this.fontWeight,
    this.color,
    this.maxLine,
  });

  final String text;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final int? maxLine;

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
      maxLines: maxLine,
      textScaler: const TextScaler.linear(1),
    );
  }
}
