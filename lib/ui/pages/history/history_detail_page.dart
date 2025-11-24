import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/history_detail/history_detail_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/history_repository.dart';
import 'package:newbkmmobile/ui/widgets/full_image_view.dart';

class HistoryDetailPage extends StatefulWidget {
  final String id;
  const HistoryDetailPage({super.key, required this.id});

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
  /// SAFE DATE PARSER — TANPA ERROR
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
      return raw; // fallback, tidak boleh crash
    }
  }

  /// =====================================================
  /// DUMMY DETAIL (Fallback jika API kosong)
  /// =====================================================
  final dummyDetail = {
    "doNumber": "051/KAL-EUP/IP-CPO/X/2025",
    "subDo": "Sub DO – 12345",
    "spbNumber": "SPB-998877",
    "driverName": "Budi Santoso",
    "vehicleNumber": "KT 9090 XX",
    "pksName": "SAM1",
    "destinationName": "ASK",
    "commodityName": "CPO",
    "bonus": "120.000",
    "loadDate": "2025-11-11",
    "unloadDate": "2025-11-12",
    "amountSent": "15000",
    "amountReceived": "14800",
    "spb": "",
    "qrcode": ""
  };

  // ======= STYLE ELEMENTS (mengikuti mockup) =========

  Widget _divider() => Container(
    height: 1,
    color: const Color(0xFFE5E5E5),
    margin: const EdgeInsets.symmetric(vertical: 12),
  );

  Widget _label(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 12,
      color: Color(0xFF8A8A8A),
      fontWeight: FontWeight.w600,
    ),
  );

  Widget _value(String text, {Color c = const Color(0xFF002B4C)}) => Text(
    text,
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: c,
    ),
  );

  Widget _section(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Color(0xFF002B4C),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF002B4C),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Detail Riwayat",
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF0B3B54),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.chevron_left, color: Colors.white),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: BlocBuilder<HistoryDetailBloc, HistoryDetailState>(
          bloc: _historyBloc,
          builder: (context, state) {
            Map<String, dynamic> d = Map.from(dummyDetail);

            // HYBRID MODE: API → fallback dummy
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

            if (state is HistoryDetailLoading || state is HistoryDetailInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                /// =======================
                /// HEADER
                /// =======================
                Text(
                  d["doNumber"] ?? "-",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF002B4C),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${safeDate(d["loadDate"])} - ${safeDate(d["unloadDate"])}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8D8D8D),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                _divider(),

                /// QR CODE
                if ((d["qrcode"] ?? "").toString().isNotEmpty)
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FullImageView(image: d["qrcode"])),
                    ),
                    child: Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE5E5E5)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          d["qrcode"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                if ((d["qrcode"] ?? "").toString().isNotEmpty)
                  const SizedBox(height: 20),

                /// =====================
                /// DETAIL FIELDS
                /// =====================
                _label("Sub DO"),
                const SizedBox(height: 4),
                _value(d["subDo"] ?? "-"),
                _divider(),

                _label("Nomor SPB"),
                const SizedBox(height: 4),
                _value(d["spbNumber"] ?? "-"),
                _divider(),

                _label("Pengemudi"),
                const SizedBox(height: 4),
                _value(d["driverName"] ?? "-"),
                _divider(),

                _label("No Kendaraan"),
                const SizedBox(height: 4),
                _value(d["vehicleNumber"] ?? "-"),
                _divider(),

                _label("PKS"),
                const SizedBox(height: 4),
                _value(d["pksName"] ?? "-"),
                _divider(),

                _label("Tujuan Bongkar"),
                const SizedBox(height: 4),
                _value(d["destinationName"] ?? "-"),
                _divider(),

                _label("Produk"),
                const SizedBox(height: 4),
                _value(d["commodityName"] ?? "-"),
                _divider(),

                _label("Bonus"),
                const SizedBox(height: 4),
                _value(
                  d["bonus"] != null && d["bonus"] != ""
                      ? "Rp ${d["bonus"]}"
                      : "-",
                  c:
                  d["bonus"] != null && d["bonus"] != "" ? Colors.green : Colors.black,
                ),

                const SizedBox(height: 20),

                _section("Data Timbang"),
                const SizedBox(height: 20),

                _label("Jumlah Muat"),
                const SizedBox(height: 4),
                _value("${d["amountSent"] ?? '-'} KG"),
                _divider(),

                _label("Jumlah Bongkar"),
                const SizedBox(height: 4),
                _value("${d["amountReceived"] ?? '-'} KG"),
                _divider(),

                _label("Tanggal Muat"),
                const SizedBox(height: 4),
                _value(safeDate(d["loadDate"])),
                _divider(),

                _label("Tanggal Bongkar"),
                const SizedBox(height: 4),
                _value(safeDate(d["unloadDate"])),
                _divider(),

                const SizedBox(height: 20),

                /// ============================
                /// FOTO SPB
                /// ============================
                GestureDetector(
                  onTap: () {
                    if ((d["spb"] ?? "").isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => FullImageView(image: d["spb"])),
                      );
                    }
                  },
                  child: (d["spb"] ?? "").toString().isNotEmpty
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      d["spb"],
                      height: 260,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Container(
                    height: 260,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(child: Text("Tidak ada foto SPB")),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }
}




