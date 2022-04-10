import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final Color? txtColor;
  final double? txtSize;
  final Color? bgColor;
  final Color? shadowColor;
  final VoidCallback? onTap;

  const CustomButton(
      {Key? key,
      required this.text,
      this.txtColor,
      this.txtSize,
      this.bgColor,
      this.shadowColor,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        onTap: onTap,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            margin: const EdgeInsets.all(15),
            alignment: Alignment.center,
            child: CustomText(
              text: text!,
              color: txtColor ?? Colors.white,
              size: txtSize ?? 25,
              weight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
