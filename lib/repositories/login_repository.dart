import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/models/login_local.dart';
import 'package:newbkmmobile/models/login/login_resp.dart';
import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'package:newbkmmobile/services/http_communicator.dart';
import '../core/R/hive/AuthBoxSchema.dart';
import '../models/login/UserSession.dart';
import '../models/login/login_response.dart';
import '../services/api_service.dart';

class LoginRepository {
  final ApiService _apiService = ApiService(); // versi API manual
  final HttpCommunicator _httpCommunicator = HttpCommunicator();

  // ===============================================================
  // ===============  HIVE SETUP / LOCAL STORAGE  ==================
  // ===============================================================

  Future<Box<LoginLocal>> openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(LoginLocalAdapter());
    }
    var box = await Hive.openBox<LoginLocal>(Constants.boxLogin);
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

  // ===============================================================
  // ===============  MODE ONLINE LOGIN  ===========================
  // ===============================================================

  /// 🔹 Mode Online Login (via API JSON)
  Future<LoginResp> loginTemp(String phone, String password) async {
    final result = await _apiService.login(phone, password);
    if (result != null) {
      return LoginResp(
        status: 200,
        message: "Login berhasil",
        userId: result['id'].toString(),
        token: result['token'] ?? '',
        firebaseToken: '',
      );
    } else {
      return LoginResp(
        status: 401,
        message: "Username atau password salah",
        userId: "",
        token: "",
        firebaseToken: "",
      );
    }
  }

  /// --------------------------------------------------------------------------
  /// LOGIN (via HttpCommunicator)
  /// --------------------------------------------------------------------------
  Future<LoginResp> login(String phone, String password) async {
    try {
      final response = await _httpCommunicator.postJson(
        'login',
        headers: {
          'X-Client-Type': 'mobile',
        },
        body: {
          'phone': phone,
          'password': password,
        },
      );


      // 🔒 Validasi hasil
      if (response.status != 200) {
        return LoginResp(
          status: 401,
          message: "login gagal",
          userId: "",
          token: "",
          firebaseToken: "",
        );
      }

      var resp = LoginResponse.fromJson(response.result);
      var session = UserSession.fromLoginResponse(resp);
      session.status = response.status;

      // ✅ Simpan session ke Hive
      await SessionManager.saveUserSession(session);

      // 🟢 Return LoginResp sukses
      return LoginResp(
        status: 200,
        message: "Login berhasil",
        userId: session.userId,
        token: session.token,
        firebaseToken: ''
      );
    } catch (e) {
      return LoginResp(
        status: 500,
        message: "Login gagal: $e",
        userId: "",
        token: "",
        firebaseToken: "",
      );
    }
  }

  // ===============================================================
  // ===============  LOGOUT (REMOTE)  ==============================
  // ===============================================================

  /// 🔹 Hit ke endpoint logout (misalnya: POST /logout)
  Future<bool> logoutRemote() async {
    try {
      final userSession = await SessionManager.getUserSession();
      if (userSession == null || userSession.token == null) {
        return false;
      }

      final response = await _httpCommunicator.postJson(
        'logout',
        headers: {
          'Authorization': 'Bearer ${userSession.token}',
          'X-Client-Type': 'mobile',
        },
        body: {},
      );

      if (response.status == 200) {
        await SessionManager.deleteUserSession();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Logout error: $e');
      return false;
    }
  }
  // ===============================================================
  // ===============  SESSION HELPERS  =============================
  // ===============================================================

  Future<void> logout() async {
    final box = await Hive.openBox(AuthBoxSchema.authBox);
    await box.clear();
  }

  Future<String?> getToken() async {
    final box = await Hive.openBox(AuthBoxSchema.authBox);
    return box.get(AuthBoxSchema.token);
  }

  Future<String?> getWalletBalance() async {
    final box = await Hive.openBox(AuthBoxSchema.authBox);
    return box.get(AuthBoxSchema.walletBalance);
  }

  Future<String?> getUserName() async {
    final box = await Hive.openBox(AuthBoxSchema.authBox);
    return box.get(AuthBoxSchema.userName);
  }

  Future<String?> getUserPhone() async {
    final box = await Hive.openBox(AuthBoxSchema.authBox);
    return box.get(AuthBoxSchema.phone);
  }
}
