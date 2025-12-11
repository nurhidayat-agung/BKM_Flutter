import 'package:hive/hive.dart';
import 'package:newbkmmobile/core/R/HiveTypeId.dart';

import 'hive_simple_master.dart';

part 'hive_master_data.g.dart';

@HiveType(typeId: HiveTypeId.masterData)
class HiveMasterData extends HiveObject {
  @HiveField(0)
  List<HiveSimpleMaster>? repairTypes;

  @HiveField(1)
  List<HiveSimpleMaster>? leaveTypes;

  @HiveField(2)
  List<HiveSimpleMaster>? urgencyLevels;

  HiveMasterData({
    this.repairTypes,
    this.leaveTypes,
    this.urgencyLevels,
  });
}
