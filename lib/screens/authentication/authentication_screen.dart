import 'package:flutter/material.dart';
import 'package:password_wallet/constants/controllers.dart';
import 'package:password_wallet/widgets/button.dart';
import 'package:password_wallet/widgets/custom_text.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  void initState() {
    authController.authenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.close,
              size: 70,
              color: Colors.blue,
            ),
            const CustomText(
              text: "Authentication Failed!",
              size: 30,
            ),
            CustomButton(
                text: "Try Again", onTap: () => authController.authenticate())
          ],
        ),
      ),
    );
  }
}
