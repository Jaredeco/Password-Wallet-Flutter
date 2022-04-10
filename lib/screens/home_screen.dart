import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_wallet/controllers/password_controller.dart';
import 'package:password_wallet/screens/create_item.dart';
import 'package:password_wallet/widgets/custom_text.dart';
import 'package:password_wallet/widgets/wallet_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          onPressed: () => Get.to(() => const CreateItemScreen()),
          child: const Icon(Icons.add),
        ),
      ),
      body: GetX<PasswordController>(builder: (PasswordController controller) {
        return controller.walletItems.isNotEmpty
            ? ListView.builder(
                itemCount: controller.walletItems.length,
                itemBuilder: (context, index) {
                  animationController!.forward();
                  return WalletItemCard(
                    walletItemIdx: index,
                    animationController: animationController,
                    animation: Tween<double>(begin: 0.0, end: 1.0).animate(
                        CurvedAnimation(
                            parent: animationController!,
                            curve: Interval(
                                (1 / controller.walletItems.length) * index,
                                1.0,
                                curve: Curves.fastOutSlowIn))),
                  );
                })
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add,
                      size: 70,
                      color: Colors.blue,
                    ),
                    CustomText(
                      text: "Store your credentials.",
                      size: 30,
                    ),
                    CustomText(
                      color: Colors.blue,
                      text: "It's safe!",
                      size: 30,
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
