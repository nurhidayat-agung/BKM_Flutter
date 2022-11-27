import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/history_detail/history_detail_bloc.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/history_repository.dart';
import 'package:newbkmmobile/ui/widgets/full_image_view.dart';
import 'package:newbkmmobile/ui/widgets/pair_horizontal_text.dart';

class HistoryDetailPage extends StatefulWidget {
  const HistoryDetailPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<HistoryDetailPage> createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  final _historyDetailBloc = HistoryDetailBloc(HistoryRepository());

  @override
  void initState() {
    super.initState();
    _historyDetailBloc.add(HistoryDetail(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    final convertDate = ConvertDate();

    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleHistoryDetailPage),
      ),
      body: BlocBuilder<HistoryDetailBloc, HistoryDetailState>(
        bloc: _historyDetailBloc,
        builder: (context, state) {
          if (state is HistoryDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryDetailSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${R.strings.nomorDo} :",
                              style: TextStyle(
                                color: R.colors.colorTextLight,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              state.historyDetailResp.doNumber ?? "",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Text(
                              "${convertDate.convertToddMMMyyyy2(state.historyDetailResp.loadDate!)} - ${convertDate.convertToddMMMyyyy2(state.historyDetailResp.unloadDate!)}",
                              style: TextStyle(
                                color: R.colors.colorTextLight,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FullImageView(
                                        image: state.historyDetailResp.qrcode ??
                                            "")));
                              },
                              child: Image.network(
                                state.historyDetailResp.qrcode ?? "",
                                height: 55.0,
                                width: 55.0,
                                fit: BoxFit.fill,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Container(
                                    color: Colors.transparent,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey[300],
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 10.0,
                      right: 8.0,
                    ),
                    child: Column(
                      children: [
                        PairHorizontalText(
                            title: R.strings.doKecil,
                            content: state.historyDetailResp.subDo ?? "",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                            title: R.strings.spbNo,
                            content: state.historyDetailResp.spbNumber ?? "",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                            title: R.strings.pengemudi,
                            content: state.historyDetailResp.driverName ?? "",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                            title: R.strings.noKendaraan,
                            content:
                                state.historyDetailResp.vehicleNumber ?? "",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                            title: R.strings.uangJalan,
                            content: state.historyDetailResp.trvlExpenses ?? "",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                            title: R.strings.pks,
                            content: state.historyDetailResp.pksName ?? "",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                            title: R.strings.tujuanBongkar,
                            content:
                                state.historyDetailResp.destinationName ?? "",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                            title: R.strings.produk,
                            content:
                                state.historyDetailResp.commodityName ?? "",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.black,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                            title: R.strings.bonus,
                            content:
                                "+${R.strings.rp}. ${state.historyDetailResp.bonus}",
                            colorTitle: R.colors.colorText,
                            colorContent: Colors.green,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    color: R.colors.colorPrimary,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        R.strings.titleDataTimbang,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.historyDetailResp.doNumber ?? "",
                          style: TextStyle(
                            color: R.colors.colorText,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                            title: R.strings.jmlMuat,
                            content:
                                "${state.historyDetailResp.amountSent} ${R.strings.kg}",
                            colorTitle: R.colors.colorText,
                            colorContent: R.colors.colorText,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                            title: R.strings.jmlBongkar,
                            content:
                                "${state.historyDetailResp.amountReceived} ${R.strings.kg}",
                            colorTitle: R.colors.colorText,
                            colorContent: R.colors.colorText,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                            title: R.strings.tglMuat,
                            content: state.historyDetailResp.loadDate ?? "",
                            colorTitle: R.colors.colorText,
                            colorContent: R.colors.colorText,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                            title: R.strings.tglBongkar,
                            content: state.historyDetailResp.unloadDate ?? "",
                            colorTitle: R.colors.colorText,
                            colorContent: R.colors.colorText,
                            fontSizeTitle: 14.0,
                            fontSizeContent: 14.0,
                            fontWeightTitle: FontWeight.normal,
                            fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        Container(
                          color: Colors.grey[300],
                          height: 4.0,
                        ),
                        const SizedBox(height: 18.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => FullImageView(
                                    image: state.historyDetailResp.spb ?? "")));
                          },
                          child: Image.network(
                            state.historyDetailResp.spb ?? "",
                            height: 200.0,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Container(
                                color: Colors.transparent,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 18.0),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (state is HistoryDetailError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          throw ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(R.strings.errorWidget)));
        },
      ),
    );
  }
}
