import 'package:flutter/material.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'package:get/get.dart';
import 'package:password_wallet/constants/controllers.dart';
import 'package:password_wallet/screens/home_screen.dart';
import 'package:password_wallet/widgets/button.dart';
import 'package:password_wallet/widgets/custom_text.dart';
import 'package:password_wallet/widgets/text_field.dart';

class CreateItemScreen extends StatefulWidget {
  const CreateItemScreen({Key? key}) : super(key: key);

  @override
  State<CreateItemScreen> createState() => _CreateItemScreenState();
}

class _CreateItemScreenState extends State<CreateItemScreen> {
  final nameTextController = TextEditingController();
  final userNameTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.blue,
                      ),
                      onPressed: () => Get.back()),
                  const CustomText(
                    text: "Store Credentials",
                    size: 40,
                    weight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ],
              ),
            )),
            CustomTextField(
              txtController: nameTextController,
              txtIcon: Icons.person,
              txtText: "Title",
              validate: (text) {
                if (text == null || text.isEmpty) {
                  return 'This field can not be empty!';
                }
                return null;
              },
            ),
            CustomTextField(
              txtController: userNameTextController,
              txtIcon: Icons.person,
              txtText: "User Name",
              validate: (text) {
                if (text == null || text.isEmpty) {
                  return 'This field can not be empty!';
                }
                return null;
              },
            ),
            CustomTextField(
              isObscure: true,
              txtController: passwordTextController,
              txtIcon: Icons.person,
              txtText: "Password",
              onChanged: (text) {
                setState(() {
                  password = text;
                });
              },
              validate: (text) {
                if (text == null || text.isEmpty) {
                  return 'This field can not be empty!';
                }
                return null;
              },
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: CustomText(text: "Strength", color: Colors.blue, weight: FontWeight.bold,),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FlutterPasswordStrength(password: password),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                text: "Create",
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    passwordController.storeItem(
                        nameTextController.text.trim(),
                        userNameTextController.text.trim(),
                        passwordTextController.text.trim());
                    Get.to(() => const HomeScreen());
                  }
                })
          ],
        ),
      ),
    );
  }
}
