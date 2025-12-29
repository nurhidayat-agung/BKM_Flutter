import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/service_part/service_part_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/legacy/service_part_resp.dart';
import 'package:newbkmmobile/repositories/service_part_repository.dart';
import 'package:newbkmmobile/ui/pages/service_part/service_part_row.dart';

class ServicePartPage extends StatefulWidget {
  const ServicePartPage({Key? key}) : super(key: key);

  @override
  State<ServicePartPage> createState() => _ServicePartPageState();
}

class _ServicePartPageState extends State<ServicePartPage> {
  final _servicePartBloc                    = ServicePartBloc(ServicePartRepository());
  List<DataServicePart> listDataServicePart = [];

  @override
  void initState() {
    super.initState();
    _servicePartBloc.add(ServicePart());
  }

  _runFilter(String enteredKeyword) {
    List<DataServicePart> tempList = [];
    if (enteredKeyword.isEmpty) {
      tempList = listDataServicePart;
    } else {
      tempList = listDataServicePart
          .where((u) =>
          u.itemName!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    _servicePartBloc.add(FilterServicePart(listDataServicePart: tempList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleServicePartPage),
      ),
      backgroundColor: Colors.grey[100]!,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => _servicePartBloc,
          child: BlocListener<ServicePartBloc, ServicePartState>(
            listener: (context, state) {
              if (state is FilterServicePartSuccess) {}
            },
            child: BlocBuilder<ServicePartBloc, ServicePartState>(
              bloc: _servicePartBloc,
              builder: (context, state) {
                if (state is ServicePartInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ServicePartLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ServicePartSuccess) {
                  if (state.listDataServicePart.isNotEmpty) {
                    listDataServicePart = state.listDataServicePart;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(15.0),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: R.colors.greenLogo,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: R.colors.greenLogo,
                                  ),
                                ),
                                hintText: R.strings.cariNamaPart,
                                suffixIcon: const Icon(Icons.search)
                            ),
                            onChanged: (value) {
                              _runFilter(value);
                            },
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: listDataServicePart.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ServicePartRow(
                                  index: index,
                                  dataServicePart: listDataServicePart[index],
                                );
                              }),
                        ),
                      ],
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
                } else if (state is FilterServicePartSuccess) {
                  return Column(
                    children: [
                      const SizedBox(height: 8.0),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15.0),
                            hintText: R.strings.cariNamaPart,
                            suffixIcon: const Icon(Icons.search)
                        ),
                        onChanged: (value) {
                          _runFilter(value);
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.listDataServicePart.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ServicePartRow(
                                index: index,
                                dataServicePart: state.listDataServicePart[index],
                              );
                            }),
                      ),
                    ],
                  );
                } else if (state is ServicePartError) {
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
                    .showSnackBar(
                    SnackBar(content: Text(R.strings.errorWidget)));
              },
            ),
          ),
        ),
      ),
    );
  }
}
