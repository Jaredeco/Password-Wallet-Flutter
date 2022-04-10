import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:password_wallet/models/wallet_item.dart';
import 'package:password_wallet/widgets/custom_text.dart';

class WalletItemScreen extends StatefulWidget {
  final WalletItem? walletItem;
  const WalletItemScreen({Key? key, this.walletItem}) : super(key: key);

  @override
  State<WalletItemScreen> createState() => _WalletItemScreenState();
}

class _WalletItemScreenState extends State<WalletItemScreen> {
  bool? isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: widget.walletItem!.password));
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
        dataSection("Title", widget.walletItem!.name!),
        dataSection("User Name", widget.walletItem!.userName!),
        dataSection("Password", widget.walletItem!.password!, isPassword: true)
      ]),
    );
  }

  Widget dataSection(String title, String data, {bool? isPassword}) {
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
          onPressed: () {},
        ));
  }
}
