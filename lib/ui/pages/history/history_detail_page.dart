import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/history_detail/history_detail_bloc.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/history_repository.dart';
import 'package:newbkmmobile/ui/widgets/full_image_view.dart';
import 'package:newbkmmobile/ui/widgets/space_between_horizontal_text.dart';

class HistoryDetailPage extends StatefulWidget {
  const HistoryDetailPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  final _historyDetailBloc = HistoryDetailBloc(HistoryRepository());
  final convertDate = ConvertDate();

  @override
  void initState() {
    super.initState();
    _historyDetailBloc.add(HistoryDetail(id: widget.id));
  }

  Widget _sectionTitle(String title) {
    return Container(
      width: double.infinity,
      color: R.colors.colorPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleHistoryDetailPage),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: BlocBuilder<HistoryDetailBloc, HistoryDetailState>(
          bloc: _historyDetailBloc,
          builder: (context, state) {
            if (state is HistoryDetailInitial || state is HistoryDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistoryDetailSuccess) {
              final d = state.historyDetailResp;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // header card (left details + QR right)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${R.strings.nomorDo} :",
                                      style: TextStyle(
                                        color: R.colors.colorTextLight,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      d.doNumber ?? "-",
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "${convertDate.convertToddMMMyyyy2(d.loadDate ?? '')} - ${convertDate.convertToddMMMyyyy2(d.unloadDate ?? '')}",
                                      style: TextStyle(color: R.colors.colorTextLight, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => FullImageView(image: d.qrcode ?? ""),
                                  ));
                                },
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: d.qrcode != null && d.qrcode!.isNotEmpty
                                      ? Image.network(
                                    d.qrcode!,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return const Center(child: CircularProgressIndicator());
                                    },
                                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                                  )
                                      : const SizedBox.shrink(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // thin divider
                    Container(height: 4, color: Colors.grey[200]),

                    // basic info list
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                      child: Column(
                        children: [
                          SpaceBetweenHorizontalText(
                            title: R.strings.doKecil,
                            content: d.subDo ?? "-",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),
                          const SizedBox(height: 12),
                          SpaceBetweenHorizontalText(
                            title: R.strings.spbNo,
                            content: d.spbNumber ?? "-",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),
                          const SizedBox(height: 12),
                          SpaceBetweenHorizontalText(
                            title: R.strings.pengemudi,
                            content: d.driverName ?? "-",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),
                          const SizedBox(height: 12),
                          SpaceBetweenHorizontalText(
                            title: R.strings.noKendaraan,
                            content: d.vehicleNumber ?? "-",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),
                          const SizedBox(height: 12),
                          SpaceBetweenHorizontalText(
                            title: R.strings.uangJalan,
                            content: d.trvlExpenses ?? "-",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),
                          const SizedBox(height: 12),
                          SpaceBetweenHorizontalText(
                            title: R.strings.pks,
                            content: d.pksName ?? "-",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),
                          const SizedBox(height: 12),
                          SpaceBetweenHorizontalText(
                            title: R.strings.tujuanBongkar,
                            content: d.destinationName ?? "-",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),
                          const SizedBox(height: 12),
                          SpaceBetweenHorizontalText(
                            title: R.strings.produk,
                            content: d.commodityName ?? "-",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),
                          const SizedBox(height: 12),
                          SpaceBetweenHorizontalText(
                            title: R.strings.bonus,
                            content: d.bonus != null && d.bonus!.isNotEmpty ? "+${R.strings.rp}. ${d.bonus}" : "-",
                            colorTitle: R.colors.colorText,
                            colorContent: d.bonus != null && d.bonus!.isNotEmpty ? Colors.green : Colors.black,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Data Timbang (MUAT/BONGKAR)
                    _sectionTitle(R.strings.titleDataTimbang),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.doNumber ?? "-",
                            style: TextStyle(
                              color: R.colors.colorText,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SpaceBetweenHorizontalText(
                            title: R.strings.jmlMuat,
                            content: "${d.amountSent ?? '-'} ${R.strings.kg}",
                            colorTitle: R.colors.colorText,
                            colorContent: R.colors.colorText,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),
                          const SizedBox(height: 10),
                          SpaceBetweenHorizontalText(
                            title: R.strings.jmlBongkar,
                            content: "${d.amountReceived ?? '-'} ${R.strings.kg}",
                            colorTitle: R.colors.colorText,
                            colorContent: R.colors.colorText,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),
                          const SizedBox(height: 10),
                          SpaceBetweenHorizontalText(
                            title: R.strings.tglMuat,
                            content: d.loadDate ?? "-",
                            colorTitle: R.colors.colorText,
                            colorContent: R.colors.colorText,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),
                          const SizedBox(height: 10),
                          SpaceBetweenHorizontalText(
                            title: R.strings.tglBongkar,
                            content: d.unloadDate ?? "-",
                            colorTitle: R.colors.colorText,
                            colorContent: R.colors.colorText,
                            fontSizeTitle: 14,
                            fontSizeContent: 14,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                          ),

                          const SizedBox(height: 12),
                          Container(color: Colors.grey[200], height: 4),
                          const SizedBox(height: 12),

                          // SPB image preview (muat)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => FullImageView(image: d.spb ?? ""),
                              ));
                            },
                            child: d.spb != null && d.spb!.isNotEmpty
                                ? Image.network(
                              d.spb!,
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return const SizedBox(
                                    height: 220, child: Center(child: CircularProgressIndicator()));
                              },
                              errorBuilder: (_, __, ___) => Container(
                                height: 220,
                                color: Colors.grey[100],
                                child: const Center(child: Icon(Icons.broken_image)),
                              ),
                            )
                                : Container(
                              height: 220,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(child: Text("Tidak ada foto SPB")),
                            ),
                          ),
                          const SizedBox(height: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is HistoryDetailError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 50),
                    const SizedBox(height: 8),
                    Text(state.message, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              );
            }

            // fallback
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(R.strings.errorWidget)));
            });
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
