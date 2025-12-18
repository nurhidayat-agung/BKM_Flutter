import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/repair/repair_bloc.dart';
import 'package:newbkmmobile/blocs/repair/repair_event.dart';
import 'package:newbkmmobile/blocs/repair/repair_state.dart';
import 'package:newbkmmobile/models/repair/repair_model.dart';
import 'package:newbkmmobile/models/repair/vehicle_repair_data.dart';
import 'package:newbkmmobile/repositories/master_data_repository.dart';
import 'package:newbkmmobile/repositories/repair_repository.dart';
import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'package:newbkmmobile/ui/widgets/bkm_loading.dart';
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

  @override
  void initState() {
    super.initState();
    _repairBloc.add(FetchRepairs());
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
            BkmLoading.show(context,message: "mohon tunggu");
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
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
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
                      var masterData = await MasterDataRepository.getCommonData();

                      if (masterData != null &&
                          masterData.repairTypes != null &&
                          masterData.repairTypes!.isNotEmpty &&
                          masterData.urgencyLevels != null &&
                          masterData.urgencyLevels!.isNotEmpty) {
                        // Navigasi ke Form
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RepairFormPage(
                                  masterData.repairTypes,
                                  masterData.urgencyLevels)),
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
                          return _buildRepairCard(context, item);
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

  Widget _buildRepairCard(
      BuildContext context, VehicleRepairData item) {
    const darkBlue = Color(0xFF002B4C);

    return GestureDetector(
      onTap: () async {

        var masterData = await MasterDataRepository.getCommonData();

        if (masterData != null &&
            masterData.repairTypes != null &&
            masterData.repairTypes!.isNotEmpty &&
            masterData.urgencyLevels != null &&
            masterData.urgencyLevels!.isNotEmpty) {
          // Navigasi ke Form
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RepairFormPage(
                    masterData.repairTypes, masterData.urgencyLevels,data: item,)),
          );

          // --- REFRESH LIST JIKA SUKSES SIMPAN --- //
          if (result == true) {
            _repairBloc.add(FetchRepairs());
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tgl Pengajuan : ${item.requestDate}",
              style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.urgencyLevel?.name ?? "",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkBlue),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.status ?? "",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Jenis Perbaikan",
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        item.repairType?.name ?? "",
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: darkBlue),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Kilometer Terakhir",
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(
                        item.currentKm.toString(),
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: darkBlue),
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
