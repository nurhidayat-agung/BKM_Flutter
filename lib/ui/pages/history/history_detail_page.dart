import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/history_detail/history_detail_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/history_repository.dart';
import 'package:newbkmmobile/ui/widgets/full_image_view.dart';

import '../../../models/trip_history/v2/do_detail_history.dart';

class HistoryDetailPage extends StatefulWidget {
  final String id;
  final DoDetailHistory detailHistory;
  const HistoryDetailPage({super.key, required this.id, required this.detailHistory}
);

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  final _historyBloc = HistoryDetailBloc(HistoryRepository());

  @override
  void initState() {
    super.initState();
    _historyBloc.add(HistoryDetail(id: widget.id));
  }

  /// =====================================================
  /// SAFE DATE PARSER
  /// =====================================================
  String safeDate(String? raw) {
    if (raw == null || raw.isEmpty) return "-";
    try {
      final dt = DateTime.parse(raw);
      const months = [
        "Jan", "Feb", "Mar", "Apr", "Mei", "Jun",
        "Jul", "Agu", "Sep", "Okt", "Nov", "Des"
      ];
      return "${dt.day} ${months[dt.month - 1]} ${dt.year}";
    } catch (e) {
      return raw;
    }
  }

  /// =====================================================
  /// DUMMY DETAIL (Fallback)
  /// =====================================================
  final dummyDetail = {
    "doNumber": "051/KAL-EUP/IP-CPO/X/2025",
    "subDo": "10002/TEST/VIII/2025",
    "spbNumber": "123456",
    "driverName": "DEDI PURWANTO",
    "vehicleNumber": "B 9501 UVX",
    "pksName": "SAM1",
    "destinationName": "ASK",
    "commodityName": "CPO (Crud Palm Oil)",
    "bonus": "120.000",
    "loadDate": "2025-11-11",
    "unloadDate": "2025-11-12",
    "amountSent": "27000",
    "amountReceived": "27000",
    "spb": "",
    "qrcode": ""
  };


  // ======= WIDGET BUILDER HELPERS (Sesuai Mockup) =========

  Widget _buildInfoRow(String label, String value, {bool isRightAlign = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF002B4C),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF002B4C),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardDivider() {
    return Divider(height: 16, thickness: 1, color: Colors.grey.shade200);
  }

  Widget _buildActivityCard(String titleDO, Map<String, dynamic> data, bool isMuat, BuildContext context) {
    // Mapping data to mockup fields
    final noSPB = widget.detailHistory.spbNumber ?? "-";
    // Mockup logic: Tara/Bruto simulasi karena data dummy asli terbatas,
    // tapi tetap menampilkan Netto dari data asli.
    String tara = isMuat ? (widget.detailHistory.loadTare?.toString() ?? "0")
        : (widget.detailHistory.unloadTare?.toString() ?? "0");

    final bruto = isMuat ? (widget.detailHistory.loadBruto?.toString() ?? "0")
        : (widget.detailHistory.unloadBruto?.toString() ?? "0");

    final netto = isMuat ? (widget.detailHistory.loadQuantity?.toString() ?? "0")
        : (widget.detailHistory.unloadQuantity?.toString() ?? "0");
    final fotoUrl = data["spb"];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "DO : $titleDO",
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: Color(0xFF002B4C),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow("No. SPB", noSPB),
          _buildCardDivider(),
          _buildInfoRow("Jumlah Tara Muat", tara),
          _buildCardDivider(),
          _buildInfoRow("Jumlah Bruto Muat", bruto),
          _buildCardDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Netto Muat (Kg)",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF002B4C),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                netto,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF002B4C),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          _buildCardDivider(),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Foto SPB",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF002B4C),
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if ((fotoUrl ?? "").isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FullImageView(image: fotoUrl)),
                    );
                  }
                },
                child: (fotoUrl != null && fotoUrl.isNotEmpty)
                    ? Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(image: NetworkImage(fotoUrl), fit: BoxFit.cover)
                  ),
                )
                    : Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text("Foto", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Definisi Warna sesuai Mockup
    const darkBlue = Color(0xFF002B4C);
    const orange = Color(0xFFE55300);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pengangutan Baru",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2B4D66),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.chevron_left, color: Colors.white, size: 20),
            ),
          ),
        ),
      ),
      body: BlocBuilder<HistoryDetailBloc, HistoryDetailState>(
        bloc: _historyBloc,
        builder: (context, state) {
          Map<String, dynamic> d = Map.from(dummyDetail);

          if (state is HistoryDetailSuccess) {
            final api = state.historyDetailResp;
            if ((api.doNumber ?? "").isNotEmpty) {
              d = {
                "doNumber": api.doNumber,
                "subDo": api.subDo,
                "spbNumber": api.spbNumber,
                "driverName": api.driverName,
                "vehicleNumber": api.vehicleNumber,
                "pksName": api.pksName,
                "destinationName": api.destinationName,
                "commodityName": api.commodityName,
                "bonus": api.bonus,
                "loadDate": api.loadDate,
                "unloadDate": api.unloadDate,
                "amountSent": api.amountSent,
                "amountReceived": api.amountReceived,
                "spb": api.spb,
                "qrcode": api.qrcode,
              };
            }
          }

          if (state is HistoryDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Variabel Data untuk UI
          final routeText = "${widget.detailHistory.deliveryOrder?.pks?.code ?? ""} \u2192 ${widget.detailHistory.deliveryOrder?.destination?.code ?? ""}";
          final routeSubtext = "${widget.detailHistory.deliveryOrder?.pks?.name ?? ""} \u2192 ${widget.detailHistory.deliveryOrder?.destination?.name ?? ""}";; // Statis sesuai mockup atau ambil dari logic jika ada
          final commodity = widget.detailHistory.deliveryOrder?.commodity?.name ?? "";
          final doNumber = widget.detailHistory.deliveryOrder?.doNumber ?? "";
          final subDo = d['subDo'] ?? "-";

          final noDoKecil = "01/15"; // Placeholder sesuai mockup (logic asli bisa ditambahkan)
          final driver = widget.detailHistory.driver?.name ?? "-";
          final vehicle = widget.detailHistory.vehicle?.policeNumber ?? "-";

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === MAIN INFO CARD ===
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA), // Very light grey bg
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Route
                      Text(
                        routeText,
                        style: const TextStyle(
                          color: orange,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        routeSubtext,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Commodity
                      const Text(
                        "Komoditi",
                        style: TextStyle(
                          fontSize: 11,
                          color: darkBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        commodity,
                        style: const TextStyle(
                          fontSize: 14,
                          color: darkBlue,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // DO Number Big
                      const Text(
                        "No DO Besar",
                        style: TextStyle(
                          fontSize: 11,
                          color: darkBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        doNumber,
                        style: const TextStyle(
                          fontSize: 18,
                          color: darkBlue,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        subDo,
                        style: const TextStyle(
                          fontSize: 13,
                          color: darkBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 16),
                      const Divider(height: 1, color: Color(0xFFE0E0E0)),
                      const SizedBox(height: 12),

                      // Driver Details
                      _buildInfoRow("No DO Kecil", noDoKecil),
                      _buildInfoRow("Nama Supir", driver),
                      _buildInfoRow("No Kendaraan", vehicle),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // === SECTION MUAT ===
                const Text(
                  "MUAT",
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildActivityCard(doNumber, d, true, context),

                // === SECTION BONGKAR ===
                const Text(
                  "BONGKAR",
                  style: TextStyle(
                    color: darkBlue,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _buildActivityCard(doNumber, d, false, context),
              ],
            ),
          );
        },
      ),
    );
  }
}