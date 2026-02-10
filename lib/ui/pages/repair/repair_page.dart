import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/repair/repair_bloc.dart';
import 'package:newbkmmobile/blocs/repair/repair_event.dart';
import 'package:newbkmmobile/blocs/repair/repair_state.dart';
import 'package:newbkmmobile/models/repair/maintenance_model.dart';
import 'package:newbkmmobile/models/repair/repair_model.dart';
import 'package:newbkmmobile/models/repair/vehicle_repair_data.dart';
import 'package:newbkmmobile/repositories/master_data_repository.dart';
import 'package:newbkmmobile/repositories/repair_repository.dart';
import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'package:newbkmmobile/ui/widgets/bkm_loading.dart';
import '../../../core/convert_date.dart';
import '../../../models/common/hive/hive_master_data.dart';
import 'repair_form_page.dart';
import 'repair_detail_page.dart';

class RepairPage extends StatefulWidget {
  const RepairPage({super.key});

  @override
  State<RepairPage> createState() => _RepairPageState();
}

class _RepairPageState extends State<RepairPage> {
  // Inisialisasi Bloc
  final RepairBloc _repairBloc = RepairBloc(RepairRepository());
  final ConvertDate dateConverter = ConvertDate();
  late HiveMasterData masterData;

  @override
  void initState() {
    super.initState();
    _loadMasterData();
    _repairBloc.add(FetchRepairs());
  }

  Future<void> _loadMasterData() async {
    masterData = (await MasterDataRepository.getCommonData())!;
  }

  @override
  void dispose() {
    _repairBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF002B4C);
    const orange = Color(0xFFD4552F);

    return BlocProvider(
      create: (context) => _repairBloc,
      child: BlocListener<RepairBloc, RepairState>(
        listener: (BuildContext context, RepairState state) {
          if (state is RepairLoading) {
            BkmLoading.show(context, message: "mohon tunggu");
          }

          if (state is RepairLoaded || state is RepairFailure) {
            BkmLoading.hide(context);
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F6F8),
          appBar: AppBar(
            backgroundColor: darkBlue,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Pengajuan Perbaikan",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new,
                      color: Colors.white, size: 18),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              // TOMBOL TAMBAH
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () async {

                      if (masterData.repairTypes != null &&
                          masterData.repairTypes!.isNotEmpty &&
                          masterData.urgencyLevels != null &&
                          masterData.urgencyLevels!.isNotEmpty &&
                          masterData.maintenancetypes != null &&
                          masterData.maintenancetypes!.isNotEmpty) {
                        // Navigasi ke Form
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RepairFormPage(
                                  masterData.repairTypes,
                                  masterData.urgencyLevels,
                                  masterData.maintenancetypes)),
                        );

                        // --- REFRESH LIST JIKA SUKSES SIMPAN --- //
                        if (result == true) {
                          _repairBloc.add(FetchRepairs());
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 2,
                    ),
                    child: const Text(
                      "Tambah",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),

              // LIST DATA
              Expanded(
                child: BlocBuilder<RepairBloc, RepairState>(
                  builder: (context, state) {
                    if (state is RepairLoaded) {
                      if (state.repairs.isEmpty) {
                        return const Center(
                            child: Text("Belum ada pengajuan perbaikan"));
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        itemCount: state.repairs.length,
                        itemBuilder: (context, index) {
                          final item = state.repairs[index];
                          return _buildRepairCard(context, item, masterData);
                        },
                      );
                    } else if (state is RepairFailure) {
                      return Center(child: Text("Error: ${state.error}"));
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color hexToColor(String? hex) {
    if (hex == null || hex.isEmpty) return Colors.grey.shade300;

    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }


  Widget _buildRepairCard(
      BuildContext context, MaintenanceListData item,
      HiveMasterData masterData) {
    const darkBlue = Color(0xFF002B4C);

    Color statusColor() {
      switch (item.status?.name) {
        case "Tunda":
          return Colors.orange;
        case "Selesai":
          return Colors.green;
        case "Proses":
          return Colors.blue;
        default:
          return Colors.grey;
      }
    }

    return GestureDetector(
      onTap: () async {
        if (masterData.repairTypes != null &&
            masterData.repairTypes!.isNotEmpty &&
            masterData.urgencyLevels != null &&
            masterData.urgencyLevels!.isNotEmpty &&
            masterData.maintenancetypes != null &&
            masterData.maintenancetypes!.isNotEmpty) {
          // Navigasi ke Form
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RepairFormPage(
                    masterData.repairTypes,
                    masterData.urgencyLevels,
                    masterData.maintenancetypes, data: item,)),
          );

          // --- REFRESH LIST JIKA SUKSES SIMPAN --- //
          if (result == true) {
            _repairBloc.add(FetchRepairs());
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10), // ⬅️ lebih rapat
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 12), // ⬅️ lebih padat
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10), // sedikit diperkecil
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TANGGAL
            Text(
              "Tgl Pengajuan : ${dateConverter.formatToDayMonthYear(item.requestAt)}",
              style: const TextStyle(
                fontSize: 12, // ⬆️ dibesarkan
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 6), // ⬅️ lebih rapat

            /// PRIORITY & STATUS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.priority?.name ?? "-",
                  style: const TextStyle(
                    fontSize: 17, // sedikit diturunkan
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: hexToColor(item.status?.colorHex),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    item.status?.name ?? "-",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11, // lebih padat
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Divider(
              height: 1,
              thickness: 0.8,
              color: Colors.grey.shade200,
            ),
            const SizedBox(height: 8),

            /// JENIS PERBAIKAN & KM
            Row(
              children: [
                // KIRI
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Jenis Perbaikan",
                        style:
                        TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.maintenanceType?.name ?? "-",
                        style: const TextStyle(
                          fontSize: 14, // ⬆️ lebih kebaca
                          fontWeight: FontWeight.w600,
                          color: darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),

                // KANAN
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Kilometer Terakhir",
                        textAlign: TextAlign.right,
                        style:
                        TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${item.currentKm} km",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontSize: 16, // ⬆️ fokus utama
                          fontWeight: FontWeight.bold,
                          color: darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
