import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/trip/trip_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/trip_repository.dart';
import 'package:newbkmmobile/ui/pages/trip/trip_detail_page.dart';
import 'package:newbkmmobile/ui/pages/trip/trip_row.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key? key}) : super(key: key);

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  final _tripBloc = TripBloc(TripRepository());

  @override
  void initState() {
    super.initState();
    _tripBloc.add(Trip());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleTripPage),
      ),
      backgroundColor: Colors.grey[100]!,
      body: SafeArea(
        child: BlocBuilder<TripBloc, TripState>(
          bloc: _tripBloc,
          builder: (context, state) {
            if (state is TripInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TripLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TripSuccess) {
              if (state.listTripResp.isNotEmpty) {
                return ListView.builder(
                    itemCount: state.listTripResp.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  TripDetailPage(id: state.listTripResp[index].id ?? "")
                          )).then((value) => setState(() {
                            _tripBloc.add(Trip());
                          }));
                        },
                        child: TripRow(tripResp: state.listTripResp[index]),
                      );
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
            } else if (state is TripError) {
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
