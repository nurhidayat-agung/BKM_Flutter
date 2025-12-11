import 'package:newbkmmobile/core/R/HiveTypeId.dart';
import 'package:newbkmmobile/models/common/app_setting_response.dart';
import 'package:newbkmmobile/models/common/hive/hive_master_data.dart';
import 'package:newbkmmobile/models/common/hive/hive_simple_master.dart';
import 'package:newbkmmobile/models/common/hive/master_data_mapper.dart';
import 'package:newbkmmobile/models/common/master_data.dart';
import 'package:hive/hive.dart';
import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'package:newbkmmobile/services/http_communicator.dart';

class MasterDataRepository {
  final HttpCommunicator _http = HttpCommunicator();

  static const String hiveBox = 'master_data_box';
  static const String hiveKey = 'master_data';

  /// --------------------------------------------------------------------------
  /// GET MASTER DATA dari API
  /// --------------------------------------------------------------------------
  Future<HiveMasterData?> fetchMasterData() async {
    final driver = await SessionManager.getUserSession();

    final response = await _http.get(
      'initial-data',
      headers: {
        'X-Site-ID': driver?.siteId ?? "",
      },
    );

    if (response.status == 200 && response.result != null) {
      final data = AppSettingsResponse.fromJson(response.result);
      final hiveData =
          MasterDataMapper.toHiveMaster(data.data?.masterData ?? MasterData());
      await saveToHive(hiveData);
      return hiveData;
    }

    return null;
  }

  /// --------------------------------------------------------------------------
  /// SAVE ke HIVE
  /// --------------------------------------------------------------------------
  Future<void> saveToHive(HiveMasterData data) async {
    await _registerUserAdapter();
    final box = await Hive.openBox<HiveMasterData>(hiveBox);
    await box.put(hiveKey, data);
  }

  /// --------------------------------------------------------------------------
  /// GET dari HIVE
  /// --------------------------------------------------------------------------
  Future<HiveMasterData?> getFromHive() async {
    await _registerUserAdapter();
    final box = await Hive.openBox<HiveMasterData>(hiveBox);
    return box.get(hiveKey);
  }

  /// --------------------------------------------------------------------------
  /// CLEAR HIVE
  /// --------------------------------------------------------------------------
  Future<void> clear() async {
    await _registerUserAdapter();
    final box = await Hive.openBox<HiveMasterData>(hiveBox);
    await box.delete(hiveKey);
  }

  Future<void> _registerUserAdapter() async {
    if (!Hive.isAdapterRegistered(HiveTypeId.masterData)) {
      Hive.registerAdapter(HiveMasterDataAdapter());
    }

    if (!Hive.isAdapterRegistered(HiveTypeId.masterDataItem)) {
      Hive.registerAdapter(HiveSimpleMasterAdapter());
    }
  }
}
