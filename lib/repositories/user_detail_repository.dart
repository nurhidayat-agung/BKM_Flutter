// import 'package:hive/hive.dart';
// import 'package:newbkmmobile/core/constants.dart';
// import 'package:newbkmmobile/models/announcement_local.dart';
// import 'package:newbkmmobile/models/user_detail_local.dart';
// import 'package:newbkmmobile/models/vehicle_local.dart';
// import 'package:newbkmmobile/repositories/login_repository.dart';
// import 'package:http/http.dart' as http;
//
// class UserDetailRepository {
//
//   Future<Box<UserDetailLocal>> openBox() async {
//     if (!Hive.isAdapterRegistered(1)) {
//       Hive.registerAdapter(UserDetailLocalAdapter());
//       Hive.registerAdapter(AnnouncementLocalAdapter());
//       Hive.registerAdapter(VehicleLocalAdapter());
//     }
//     var box = await Hive.openBox<UserDetailLocal>(
//       Constants.boxUserDetail,
//     );
//
//     return box;
//   }
//
//   Future<List<UserDetailLocal>> getUserDetailLocal() async {
//     final box = await openBox();
//     List<UserDetailLocal> list = box.values.toList();
//
//     return list;
//   }
//
//   Future<void> addUserDetailLocal(UserDetailLocal userDetailLocal) async {
//     final box = await openBox();
//     await box.add(userDetailLocal);
//   }
//
//   Future<void> deleteAllUserDetailLocal() async {
//     final box = await openBox();
//     await box.deleteFromDisk();
//   }
//
//   Future<http.Response> getUserDetailRemote() async {
//     final loginLocal = await LoginRepository().getLoginLocal();
//
//     final response = await http.get(
//       Uri.parse("${Constants.baseUrl}transaction/user_info"),
//       headers: {
//         "Client-Service": "driver-client",
//         "Auth-Key": "bkmrestapi",
//         "Content-Type": "application/x-www-form-urlencoded",
//         "Authorization": loginLocal[0].token,
//         "User-ID": loginLocal[0].userId,
//       },
//     );
//
//     return response;
//   }
//
// }

import 'package:hive/hive.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/models/announcement_local.dart';
import 'package:newbkmmobile/models/user_detail_local.dart';
import 'package:newbkmmobile/models/vehicle_local.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:http/http.dart' as http;

class UserDetailRepository {
  Future<Box<UserDetailLocal>> openBox() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserDetailLocalAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(AnnouncementLocalAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(VehicleLocalAdapter());
    }

    return await Hive.openBox<UserDetailLocal>(Constants.boxUserDetail);
  }

  Future<List<UserDetailLocal>> getUserDetailLocal() async {
    final box = await openBox();
    return box.values.toList();
  }

  Future<void> addUserDetailLocal(UserDetailLocal userDetailLocal) async {
    final box = await openBox();
    await box.add(userDetailLocal);
  }

  Future<void> deleteAllUserDetailLocal() async {
    final box = await openBox();
    await box.clear();
  }

  Future<http.Response> getUserDetailRemote() async {
    final loginLocal = await LoginRepository().getLoginLocal();

    final response = await http.get(
      Uri.parse("${Constants.baseUrl}transaction/user_info"),
      headers: {
        "Client-Service": "driver-client",
        "Auth-Key": "bkmrestapi",
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": loginLocal[0].token,
        "User-ID": loginLocal[0].userId,
      },
    );

    return response;
  }
}
