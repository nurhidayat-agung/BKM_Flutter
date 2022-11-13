import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/history_detail/history_detail_bloc.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/history_repository.dart';
import 'package:newbkmmobile/ui/widgets/full_image_view.dart';

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
                                    builder: (context) =>
                                        FullImageView(image: state.historyDetailResp.qrcode ?? "")
                                ));
                              },
                              child: Image.network(
                                state.historyDetailResp.qrcode ?? "",
                                height: 60.0,
                                width: 60.0,
                                fit: BoxFit.fill,
                                loadingBuilder: (BuildContext context, Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },
                                errorBuilder: (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
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
                        detailHistoryText(R.strings.doKecil, state.historyDetailResp.subDo ?? "", Colors.black),
                        const SizedBox(height: 18.0),
                        detailHistoryText(R.strings.spbNo, state.historyDetailResp.spbNumber ?? "", Colors.black),
                        const SizedBox(height: 18.0),
                        detailHistoryText(R.strings.pengemudi, state.historyDetailResp.driverName ?? "", Colors.black),
                        const SizedBox(height: 18.0),
                        detailHistoryText(R.strings.noKendaraan, state.historyDetailResp.vehicleNumber ?? "", Colors.black),
                        const SizedBox(height: 18.0),
                        detailHistoryText(R.strings.uangJalan, state.historyDetailResp.trvlExpenses ?? "", Colors.black),
                        const SizedBox(height: 18.0),
                        detailHistoryText(R.strings.pks, state.historyDetailResp.pksName ?? "", Colors.black),
                        const SizedBox(height: 18.0),
                        detailHistoryText(R.strings.tujuanBongkar, state.historyDetailResp.destinationName ?? "", Colors.black),
                        const SizedBox(height: 18.0),
                        detailHistoryText(R.strings.produk, state.historyDetailResp.commodityName ?? "", Colors.black),
                        const SizedBox(height: 18.0),
                        detailHistoryText(R.strings.bonus, "+${R.strings.rp}${state.historyDetailResp.bonus}", Colors.green),
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
                        detailHistoryText(R.strings.jmlMuat, "${state.historyDetailResp.amountSent} ${R.strings.kg}", R.colors.colorText),
                        const SizedBox(height: 18.0),
                        detailHistoryText(R.strings.jmlBongkar, "${state.historyDetailResp.amountReceived} ${R.strings.kg}" , R.colors.colorText),
                        const SizedBox(height: 18.0),
                        detailHistoryText(R.strings.tglMuat, state.historyDetailResp.loadDate ?? "", R.colors.colorText),
                        const SizedBox(height: 18.0),
                        detailHistoryText(R.strings.tglBongkar, state.historyDetailResp.unloadDate ?? "", R.colors.colorText),
                        const SizedBox(height: 18.0),
                        Container(
                          color: Colors.grey[300],
                          height: 4.0,
                        ),
                        const SizedBox(height: 18.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    FullImageView(image: state.historyDetailResp.spb ?? "")
                            ));
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
                            errorBuilder: (BuildContext context, Object exception,
                                StackTrace? stackTrace) {
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
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message)));
          }
          throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(R.strings.errorWidget)));
        },
      ),
    );
  }

  Row detailHistoryText(String title, String content, Color colorContent) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: R.colors.colorText,
              fontSize: 14.0,
            ),
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              color: colorContent,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
