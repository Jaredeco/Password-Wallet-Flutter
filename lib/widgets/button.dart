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
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.black,
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: CustomText(
                text: text!,
                color: txtColor ?? Colors.white,
                size: txtSize ?? 20,
                weight: FontWeight.normal,
              ),
            )),
      ),
    );
  }
}
