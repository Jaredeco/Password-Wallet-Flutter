import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController txtController;
  final IconData txtIcon;
  final String txtText;
  final bool? isObscure;
  final String? Function(String?)? validate;

  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.txtController,
    required this.txtIcon,
    required this.txtText,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(0, 8),
              blurRadius: 8,
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: TextFormField(
            obscureText: _passwordVisible ?? false,
            controller: widget.txtController,
            validator: widget.validate,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              icon: Icon(widget.txtIcon, color: Colors.blue),
              suffix: widget.isObscure != null
                  ? InkWell(
                      child: Icon(
                        _passwordVisible!
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.blue,
                      ),
                      onTap: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible!;
                        });
                      },
                    )
                  : null,
              fillColor: Colors.white,
              border: InputBorder.none,
              hintText: widget.txtText,
            ),
          ),
        ),
      ),
    );
  }
}
