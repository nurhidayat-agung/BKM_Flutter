import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/history/history_bloc.dart';
import 'package:newbkmmobile/models/trip_history/delivery_detail_history.dart';
import 'package:newbkmmobile/models/trip_history/v2/do_detail_history.dart';
import 'package:newbkmmobile/repositories/history_repository.dart';
import 'package:newbkmmobile/ui/pages/history/history_row.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF002B4C),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Riwayat Pengangkutan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => Navigator.pop(context),
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
        child: BlocProvider(
          create: (context) =>
          HistoryBloc(HistoryRepository())..add(GetHistory()),

          child: BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, state) {
              if (state is HistoryLoading) {
                // Tampilkan loading screen
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<DoDetailHistory> listAll = [];
              if (state is HistorySuccess && state.listHistoryResp.isNotEmpty) {
                listAll = state.listHistoryResp;
              }

              if (listAll.isEmpty) {
                // Kalau data kosong
                return const Center(
                  child: Text(
                    "Tidak ada riwayat pengangkutan.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: listAll.length,
                itemBuilder: (context, i) {
                  return HistoryRow(
                    index: i,
                    historyResp: listAll[i],
                    historyRespBefore: i == 0 ? listAll[i] : listAll[i - 1],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
