import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/history/history_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/history_resp.dart';
import 'package:newbkmmobile/repositories/history_repository.dart';
import 'package:newbkmmobile/ui/pages/history/history_row.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _historyBloc = HistoryBloc(HistoryRepository());

  @override
  void initState() {
    super.initState();
    _historyBloc.add(History());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar:
      AppBar(
        backgroundColor: const Color(0xFF002B4C),
        elevation: 0,
        centerTitle: true,
        title: const Text("Riwayat Pengankutan",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0B3B54),
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.all(8),
              child: const Icon(Icons.chevron_left, color: Colors.white),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HistoryBloc, HistoryState>(
          bloc: _historyBloc,
          builder: (context, state) {
            if (state is HistoryInitial || state is HistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistorySuccess) {
              if (state.listHistoryResp.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(R.assets.imgNoFeed, scale: 6.0),
                      const SizedBox(height: 12),
                      Text(
                        R.strings.emptyData,
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ],
                  ),
                );
              }

              // main list
              return ListView.builder(
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                itemCount: state.listHistoryResp.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return HistoryRow(
                      index: index,
                      historyResp: state.listHistoryResp[index],
                      historyRespBefore: HistoryResp(
                        id: "",
                        doConnect: null,
                        doNumber: "",
                        subDo: "",
                        spbNumber: "",
                        loadDate: "",
                        unloadDate: "",
                        driverId: "",
                        pksName: "",
                        destinationName: "",
                        commodityName: "",
                        bonus: "",
                      ),
                    );
                  } else {
                    return HistoryRow(
                      index: index,
                      historyResp: state.listHistoryResp[index],
                      historyRespBefore: state.listHistoryResp[index - 1],
                    );
                  }
                },
              );
            } else if (state is HistoryError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 50.0),
                    const SizedBox(height: 8),
                    Text(state.message, style: const TextStyle(fontSize: 14.0)),
                  ],
                ),
              );
            }

            // fallback
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(R.strings.errorWidget)),
              );
            });
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
