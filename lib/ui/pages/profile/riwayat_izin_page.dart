import 'package:flutter/material.dart';

class RiwayatIzinPage extends StatelessWidget {
  const RiwayatIzinPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // untuk contoh awal tampilkan pesan jika belum ada data
    final List<String> riwayat = [];

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.orange),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Riwayat Izin / Cuti",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: riwayat.isEmpty
          ? const Center(
        child: Text(
          "Tidak ada data riwayat izin / cuti",
          style: TextStyle(color: Colors.black54, fontSize: 15),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: riwayat.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.event_note, color: Colors.blueAccent),
              title: Text(riwayat[index]),
              subtitle: const Text("Status: Disetujui"),
            ),
          );
        },
      ),
    );
  }
}
