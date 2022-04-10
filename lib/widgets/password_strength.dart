import 'package:flutter/material.dart';
import 'package:password_wallet/constants/controllers.dart';

class PasswordStrength extends StatefulWidget {
  final String password;
  const PasswordStrength({Key? key, required this.password}) : super(key: key);

  @override
  State<PasswordStrength> createState() => _PasswordStrengthState();
}

class _PasswordStrengthState extends State<PasswordStrength> {
  @override
  Widget build(BuildContext context) {
    double _strength =
        passwordController.checkPasswordStrength(widget.password);
    return LinearProgressIndicator(
      value: _strength,
      backgroundColor: Colors.grey[300],
      color: _strength <= 1 / 4
          ? Colors.red
          : _strength == 2 / 4
              ? Colors.yellow
              : _strength == 3 / 4
                  ? Colors.blue
                  : Colors.green,
      minHeight: 15,
    );
  }
}
