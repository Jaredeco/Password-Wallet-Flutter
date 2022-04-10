import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:password_wallet/screens/authentication/authentication_screen.dart';
import 'package:password_wallet/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  RxBool authenticated = false.obs;
  var localAuth = LocalAuthentication();

  @override
  void onReady() {
    super.onReady();
    authenticated.listen((isAuthenticated) {
      if (isAuthenticated) {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => const AuthenticationScreen());
      }
    });
  }

  authenticate() async {
    try {
      authenticated.value = await localAuth.authenticate(
          localizedReason: 'Please authenticate to show account balance');
      update();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
