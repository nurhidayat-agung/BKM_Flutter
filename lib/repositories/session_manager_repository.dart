import 'package:hive/hive.dart';
import 'package:newbkmmobile/core/R/HiveTypeId.dart';
import 'package:newbkmmobile/core/R/hive/AuthBoxSchema.dart';
import 'package:newbkmmobile/models/login/UserSession.dart';


/// Static helper class untuk manajemen UserSession Hive
class SessionManager {
  // -------------------------------------------------------
  // PRIVATE HELPER: Register adapter jika belum
  // -------------------------------------------------------
  static Future<void> _registerUserSessionAdapter() async {
    if (!Hive.isAdapterRegistered(HiveTypeId.userSession)) {
      Hive.registerAdapter(UserSessionAdapter());
    }
  }

  // -------------------------------------------------------
  // GET USER SESSION
  // -------------------------------------------------------
  static Future<UserSession?> getUserSession() async {
    await _registerUserSessionAdapter();
    final box = await Hive.openBox<UserSession>(AuthBoxSchema.authBox);
    if (box.isEmpty) return null;
    return box.values.first;
  }

  // -------------------------------------------------------
  // SAVE USER SESSION
  // -------------------------------------------------------
  static Future<void> saveUserSession(UserSession session) async {
    await _registerUserSessionAdapter();
    final box = await Hive.openBox<UserSession>(AuthBoxSchema.authBox);
    await box.clear(); // hapus session lama (agar hanya satu)
    await box.add(session);
  }

  // -------------------------------------------------------
  // DELETE USER SESSION
  // -------------------------------------------------------
  static Future<void> deleteUserSession() async {
    await _registerUserSessionAdapter();
    await Hive.deleteBoxFromDisk(AuthBoxSchema.authBox);
  }
}
