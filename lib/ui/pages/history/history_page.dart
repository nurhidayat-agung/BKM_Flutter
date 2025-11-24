import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/history/history_bloc.dart';
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
  int selectedTab = 0; // 0 = Normal, 1 = Langsir

  /// Dummy data mockup
  final List<HistoryResp> dummyData = List.generate(
    7,
        (i) => HistoryResp(
      id: "$i",
      doNumber: "051/KAL-EUP/IP-CPO/X/2025",
      pksName: "SAM1",
      destinationName: "ASK",
      commodityName: "CPO",
      loadDate: "2025-11-11",
    ),
  );

  @override
  void initState() {
    super.initState();
    _historyBloc.add(History());
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
        child: BlocBuilder<HistoryBloc, HistoryState>(
          bloc: _historyBloc,
          builder: (context, state) {
            List<HistoryResp> listAll = dummyData;

            if (state is HistorySuccess && state.listHistoryResp.isNotEmpty) {
              listAll = state.listHistoryResp;
            }

            /// filter
            final normalList = listAll.where((e) {
              final txt = "${e.commodityName} ${e.pksName} ${e.destinationName}".toLowerCase();
              return !txt.contains("langsir");
            }).toList();

            final langsirList = listAll.where((e) {
              final txt = "${e.commodityName} ${e.pksName} ${e.destinationName}".toLowerCase();
              return txt.contains("langsir");
            }).toList();

            final activeList = selectedTab == 0 ? normalList : langsirList;

            return Column(
              children: [
                const SizedBox(height: 12),

                /// Tab Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _tabButton("Normal", 0),
                    const SizedBox(width: 10),
                    _tabButton("Langsir", 1),
                  ],
                ),

                const SizedBox(height: 6),

                Expanded(
                  child: ListView.builder(
                    itemCount: activeList.length,
                    itemBuilder: (context, i) {
                      return HistoryRow(
                        index: i,
                        historyResp: activeList[i],
                        historyRespBefore: i == 0 ? activeList[i] : activeList[i - 1],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// ================================
  /// TAB BUTTON EXACT MOCKUP STYLE
  /// ================================
  Widget _tabButton(String title, int index) {
    final selected = (selectedTab == index);

    return InkWell(
      onTap: () => setState(() => selectedTab = index),
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),

        decoration: BoxDecoration(
          color: selected ? const Color(0xFFD4552F) : const Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? const Color(0xFFD4552F) : const Color(0xFFE1E1E1),
            width: 1,
          ),
        ),

        child: Text(
          title,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: selected ? Colors.white : const Color(0xFF8A8A8A),
          ),
        ),
      ),
    );
  }
}
