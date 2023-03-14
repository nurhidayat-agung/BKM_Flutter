import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/register_workshop/register_workshop_bloc.dart';
import 'package:newbkmmobile/blocs/workshop_history/workshop_history_bloc.dart';
import 'package:newbkmmobile/blocs/workshop_waiting_list/workshop_waiting_list_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/workshop_repository.dart';
import 'package:newbkmmobile/ui/pages/workshop/workshop_history_row.dart';
import 'package:newbkmmobile/ui/pages/workshop/workshop_waiting_list_row.dart';
import 'package:newbkmmobile/ui/widgets/custom_loading.dart';

class WorkshopPage extends StatefulWidget {
  const WorkshopPage({Key? key}) : super(key: key);

  @override
  State<WorkshopPage> createState() => _WorkshopPageState();
}

class _WorkshopPageState extends State<WorkshopPage>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);
  late int _selectedTabbar = 0;
  final _registerWorkshopBloc = RegisterWorkshopBloc(WorkshopRepository());
  final _workshopWaititngListBloc =
      WorkshopWaitingListBloc(WorkshopRepository());
  final _workshopHistoryBloc = WorkshopHistoryBloc(WorkshopRepository());
  final _reasonController = TextEditingController();
  late bool _isFormNotComplete = false;

  @override
  void initState() {
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
                    _reasonController.text = "";
                    _isFormNotComplete = false;
                    setState(() {});
                    showDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (BuildContext ctx) {
                          return registerWorkshopDialog();
                        });
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
                            fontSize: 18.0,
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
              Container(
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.green),
                  onTap: (index) {
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
                              fontSize: 16.0,
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
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  unselectedLabelColor: Colors.green,
                ),
              ),
              const SizedBox(height: 5.0),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    BlocBuilder<WorkshopWaitingListBloc,
                            WorkshopWaitingListState>(
                        bloc: _workshopWaititngListBloc,
                        builder: (context, state) {
                          if (state is WorkshopHistoryInitial) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is WorkshopWaitingListLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is WorkshopWaitingListSuccess) {
                            if (state.listDataHistoryWaitingList.isNotEmpty) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    itemCount:
                                        state.listDataHistoryWaitingList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return WorkshopWaitingListRow(
                                          dataHistoryWaitingList:
                                              state.listDataHistoryWaitingList[
                                                  index]);
                                    }),
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
                          } else if (state is WorkshopWaitingListError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    R.assets.imgNoFeed,
                                    scale: 6.0,
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
                          return const Center(
                              child: CircularProgressIndicator());
                          // throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Text(R.strings.errorWidget)));
                        }),
                    BlocBuilder<WorkshopHistoryBloc, WorkshopHistoryState>(
                        bloc: _workshopHistoryBloc,
                        builder: (context, state) {
                          if (state is WorkshopHistoryInitial) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is WorkshopHistoryLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is WorkshopHistorySuccess) {
                            if (state.listDataHistoryWorkshop.isNotEmpty) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    itemCount:
                                        state.listDataHistoryWorkshop.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return WorkshopHistoryRow(
                                          dataHistoryWorkshop: state
                                              .listDataHistoryWorkshop[index]);
                                    }),
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
                          } else if (state is WorkshopHistoryError) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    R.assets.imgNoFeed,
                                    scale: 6.0,
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
                          return const Center(
                              child: CircularProgressIndicator());
                          // throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Text(R.strings.errorWidget)));
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  StatefulBuilder registerWorkshopDialog() {
    return StatefulBuilder(builder: (context, setNewState) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: SizedBox(
          height: 320.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                Center(
                  child: Text(
                    R.strings.titleFormWorkshop,
                    style: TextStyle(
                      color: R.colors.colorText,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 100.0),
                TextField(
                  controller: _reasonController,
                ),
                const SizedBox(height: 10.0),
                Visibility(
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  visible: _isFormNotComplete,
                  child: Text(
                    R.strings.msgFormNotComplete,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocProvider(
                      create: (context) => _registerWorkshopBloc,
                      child: BlocListener<RegisterWorkshopBloc,
                          RegisterWorkshopState>(
                        listener: (context, state) {
                          if (state is RegisterWorkshopLoading) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomLoading(
                                      message: R.strings.loadingSendData);
                                });
                          } else if (state is RegisterWorkshopSuccess) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                content: Text(
                                    state.registerWorkshopResp.message ?? ""),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text(
                                      R.strings.ok,
                                      style: TextStyle(
                                        color: R.colors.colorPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (state is RegisterWorkshopError) {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                content: Text(state.message ?? ""),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text(
                                      R.strings.ok,
                                      style: TextStyle(
                                        color: R.colors.colorPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: BlocBuilder<RegisterWorkshopBloc,
                            RegisterWorkshopState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: () {
                                if (_reasonController.text.trim().isEmpty) {
                                  setNewState(() {
                                    _isFormNotComplete = true;
                                  });
                                } else {
                                  Navigator.of(context).pop();
                                  _registerWorkshopBloc.add(RegisterWorkshop(reason: _reasonController.text.trim()));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: R.colors.colorPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  R.strings.submit.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: R.colors.colorAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          R.strings.cancel.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
