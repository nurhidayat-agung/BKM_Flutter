import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/trip/trip_bloc.dart';
import 'package:newbkmmobile/repositories/trip_repository.dart';
import 'package:newbkmmobile/ui/pages/trip/trip_page.dart';
import 'package:newbkmmobile/models/trip/list_new_do_response.dart';

class TripListPage extends StatefulWidget {
  const TripListPage({Key? key}) : super(key: key);

  @override
  State<TripListPage> createState() => _TripListPageState();
}

class _TripListPageState extends State<TripListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: AppBar(
          backgroundColor: const Color(0xFF002B4C),
          elevation: 0,
          centerTitle: true,
          title: const Text("Daftar Pengangkutan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0B3B54),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.all(8),
                child: const Icon(Icons.chevron_left, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      // BLoC minta GetTripList()
      body: BlocProvider(
        create: (_) => TripBloc(TripRepository())..add(GetTripList()),
        child: BlocBuilder<TripBloc, TripState>(
          builder: (context, state) {
            if (state is TripLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TripError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.inbox_outlined, size: 60, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(state.message, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF002B4C)),
                      onPressed: () => context.read<TripBloc>().add(GetTripList()),
                      child: const Text("Muat Ulang", style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              );
            }

            if (state is TripListLoaded) {
              final listTrip = state.tripList;

              if (listTrip.isEmpty) {
                return const Center(
                  child: Text("Belum ada antrean DO baru", style: TextStyle(fontSize: 16)),
                );
              }

              return RefreshIndicator(
                color: const Color(0xFFD35400),
                onRefresh: () async {
                  context.read<TripBloc>().add(GetTripList());
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: listTrip.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.black12),
                  itemBuilder: (context, index) {
                    final item = listTrip[index];

                    // Tarik data dari JSON untuk ditampilkan di List
                    final doBesar = item.deliveryOrder?.doNumber ?? "Tanpa DO";
                    final statusPesan = item.status?.name ?? "Diproses";
                    final komoditi = item.note ?? "-";

                    // Ambil format tanggal "YYYY-MM-DD"
                    String tanggal = "-";
                    if (item.createdAt != null && item.createdAt!.length >= 10) {
                      tanggal = item.createdAt!.substring(0, 10);
                    }

                    return InkWell(
                      onTap: () {
                        // 👉 MENGIRIM DATA KE TRIP PAGE SAAT DIKLIK
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TripPage(deliveryData: item),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doBesar,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF002B4C),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "Status: $statusPesan | $komoditi",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFD35400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              tanggal,
                              style: const TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}