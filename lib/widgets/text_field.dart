import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController txtController;
  final IconData txtIcon;
  final String txtText;
  final bool? isObscure;
  final String? Function(String?)? validate;
  final TextInputType? kbdType;
  final double? width;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.txtController,
    required this.txtIcon,
    required this.txtText,
    this.width,
    this.kbdType,
    this.validate,
    this.isObscure,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? _passwordVisible;
  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width * 0.6,
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Material(
        color: Colors.white,
        elevation: 1,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: TextFormField(
            keyboardType: widget.kbdType,
            obscureText: _passwordVisible ?? false,
            controller: widget.txtController,
            validator: widget.validate,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
                icon: Icon(widget.txtIcon, color: Colors.black),
                suffix: widget.isObscure != null
                    ? IconButton(
                        icon: Icon(
                          _passwordVisible!
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () { 
                          setState(() {
                            _passwordVisible = !_passwordVisible!;
                          });
                        },
                      )
                    : null,
                fillColor: Colors.white,
                border: InputBorder.none,
                hintText: widget.txtText,
                hintStyle: const TextStyle(color: Colors.black)),
          ),
        ),
      ),
    );
  }
}