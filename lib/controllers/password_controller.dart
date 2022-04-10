import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:password_wallet/models/wallet_item.dart';

class PasswordController extends GetxController {
  static PasswordController instance = Get.find();
  var products = <WalletItem>[].obs;
  Box walletBox = Hive.box('walletItems');

  @override
  void onInit() async{
    super.onInit();
    // products.bindStream(loadItems());
  }

  storeItem(String name, String userName, String password) {
    WalletItem createWalletItem =
        WalletItem(name: name, userName: userName, password: password);
    walletBox.add(createWalletItem);
  }

  loadItems() {
    return walletBox.values.toList().cast<WalletItem>();
  }
}
