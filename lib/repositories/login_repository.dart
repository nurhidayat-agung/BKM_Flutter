import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/models/login_local.dart';
import 'package:newbkmmobile/network/api_base_helper.dart';

class LoginRepository {
  final _helper = APIBaseHelper();
  
  Future<Box<LoginLocal>> openBox() async {
    const secureStorage = FlutterSecureStorage();
    final key = await secureStorage.read(key: Constants.key);
    final encryptionKey = base64Url.decode(key!);

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(LoginLocalAdapter());
    }
    var box = await Hive.openBox<LoginLocal>(
      Constants.boxLogin,
      encryptionCipher: HiveAesCipher(encryptionKey),
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

  Future<Response> login(String username, String password) async {
    FormData formData = FormData.fromMap({
      "username": username,
      "password": password,
    });

    Response response = await _helper.post(
      "auth/login",
      formData: formData,
    );

    return response;
  }

}