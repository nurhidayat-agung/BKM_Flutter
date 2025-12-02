import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_bloc.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_event.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_state.dart';

class LangsirDetailPage extends StatefulWidget {
  final String id;
  const LangsirDetailPage({required this.id, super.key});

  @override
  State<LangsirDetailPage> createState() => _LangsirDetailPageState();
}

class _LangsirDetailPageState extends State<LangsirDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<LangsirBloc>().add(FetchLangsirDetail(widget.id));
  }

  Widget _buildDetailRowWithColor(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActivityCard(String title, Map<String, dynamic> data, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "DO : ${data['do_ref'] ?? '051/KAL-EUP/IP-CPO/X/2025'}",
                    style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)
                ),
                const SizedBox(height: 12),
                _buildDetailRowWithColor("No. SPB", "${data['no_spb'] ?? '-'}", color),
                const Divider(color: Color(0xFFEEEEEE)),
                _buildDetailRowWithColor("Jumlah Tara Muat", "${data['tara'] ?? '0'}", color),
                const Divider(color: Color(0xFFEEEEEE)),
                _buildDetailRowWithColor("Jumlah Bruto Muat", "${data['bruto'] ?? '0'}", color),
                const Divider(color: Color(0xFFEEEEEE)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Netto Muat (Kg)", style: TextStyle(color: color, fontSize: 13)),
                    Text("${data['netto'] ?? '0'}", style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w900)),
                  ],
                ),
                const Divider(color: Color(0xFFEEEEEE)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text("Foto SPB", style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Container(
                      width: 50,
                      height: 50,
                      color: const Color(0xFFCFD8DC),
                      child: const Center(child: Text("Foto", style: TextStyle(fontSize: 10, color: Colors.grey))),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color darkBlue = const Color(0xFF002B4C);
    final Color orange = const Color(0xFFE55300);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Langsir Detail', style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16, color: Colors.white)),
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
      body: BlocConsumer<LangsirBloc, LangsirState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LangsirLoading) return const Center(child: CircularProgressIndicator());

          if (state is LangsirDetailLoaded) {
            final d = state.detail;
            final muatData = (d['muat'] is List && (d['muat'] as List).isNotEmpty) ? d['muat'][0] : {};
            final bongkarData = (d['bongkar'] is List && (d['bongkar'] as List).isNotEmpty) ? d['bongkar'][0] : {};

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- HEADER CARD UTAMA ---
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(d['route'] ?? "SAM1 → ASK", style: TextStyle(color: orange, fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text("PT. Subur Arum Makmur 1 → PT. Adhitya Serayakorita", style: TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(height: 12),

                        Text("Komoditi", style: TextStyle(fontSize: 12, color: darkBlue)),
                        Text(d['commodity'] ?? "CPO (Crud Palm Oil)", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkBlue)),
                        const SizedBox(height: 12),

                        Text("No DO Besar", style: TextStyle(fontSize: 12, color: darkBlue)),
                        Text(d['do'] ?? "051/KAL-EUP/IP-CPO/X/2025", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: darkBlue)),
                        Text("10002/TEST/VIII/2025", style: TextStyle(fontSize: 13, color: darkBlue, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 16),

                        const Divider(height: 1),
                        const SizedBox(height: 12),

                        _buildDetailRowWithColor("No DO Kecil", "01/15", darkBlue),
                        const SizedBox(height: 6),
                        _buildDetailRowWithColor("Nama Supir", d['supir'] ?? "DEDI PURWANTO", darkBlue),
                        const SizedBox(height: 6),
                        _buildDetailRowWithColor("No Kendaraan", d['plat'] ?? "B 9501 UVX", darkBlue),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text("MUAT", style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  _buildActivityCard("MUAT", muatData, darkBlue),

                  Text("BONGKAR", style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 8),
                  _buildActivityCard("BONGKAR", bongkarData, darkBlue),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}