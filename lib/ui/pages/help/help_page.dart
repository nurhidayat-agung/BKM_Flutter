import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/help/help_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/help_repository.dart';
import 'package:newbkmmobile/ui/pages/help/help_row.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final _helpBloc = HelpBloc(HelpRepository());

  @override
  void initState() {
    super.initState();
    _helpBloc.add(Help());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleHelpPage),
      ),
      backgroundColor: Colors.grey[100]!,
      body: SafeArea(
        child: BlocBuilder<HelpBloc, HelpState>(
          bloc: _helpBloc,
          builder: (context, state) {
            if (state is HelpInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HelpLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HelpSuccess) {
              if (state.listHelpResp.isNotEmpty) {
                return ListView.builder(
                    itemCount: state.listHelpResp.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HelpRow(
                        index: index,
                        helpResp: state.listHelpResp[index],
                      );
                    });
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
            } else if (state is HelpError) {
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
