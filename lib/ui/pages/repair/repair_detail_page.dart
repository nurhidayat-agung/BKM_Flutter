import 'package:flutter/material.dart';
import 'package:newbkmmobile/models/repair/repair_model.dart';

class RepairDetailPage extends StatelessWidget {
  final RepairModel item;
  const RepairDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF002B4C);

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
                "Tgl Pengajuan : ${item.date}",
                style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),

              // Judul & Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.urgencyTitle, // "Medium"
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkBlue),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: item.statusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      item.status,
                      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
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
                          item.repairType,
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
                          item.lastKm,
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
                item.description,
                style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}