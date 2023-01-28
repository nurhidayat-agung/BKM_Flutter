import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/models/announcement_local.dart';
import 'package:newbkmmobile/models/user_detail_local.dart';
import 'package:newbkmmobile/models/vehicle_local.dart';
import 'package:newbkmmobile/network/api_base_helper.dart';

class UserDetailRepository {
  final _helper = APIBaseHelper();

  Future<Box<UserDetailLocal>> openBox() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserDetailLocalAdapter());
      Hive.registerAdapter(AnnouncementLocalAdapter());
      Hive.registerAdapter(VehicleLocalAdapter());
    }
    var box = await Hive.openBox<UserDetailLocal>(
      Constants.boxUserDetail,
    );

    return box;
  }

  Future<List<UserDetailLocal>> getUserDetailLocal() async {
    final box = await openBox();
    List<UserDetailLocal> list = box.values.toList();

    return list;
  }

  Future<void> addUserDetailLocal(UserDetailLocal userDetailLocal) async {
    final box = await openBox();
    await box.add(userDetailLocal);
  }

  Future<void> deleteAllUserDetailLocal() async {
    final box = await openBox();
    await box.deleteFromDisk();
  }

  Future<Response> getUserDetailRemote() async {
    Response response = await _helper.get("transaction/user_info");

    return response;
  }

}