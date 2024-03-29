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
      appBar: AppBar(
        title: Text(R.strings.titleHistoryPage),
      ),
      backgroundColor: Colors.grey[100]!,
      body: SafeArea(
        child: BlocBuilder<HistoryBloc, HistoryState>(
          bloc: _historyBloc,
          builder: (context, state) {
            if (state is HistoryInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HistorySuccess) {
              if (state.listHistoryResp.isNotEmpty) {
                return ListView.builder(
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
                          historyRespBefore: state.listHistoryResp[index-1],
                        );
                      }
                    }
                );
              } else {
                return Center(
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
                );
              }
            } else if (state is HistoryError) {
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
            throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(R.strings.errorWidget)));
          },
        ),
      ),
    );
  }
}
