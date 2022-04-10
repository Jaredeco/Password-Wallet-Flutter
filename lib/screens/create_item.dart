import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_wallet/constants/controllers.dart';
import 'package:password_wallet/controllers/password_controller.dart';
import 'package:password_wallet/screens/home_screen.dart';
import 'package:password_wallet/widgets/button.dart';
import 'package:password_wallet/widgets/custom_text.dart';
import 'package:password_wallet/widgets/password_strength.dart';
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

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      passwordController.passwordChecking("");
    });
    super.initState();
  }

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
                    color: Colors.blue,
                  ),
                ],
              ),
            )),
            CustomTextField(
              txtController: nameTextController,
              txtIcon: Icons.title,
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
              txtIcon: Icons.lock,
              txtText: "Password",
              onChanged: (text) {
                passwordController.passwordChecking(text);
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
              child: CustomText(
                text: "Strength",
                color: Colors.blue,
                weight: FontWeight.bold,
              ),
            ),
            GetX<PasswordController>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: PasswordStrength(
                    password: controller.passwordStrengthQuery.value),
              );
            }),
            CustomButton(
                text: "Store",
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
