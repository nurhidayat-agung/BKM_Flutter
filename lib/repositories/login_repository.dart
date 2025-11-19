import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:newbkmmobile/core/R/HiveTypeId.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/models/login_local.dart';
import 'package:newbkmmobile/models/login/login_resp.dart';
import 'package:newbkmmobile/services/http_communicator.dart';
import '../core/R/hive/AuthBoxSchema.dart';
import '../models/login/UserSession.dart';
import '../models/login/login_response.dart';
import '../services/api_service.dart';

class LoginRepository {
  final ApiService _apiService = ApiService();
  final HttpCommunicator _httpCommunicator = HttpCommunicator();

  // ===============================================================
  // ===============  HIVE SETUP / LOCAL STORAGE  ==================
  // ===============================================================

  Future<Box<LoginLocal>> openBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(LoginLocalAdapter());
    }
    return await Hive.openBox<LoginLocal>(Constants.boxLogin);
  }

  Future<List<LoginLocal>> getLoginLocal() async {
    final box = await openBox();
    return box.values.toList();
  }

  Future<void> addLoginLocal(LoginLocal loginLocal) async {
    final box = await openBox();
    await box.clear();
    await box.add(loginLocal);
  }

  Future<void> deleteAllLoginLocal() async {
    final box = await openBox();
    await box.deleteFromDisk();
  }

  // ===============================================================
  // ===============  MODE ONLINE LOGIN  ===========================
  // ===============================================================

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

  // ===========================================================
  // REGISTER / SAVE / LOAD USER SESSION
  // ===========================================================

  Future<void> _registerUserSessionAdapter() async {
    if (!Hive.isAdapterRegistered(HiveTypeId.userSession)) {
      Hive.registerAdapter(UserSessionAdapter());
    }
  }

  Future<UserSession?> getUserSession() async {
    await _registerUserSessionAdapter();
    final box = await Hive.openBox<UserSession>(AuthBoxSchema.authBox);
    if (box.isEmpty) return null;
    return box.values.first;
  }

  Future<void> saveUserSession(UserSession session) async {
    await _registerUserSessionAdapter();
    final box = await Hive.openBox<UserSession>(AuthBoxSchema.authBox);
    await box.clear();
    await box.add(session);
  }

  Future<void> deleteUserSession() async {
    await Hive.deleteFromDisk();
  }

  // ===============================================================
  // ======================  LOGIN BARU (QUBU API)  =================
  // ===============================================================

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

      // Gagal login
      if (response.status != 200) {
        return LoginResp(
          status: 401,
          message: "Login gagal",
          userId: "",
          token: "",
          firebaseToken: "",
        );
      }

      // PARSING JSON
      var resp = LoginResponse.fromJson(response.result);

      // SIMPAN USERSESSION
      var session = UserSession.fromLoginResponse(resp);
      session.status = response.status;
      await saveUserSession(session);

      // --------------------------------------------------------
      //  SIMPAN LOGIN LOCAL
      // --------------------------------------------------------

      final user = resp.data.user;
      final driver = user.driver;

      await addLoginLocal(
        LoginLocal(
          status: 200,
          message: "Login berhasil",
          userId: user.id,
          token: resp.data.token,
          firebaseToken: "",
          siteId: driver.siteId,
          driverId: driver.id,
        ),
      );

      // Berhasil
      return LoginResp(
        status: 200,
        message: "Login berhasil",
        userId: user.id,
        token: resp.data.token,
        firebaseToken: '',
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
  // ===============  LOGOUT (REMOTE)  =============================
  // ===============================================================

  Future<bool> logoutRemote() async {
    try {
      final userSession = await getUserSession();
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

      if (response.status == 200 || response.status == 401) {
        await deleteUserSession();
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
