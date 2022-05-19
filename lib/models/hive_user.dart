import 'package:hive/hive.dart';

part 'hive_user.g.dart';

@HiveType(typeId: 1)
class HiveUser {
  HiveUser(
      {required this.username, required this.password, required this.isAdmin});

  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  bool isAdmin;
}
