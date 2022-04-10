import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:password_wallet/constants/controllers.dart';
import 'package:password_wallet/models/wallet_item.dart';
import 'package:password_wallet/screens/item_screen.dart';
import 'package:password_wallet/widgets/custom_text.dart';

class WalletItemCard extends StatefulWidget {
  final int? walletItemIdx;
  final AnimationController? animationController;
  final Animation<double>? animation;
  const WalletItemCard(
      {Key? key, this.walletItemIdx, this.animationController, this.animation})
      : super(key: key);

  @override
  State<WalletItemCard> createState() => _WalletItemCardState();
}

class _WalletItemCardState extends State<WalletItemCard> {
  @override
  Widget build(BuildContext context) {
    WalletItem walletItem =
        passwordController.walletItems[widget.walletItemIdx!];
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
                    child: Slidable(
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                Box walletBox = Hive.box('walletItems');
                                walletBox.deleteAt(widget.walletItemIdx!);
                                walletBox.compact();
                                Get.snackbar("Item Deleted",
                                    "The Item has been deleted!");
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
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
                                    walletItemIdx: widget.walletItemIdx)),
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
                                  text: walletItem.name,
                                ),
                                subtitle: CustomText(text: walletItem.userName),
                                trailing: IconButton(
                                  icon: const Icon(Icons.copy),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: walletItem.password));
                                    Get.snackbar("Copied!",
                                        "Your password has been copied to system's clipboard.");
                                  },
                                )),
                          ),
                        )),
                  )));
        });
  }
}
