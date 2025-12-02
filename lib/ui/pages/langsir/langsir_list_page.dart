import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_bloc.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_event.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_state.dart';
import 'langsir_tambah_page.dart'; // IMPORT KE TAMBAH PAGE

class LangsirListPage extends StatefulWidget {
  const LangsirListPage({super.key});
  @override
  State<LangsirListPage> createState() => _LangsirListPageState();
}

class _LangsirListPageState extends State<LangsirListPage> {
  @override
  void initState() {
    super.initState();
    context.read<LangsirBloc>().add(FetchLangsirList());
  }

  Future<void> _onRefresh() async {
    context.read<LangsirBloc>().add(FetchLangsirList());
  }

  @override
  Widget build(BuildContext context) {
    final Color darkBlue = const Color(0xFF002B4C);
    final Color orangeText = const Color(0xFFD4552F);
    final Color dividerColor = const Color(0xFFEEEEEE);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkBlue,
        centerTitle: true,
        title: const Text(
          'Langsir',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white),
        ),
        leading: Center(
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: BlocConsumer<LangsirBloc, LangsirState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LangsirLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LangsirListLoaded) {
            final items = state.items;

            if (items.isEmpty) {
              return const Center(child: Text('Tidak ada data'));
            }

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: items.length,
                separatorBuilder: (context, index) => Divider(height: 1, color: dividerColor),
                itemBuilder: (context, index) {
                  final item = items[index];

                  final doNumber = (item['do'] ?? item['doNumber'] ?? '051/KAL-EUP/IP-CPO/X/2025').toString();
                  final route = (item['route'] ?? 'SAM1 \u2192 ASK').toString();
                  final commodity = (item['commodity'] ?? 'CPO').toString();
                  final tanggal = (item['tanggal'] ?? '11 Nov 2025').toString();
                  final id = item['id'].toString();

                  return InkWell(
                    // NAVIGASI KE TAMBAH PAGE (Gambar 2)
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return LangsirTambahPage(
                          id: id,
                          // Simulasi data history steps
                          steps: const [
                            {"no": 1, "jumlahMuat": "27000", "jumlahBongkar": "27000", "tanggalMuat": "13 Nov 2025"},
                            {"no": 2, "jumlahMuat": "27000", "jumlahBongkar": "27000", "tanggalMuat": "13 Nov 2025"}
                          ],
                        );
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  doNumber,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: darkBlue,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                tanggal,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: route,
                                  style: TextStyle(
                                    color: orangeText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                                TextSpan(
                                  text: ' | ',
                                  style: TextStyle(
                                    color: orangeText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                                TextSpan(
                                  text: commodity,
                                  style: TextStyle(
                                    color: orangeText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const Center(child: Text('Tidak ada data'));
        },
      ),
    );
  }
}