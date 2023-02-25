import 'package:hive/hive.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/models/login_local.dart';
import 'package:http/http.dart' as http;

class LoginRepository {

  Future<Box<LoginLocal>> openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(LoginLocalAdapter());
    }
    var box = await Hive.openBox<LoginLocal>(
      Constants.boxLogin,
    );

    return box;
  }
  
  Future<List<LoginLocal>> getLoginLocal() async {
    final box = await openBox();
    List<LoginLocal> list = box.values.toList();

    return list;
  }

  Future<void> addLoginLocal(LoginLocal loginLocal) async {
    final box = await openBox();
    await box.add(loginLocal);
  }

  Future<void> deleteAllLoginLocal() async {
    final box = await openBox();
    await box.deleteFromDisk();
  }

  Future<http.Response> login(String username, String password) async {
    var map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;

    final response = await http.post(
      Uri.parse("${Constants.baseUrl}auth/login"),
      headers: {
        "Client-Service": "driver-client",
        "Auth-Key": "bkmrestapi",
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: map,
    );

    return response;
  }

}