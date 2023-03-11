import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/register_workshop/register_workshop_bloc.dart';
import 'package:newbkmmobile/blocs/register_workshop/register_workshop_bloc.dart';
import 'package:newbkmmobile/blocs/workshop_history/workshop_history_bloc.dart';
import 'package:newbkmmobile/blocs/workshop_waiting_list/workshop_waiting_list_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/workshop_repository.dart';
import 'package:newbkmmobile/ui/pages/workshop/workshop_history_row.dart';
import 'package:newbkmmobile/ui/pages/workshop/workshop_waiting_list_row.dart';

class WorkshopPageBck extends StatefulWidget {
  const WorkshopPageBck({Key? key}) : super(key: key);

  @override
  State<WorkshopPageBck> createState() => _WorkshopPageBckState();
}

class _WorkshopPageBckState extends State<WorkshopPageBck> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int _selectedTabbar = 0;
  final _registerWorkshopBloc = RegisterWorkshopBloc(WorkshopRepository());
  final _workshopWaititngListBloc = WorkshopWaitingListBloc(WorkshopRepository());
  final _workshopHistoryBloc = WorkshopHistoryBloc(WorkshopRepository());

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _workshopWaititngListBloc.add(WorkshopWaitingList());
    _workshopHistoryBloc.add(WorkshopHistory());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleWorkshopPage),
      ),
      backgroundColor: Colors.grey[100]!,
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<RegisterWorkshopBloc>(
              create: (context) => _registerWorkshopBloc,
            ),
            BlocProvider<WorkshopWaitingListBloc>(
              create: (context) => _workshopWaititngListBloc,
            ),
            BlocProvider<WorkshopHistoryBloc>(
              create: (context) => _workshopHistoryBloc,
            ),
          ],
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: R.colors.greenLogo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          R.strings.daftarPerbaikan.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.green),
                      onTap: (index) {
                        print(index);
                        setState(() {
                          _selectedTabbar = index;
                        });
                      },
                      tabs: [
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.green, width: 1)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                R.strings.antrian,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.green, width: 1)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                R.strings.riwayat,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      unselectedLabelColor: Colors.green,
                    ),

                  ),
                  Builder(builder: (_) {
                    if (_selectedTabbar == 0) {
                      return BlocBuilder<WorkshopWaitingListBloc, WorkshopWaitingListState>(
                          bloc: _workshopWaititngListBloc,
                          builder: (context, state) {
                            if (state is WorkshopHistoryInitial) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is WorkshopWaitingListLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is WorkshopWaitingListSuccess) {
                              if (state.listDataHistoryWaitingList.isNotEmpty) {
                                return ListView.builder(
                                    itemCount: state.listDataHistoryWaitingList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return WorkshopWaitingListRow(dataHistoryWaitingList: state.listDataHistoryWaitingList[index]);
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
                            } else if (state is WorkshopWaitingListError) {
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
                            return const Center(child: CircularProgressIndicator());
                            // throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     content: Text(R.strings.errorWidget)));
                          }
                      );
                    } else {
                      return BlocBuilder<WorkshopHistoryBloc, WorkshopHistoryState>(
                          bloc: _workshopHistoryBloc,
                          builder: (context, state) {
                            if (state is WorkshopHistoryInitial) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is WorkshopHistoryLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is WorkshopHistorySuccess) {
                              if (state.listDataHistoryWorkshop.isNotEmpty) {
                                return ListView.builder(
                                    itemCount: state.listDataHistoryWorkshop.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return WorkshopHistoryRow(dataHistoryWorkshop: state.listDataHistoryWorkshop[index]);
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
                            } else if (state is WorkshopHistoryError) {
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
                            return const Center(child: CircularProgressIndicator());
                            // throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            //     content: Text(R.strings.errorWidget)));
                          }
                      ); //3rd tabView
                    }
                    // throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //     content: Text(R.strings.errorWidget)));

                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
