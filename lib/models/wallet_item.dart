import 'package:hive/hive.dart';
part 'wallet_item.g.dart';

@HiveType(typeId: 0)
class WalletItem {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? userName;
  @HiveField(2)
  final String? password;

  WalletItem({this.name, this.userName, this.password});
}
