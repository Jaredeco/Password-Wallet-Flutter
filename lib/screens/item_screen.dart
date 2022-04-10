import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:password_wallet/constants/controllers.dart';
import 'package:password_wallet/models/wallet_item.dart';
import 'package:password_wallet/widgets/button.dart';
import 'package:password_wallet/widgets/custom_text.dart';
import 'package:password_wallet/widgets/text_field.dart';

class WalletItemScreen extends StatefulWidget {
  final int? walletItemIdx;
  const WalletItemScreen({Key? key, this.walletItemIdx}) : super(key: key);

  @override
  State<WalletItemScreen> createState() => _WalletItemScreenState();
}

class _WalletItemScreenState extends State<WalletItemScreen> {
  bool? isObscure = true;
  final txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WalletItem walletItem =
        passwordController.walletItems[widget.walletItemIdx!];
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
        const SafeArea(
            child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomText(
            text: "Details",
            size: 30,
            weight: FontWeight.bold,
          ),
        )),
        dataSection("Title", walletItem.name!, 0),
        dataSection("User Name", walletItem.userName!, 1),
        dataSection("Password", walletItem.password!, 2, isPassword: true)
      ]),
    );
  }

  Widget dataSection(String title, String data, int idx, {bool? isPassword}) {
    WalletItem walletItem =
        passwordController.walletItems[widget.walletItemIdx!];
    return ListTile(
        leading: isPassword != null
            ? IconButton(
                icon:
                    Icon(isObscure! ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure!;
                  });
                },
              )
            : null,
        title: CustomText(
          text: title,
        ),
        subtitle: CustomText(
          text: isObscure == true && isPassword == true
              ? data.replaceAll(RegExp(r"."), "*")
              : data,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            txtController.text = data;
            Get.bottomSheet(Container(
                color: Colors.white,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: "Edit $title",
                        size: 30,
                        weight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(
                        txtController: txtController,
                        txtIcon: Icons.edit,
                        isObscure: isPassword,
                        txtText: title),
                    CustomButton(
                        text: "Update",
                        onTap: () {
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
                          Hive.box('walletItems')
                              .putAt(widget.walletItemIdx!, newWalletItem);
                          setState(() {});
                        })
                  ],
                )));
          },
        ));
  }
}
