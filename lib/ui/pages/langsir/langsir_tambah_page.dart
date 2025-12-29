import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_bloc.dart';
import 'langsir_form_page.dart';

class LangsirTambahPage extends StatelessWidget {
  final String id;
  final List<Map<String, dynamic>> steps;

  const LangsirTambahPage({required this.id, required this.steps, super.key});

  @override
  Widget build(BuildContext context) {
    final Color darkBlue = const Color(0xFF002B4C);
    final Color orange = const Color(0xFFE55300);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Langsir', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white)),
        backgroundColor: darkBlue,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Color(0xFF2C4A64), borderRadius: BorderRadius.all(Radius.circular(4))),
              child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("051/KAL-EUP/IP-CPO/X/2025",
                          style: TextStyle(color: darkBlue, fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text.rich(
                        TextSpan(children: [
                          TextSpan(text: "SAM1 → ASK", style: TextStyle(color: orange, fontWeight: FontWeight.bold)),
                          TextSpan(text: " | CPO", style: TextStyle(color: orange)),
                        ]),
                      ),
                      const SizedBox(height: 6),
                      const Text("11 Nov 2025", style: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),

                // --- TOMBOL (+) ORANYE ---
                // Saat diklik -> Muncul Form (Gambar 3)
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade400,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<LangsirBloc>(),
                          //child: LangsirFormPage(id: id),
                        ),
                      ));
                    },
                  ),
                )
              ],
            ),
          ),

          // List Steps 1, 2, ...
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final s = steps[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))
                      ]
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF0F0F0),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${s['no']}', style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold, fontSize: 16)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Jumlah Muat", style: TextStyle(color: Colors.grey, fontSize: 11)),
                                  const SizedBox(height: 2),
                                  Text(s['jumlahMuat'] ?? '-', style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold, fontSize: 15)),
                                  const SizedBox(height: 4),
                                  const Text("Tanggal Muat", style: TextStyle(color: Colors.grey, fontSize: 11)),
                                  Text(s['tanggalMuat'] ?? '-', style: TextStyle(color: darkBlue, fontSize: 13, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Jumlah Bongkar", style: TextStyle(color: Colors.grey, fontSize: 11)),
                                  const SizedBox(height: 2),
                                  Text(s['jumlahBongkar'] ?? '-', style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold, fontSize: 15)),
                                  const SizedBox(height: 4),
                                  const Text("Tanggal Bongkar", style: TextStyle(color: Colors.grey, fontSize: 11)),
                                  Text(s['tanggalMuat'] ?? '-', style: TextStyle(color: darkBlue, fontSize: 13, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}