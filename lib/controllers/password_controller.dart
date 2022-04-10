import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:password_wallet/models/wallet_item.dart';

class PasswordController extends GetxController {
  static PasswordController instance = Get.find();
  var walletItems = <WalletItem>[].obs;
  Box walletBox = Hive.box('walletItems');

  @override
  void onInit() async {
    super.onInit();
    loadItems();
    walletItems.bindStream(fetchItems());
  }

  storeItem(String name, String userName, String password) {
    WalletItem createWalletItem =
        WalletItem(name: name, userName: userName, password: password);
    walletBox.add(createWalletItem);
  }

  Stream<List<WalletItem>> fetchItems() {
    return walletBox
        .watch()
        .map((event) => walletBox.values.toList().cast<WalletItem>());
  }

  loadItems() {
    walletItems.value = walletBox.values.toList().cast<WalletItem>();
    update();
  }
}
