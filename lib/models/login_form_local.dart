import 'package:hive/hive.dart';

part 'login_form_local.g.dart';

@HiveType(typeId: 4)
class LoginFormLocal {
  @HiveField(0)
  String username;

  @HiveField(1)
  String? password;

  LoginFormLocal({
    required this.username,
    required this.password,
  });
}
