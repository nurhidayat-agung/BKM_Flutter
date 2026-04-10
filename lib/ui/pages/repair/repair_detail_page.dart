import 'package:flutter/material.dart';
import 'package:newbkmmobile/models/repair/repair_model.dart';
import 'package:newbkmmobile/models/repair/vehicle_repair_data.dart';
import 'package:newbkmmobile/core/convert_date.dart';


class RepairDetailPage extends StatelessWidget {
  final dynamic item;
  final String badgeText;
  final Color badgeColor;

  const RepairDetailPage({
    super.key,
    required this.item,
    required this.badgeText,
    required this.badgeColor,
  });
  //kode lama
  // final VehicleRepairData item;
  // const RepairDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF002B4C);

    // RUMUS UNTUK MEMBACA DATA API DENGAN AMAN
    final ConvertDate dateConverter = ConvertDate();
    final tgl = dateConverter.formatToDayMonthYear(item.requestAt);
    final priority = item.priority?.name ?? "Medium";
    final type = item.maintenanceType?.name ?? "-";
    final km = "${item.currentKm ?? 0} Km";

    String keterangan = "-";
    try {
      keterangan = item.description ?? item.damageDescription ?? "-";
    } catch (_) {}

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pengajuan Perbaikan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
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
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tanggal
              Text(
                "Tgl Pengajuan : $tgl",
                style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              // Judul & Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    priority, // "Medium"
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkBlue),
                  ),
                  // INI PENERAPAN WARNA DAN TEKS DARI HALAMAN DEPAN
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: badgeColor, // ⬅️ Warnanya menyesuaikan
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      badgeText, // ⬅️ Teksnya menyesuaikan
                      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //kode lama
                  // Container(
                  //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  //   decoration: BoxDecoration(
                  //     color: Colors.blueAccent,
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: Text(
                  //     item.status ?? "",
                  //     style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(height: 24),

              // Info Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Jenis Perbaikan", style: TextStyle(fontSize: 12, color: Colors.black54)),
                        const SizedBox(height: 4),
                        Text(
                          type,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: darkBlue),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Kilometer Terakhir", style: TextStyle(fontSize: 12, color: Colors.black54)),
                        const SizedBox(height: 4),
                        Text(
                          km,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: darkBlue),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Keterangan / Alasan
              const Text("Keterangan", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: darkBlue)),
              const SizedBox(height: 8),
              Text(
                keterangan,
                style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}