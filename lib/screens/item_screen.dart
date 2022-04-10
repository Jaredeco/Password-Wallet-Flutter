import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:password_wallet/constants/controllers.dart';
import 'package:password_wallet/controllers/password_controller.dart';
import 'package:password_wallet/models/wallet_item.dart';
import 'package:password_wallet/widgets/button.dart';
import 'package:password_wallet/widgets/custom_text.dart';
import 'package:password_wallet/widgets/password_strength.dart';
import 'package:password_wallet/widgets/text_field.dart';

class WalletItemScreen extends StatefulWidget {
  final int walletItemIdx;
  const WalletItemScreen({Key? key, required this.walletItemIdx})
      : super(key: key);

  @override
  State<WalletItemScreen> createState() => _WalletItemScreenState();
}

class _WalletItemScreenState extends State<WalletItemScreen> {
  bool? isObscure = true;
  final txtController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    WalletItem walletItem =
        passwordController.walletItems[widget.walletItemIdx];
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: walletItem.password));
            Get.snackbar("Copied!",
                "Your password has been copied to system's clipboard.");
          },
          child: const Icon(Icons.copy),
        ),
      ),
      body: ListView(children: [
        SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
                  onPressed: () => Get.back()),
              const CustomText(
                text: "Details",
                size: 40,
                color: Colors.blue,
              ),
            ],
          ),
        )),
        dataSection("Title", walletItem.name!, 0),
        dataSection("User Name", walletItem.userName!, 1),
        dataSection("Password", walletItem.password!, 2, isPassword: true),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: CustomText(
            text: "Strength",
            color: Colors.blue,
            weight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: PasswordStrength(password: walletItem.password!),
        ),
      ]),
    );
  }

  Widget dataSection(String title, String data, int idx, {bool? isPassword}) {
    WalletItem walletItem =
        passwordController.walletItems[widget.walletItemIdx];
    return ListTile(
        leading: isPassword != null
            ? IconButton(
                icon: Icon(isObscure! ? Icons.visibility : Icons.visibility_off,
                    color: Colors.blue),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure!;
                  });
                },
              )
            : null,
        title: CustomText(
          text: title,
          size: 22,
          color: Colors.blue,
        ),
        subtitle: CustomText(
          text: isObscure == true && isPassword == true
              ? data.replaceAll(RegExp(r"."), "*")
              : data,
        ),
        trailing: Wrap(
          children: [
            if (idx != 0)
              IconButton(
                  onPressed: () {
                    idx == 1
                        ? Clipboard.setData(
                            ClipboardData(text: walletItem.userName))
                        : Clipboard.setData(
                            ClipboardData(text: walletItem.password));
                    Get.snackbar("Copied!",
                        "Data has been copied to system's clipboard.");
                  },
                  icon: const Icon(Icons.copy)),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                txtController.text = data;
                if (isPassword == true) {
                  passwordController.passwordChecking(walletItem.password!);
                }
                Get.bottomSheet(Container(
                    color: Colors.white,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Center(
                              child: CustomText(
                                  text: "Edit $title",
                                  size: 40,
                                  color: Colors.blue),
                            ),
                          ),
                          CustomTextField(
                            txtController: txtController,
                            txtIcon: Icons.edit,
                            isObscure: isPassword,
                            txtText: title,
                            validate: (text) {
                              if (text == null || text.isEmpty) {
                                return 'This field can not be empty!';
                              }
                              return null;
                            },
                            onChanged: isPassword == true
                                ? (text) {
                                    passwordController.passwordChecking(text);
                                  }
                                : null,
                          ),
                          if (isPassword == true)
                            const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: CustomText(
                                text: "Strength",
                                color: Colors.blue,
                                weight: FontWeight.bold,
                              ),
                            ),
                          if (isPassword == true)
                            GetX<PasswordController>(builder: (controller) {
                              return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: PasswordStrength(
                                    password:
                                        controller.passwordStrengthQuery.value),
                              );
                            }),
                          CustomButton(
                              text: "Update",
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  WalletItem newWalletItem;
                                  if (idx == 0) {
                                    newWalletItem = WalletItem(
                                        name: txtController.text,
                                        userName: walletItem.userName,
                                        password: walletItem.password);
                                  } else if (idx == 1) {
                                    newWalletItem = WalletItem(
                                        name: walletItem.name,
                                        userName: txtController.text,
                                        password: walletItem.password);
                                  } else {
                                    newWalletItem = WalletItem(
                                        name: walletItem.name,
                                        userName: walletItem.userName,
                                        password: txtController.text);
                                  }
                                  Hive.box('walletItems').putAt(
                                      widget.walletItemIdx, newWalletItem);
                                  setState(() {});
                                  Get.back();
                                }
                              })
                        ],
                      ),
                    )));
              },
            ),
          ],
        ));
  }
}
