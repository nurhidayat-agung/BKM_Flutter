import 'package:newbkmmobile/models/common/hive/hive_master_data.dart';
import 'package:newbkmmobile/models/common/hive/hive_simple_master.dart';
import 'package:newbkmmobile/models/common/master_data.dart';
import 'package:newbkmmobile/models/common/simple_master.dart';

class MasterDataMapper {
  static HiveSimpleMaster toHiveSimple(SimpleMaster src) {
    return HiveSimpleMaster(
      id: src.id,
      fieldName: src.fieldName,
      fieldValue: src.fieldValue,
      name: src.name,
      code: src.code,
      sort: src.sort,
      description: src.description,
      color: src.color,
      colorHex: src.colorHex,
      isActive: src.isActive,
    );
  }

  static HiveMasterData toHiveMaster(MasterData src) {
    return HiveMasterData(
      repairTypes: src.repairTypes
          ?.map((e) => toHiveSimple(e))
          .toList(),
      leaveTypes: src.leaveTypes
          ?.map((e) => toHiveSimple(e))
          .toList(),
      urgencyLevels: src.urgencyLevels
          ?.map((e) => toHiveSimple(e))
          .toList(),
      maintenancetypes: src.maintenanceTypes
          ?.map((e) => toHiveSimple(e))
          .toList()
    );
  }
}
