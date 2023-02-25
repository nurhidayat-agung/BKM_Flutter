import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/replacement_part_history/replacement_part_history_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/service_part_resp.dart';
import 'package:newbkmmobile/repositories/service_part_repository.dart';
import 'package:newbkmmobile/ui/pages/service_part/replacement_part_history_row.dart';
import 'package:newbkmmobile/ui/widgets/pair_horizontal_text.dart';

class ReplacementPartHistoryPage extends StatefulWidget {
  const ReplacementPartHistoryPage({Key? key, required this.dataServicePart}) : super(key: key);
  final DataServicePart dataServicePart;

  @override
  State<ReplacementPartHistoryPage> createState() =>
      _ReplacementPartHistoryPageState();
}

class _ReplacementPartHistoryPageState
    extends State<ReplacementPartHistoryPage> {
  final _replacementPartHistoryBloc =
      ReplacementPartHistoryBloc(ServicePartRepository());

  @override
  void initState() {
    super.initState();
    _replacementPartHistoryBloc
        .add(ReplacementPartHistory(itemId: widget.dataServicePart.id ?? ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleReplacementPartHistoryPage),
      ),
      backgroundColor: Colors.grey[100]!,
      body: SafeArea(
        child: BlocBuilder<ReplacementPartHistoryBloc,
            ReplacementPartHistoryState>(
          bloc: _replacementPartHistoryBloc,
          builder: (context, state) {
            if (state is ReplacementPartHistoryInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReplacementPartHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReplacementPartHistorySuccess) {
              if (state.listDataReplacementPartHistory.isNotEmpty) {
                return Column(
                  children: [
                    const SizedBox(height: 18.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: PairHorizontalText(
                        title: R.strings.namaPart,
                        content: widget.dataServicePart.itemName ?? "",
                        colorTitle: R.colors.colorText,
                        colorContent: R.colors.colorText,
                        fontSizeTitle: 14.0,
                        fontSizeContent: 14.0,
                        fontWeightTitle: FontWeight.normal,
                        fontWeightContent: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: PairHorizontalText(
                        title: R.strings.kodePart,
                        content: widget.dataServicePart.itemCode ?? "",
                        colorTitle: R.colors.colorText,
                        colorContent: R.colors.colorText,
                        fontSizeTitle: 14.0,
                        fontSizeContent: 14.0,
                        fontWeightTitle: FontWeight.normal,
                        fontWeightContent: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    Container(
                      color: Colors.grey[300],
                      height: 1.0,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount:
                              state.listDataReplacementPartHistory.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ReplacementPartHistoryRow(
                              index: index,
                              dataReplacementPartHistory:
                                  state.listDataReplacementPartHistory[index],
                            );
                          }),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    const SizedBox(height: 18.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: PairHorizontalText(
                        title: R.strings.namaPart,
                        content: widget.dataServicePart.itemName ?? "",
                        colorTitle: R.colors.colorText,
                        colorContent: R.colors.colorText,
                        fontSizeTitle: 14.0,
                        fontSizeContent: 14.0,
                        fontWeightTitle: FontWeight.normal,
                        fontWeightContent: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: PairHorizontalText(
                        title: R.strings.kodePart,
                        content: widget.dataServicePart.itemCode ?? "",
                        colorTitle: R.colors.colorText,
                        colorContent: R.colors.colorText,
                        fontSizeTitle: 14.0,
                        fontSizeContent: 14.0,
                        fontWeightTitle: FontWeight.normal,
                        fontWeightContent: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 18.0),
                    Container(
                      color: Colors.grey[300],
                      height: 1.0,
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              R.assets.imgNoFeed,
                              scale: 6.0,
                            ),
                            Text(
                              R.strings.emptyData,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            } else if (state is ReplacementPartHistoryError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50.0,
                    ),
                    Text(
                      state.message,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              );
            }
            throw ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(R.strings.errorWidget)));
          },
        ),
      ),
    );
  }
}
