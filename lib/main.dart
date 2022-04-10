import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:password_wallet/controllers/auth_controller.dart';
import 'package:password_wallet/controllers/password_controller.dart';
import 'package:password_wallet/models/wallet_item.dart';
import 'package:password_wallet/screens/authentication/authentication_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.registerAdapter(WalletItemAdapter());
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();

  var containsEncryptionKey = await secureStorage.containsKey(key: 'key');

  if (!containsEncryptionKey) {
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'key', value: base64UrlEncode(key));
  }

  var encryptionKey = base64Url.decode((await secureStorage.read(key: 'key'))!);
  await Hive.openBox('walletItems',
      encryptionCipher: HiveAesCipher(encryptionKey));
  Get.put(AuthController());
  Get.put(PasswordController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Wallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto_Mono'
      ),
      home: const AuthenticationScreen(),
    );
  }
}
