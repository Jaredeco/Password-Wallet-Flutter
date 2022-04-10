import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? textAlign;

  const CustomText({
    Key? key,
    this.text,
    this.size,
    this.color,
    this.weight,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontSize: size ?? 17,
          color: color ?? Colors.grey[600],
          fontWeight: weight ?? FontWeight.normal),
      textAlign: textAlign,
    );
  }
}
