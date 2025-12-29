import 'package:hive_flutter/hive_flutter.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/models/legacy/login_form_local.dart';

class LoginFormRepository {

  Future<Box<LoginFormLocal>> openBox() async {
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(LoginFormLocalAdapter());
    }
    var box = await Hive.openBox<LoginFormLocal>(
      Constants.boxLoginForm,
    );

    return box;
  }

  Future<List<LoginFormLocal>> getLoginFormLocal() async {
    final box = await openBox();
    List<LoginFormLocal> list = box.values.toList();

    return list;
  }

  Future<void> addLoginFormLocal(LoginFormLocal loginFormLocal) async {
    final box = await openBox();
    await box.add(loginFormLocal);
  }

  Future<void> updateLoginFormLocal(LoginFormLocal loginFormLocal) async {
    final box = await openBox();
    await box.putAt(0, loginFormLocal);
  }

  Future<void> deleteAllLoginFormLocal() async {
    final box = await openBox();
    await box.deleteFromDisk();
  }

}