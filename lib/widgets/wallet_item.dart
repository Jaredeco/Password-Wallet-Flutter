import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:password_wallet/models/wallet_item.dart';
import 'package:password_wallet/screens/item_screen.dart';
import 'package:password_wallet/widgets/custom_text.dart';

class WalletItemCard extends StatefulWidget {
  final WalletItem? walletItem;
  final AnimationController? animationController;
  final Animation<double>? animation;
  const WalletItemCard(
      {Key? key, this.walletItem, this.animationController, this.animation})
      : super(key: key);

  @override
  State<WalletItemCard> createState() => _WalletItemCardState();
}

class _WalletItemCardState extends State<WalletItemCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.animationController!,
        builder: (BuildContext context, Widget? child) {
          return FadeTransition(
              opacity: widget.animation!,
              child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.animation!.value), 0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: const Offset(0, 8),
                              blurRadius: 8,
                            ),
                          ],
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                        ),
                        child: ListTile(
                            onTap: () => Get.to(() => WalletItemScreen(
                                walletItem: widget.walletItem)),
                            leading: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.lock, size: 24),
                                VerticalDivider(
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            title: CustomText(
                              text: widget.walletItem!.name,
                            ),
                            subtitle:
                                CustomText(text: widget.walletItem!.userName),
                            trailing: IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: widget.walletItem!.password));
                                Get.snackbar("Copied!",
                                    "Your password has been copied to system's clipboard.");
                              },
                            ))),
                  )));
        });
  }
}
