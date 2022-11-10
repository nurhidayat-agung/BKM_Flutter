import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/history/history_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
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
    _historyBloc.add(History());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.menuHistory),
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
              if (state.listHistory.isNotEmpty) {
                return ListView.builder(
                    itemCount: state.listHistory.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HistoryRow(history: state.listHistory[index]);
                    }
                );
              } else {
                return Center(child: Text(R.strings.emptyData));
              }
            } else if (state is HistoryError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message)));
            }
            throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(R.strings.errorWidget)));
          },
        ),
      ),
    );
  }
}
