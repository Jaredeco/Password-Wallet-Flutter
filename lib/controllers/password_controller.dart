import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:password_wallet/models/wallet_item.dart';

class PasswordController extends GetxController {
  static PasswordController instance = Get.find();
  var walletItems = <WalletItem>[].obs;
  Box walletBox = Hive.box('walletItems');
  var passwordStrengthQuery = "".obs;

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

  passwordChecking(String password) {
    passwordStrengthQuery.value = password;
    update();
  }

  checkPasswordStrength(String value) {
    double _strength = 0;
    RegExp _numIn = RegExp(r".*[0-9].*");
    RegExp _lettersIn = RegExp(r".*[A-Za-z].*");
    RegExp _alphaNumeric = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
    String _password = value.trim();

    if (_password.isEmpty) {
      _strength = 0;
    } else if (_password.length < 6) {
      _strength = 1 / 4;
    } else if (_password.length < 8) {
      _strength = 2 / 4;
    } else {
      if (!_lettersIn.hasMatch(_password) ||
          !_numIn.hasMatch(_password) ||
          _alphaNumeric.hasMatch(_password)) {
        _strength = 3 / 4;
      } else {
        _strength = 1;
      }
    }
    return _strength;
  }
}
