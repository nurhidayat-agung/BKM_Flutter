import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/service_book/service_book_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/service_book_repository.dart';
import 'package:newbkmmobile/ui/pages/service_book/service_book_row.dart';

class ServiceBookPage extends StatefulWidget {
  const ServiceBookPage({Key? key}) : super(key: key);

  @override
  State<ServiceBookPage> createState() => _ServiceBookPageState();
}

class _ServiceBookPageState extends State<ServiceBookPage> {
  final _serviceBookBloc = ServiceBookBloc(ServiceBookRepository());

  @override
  void initState() {
    super.initState();
    _serviceBookBloc.add(ServiceBook());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleServiceBookPage),
      ),
      backgroundColor: Colors.grey[100]!,
      body: SafeArea(
        child: BlocBuilder<ServiceBookBloc, ServiceBookState>(
          bloc: _serviceBookBloc,
          builder: (context, state) {
            if (state is ServiceBookInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ServiceBookLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ServiceBookSuccess) {
              if (state.listDataServiceBook.isNotEmpty) {
                return ListView.builder(
                    itemCount: state.listDataServiceBook.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ServiceBookRow(
                          index: index,
                          dataServiceBook: state.listDataServiceBook[index],
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
            } else if (state is ServiceBookError) {
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
                .showSnackBar(SnackBar(content: Text(R.strings.errorWidget)));
          },
        ),
      ),
    );
  }
}
