import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/user_detail/user_detail_bloc.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';

class PresensiRealTimePage extends StatefulWidget {
  const PresensiRealTimePage({super.key});

  @override
  State<PresensiRealTimePage> createState() => _PresensiRealTimePageState();
}

class _PresensiRealTimePageState extends State<PresensiRealTimePage> {
  late UserDetailBloc _userDetailBloc;

  @override
  void initState() {
    super.initState();
    _userDetailBloc = UserDetailBloc(UserDetailRepository());
    _userDetailBloc.add(UserDetailFetch());
  }

  @override
  void dispose() {
    _userDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Presensi Real Time"),
        backgroundColor: Colors.orangeAccent,
        elevation: 0,
      ),
      body: BlocBuilder<UserDetailBloc, UserDetailState>(
        bloc: _userDetailBloc,
        builder: (context, state) {
          if (state is UserDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserDetailError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          } else if (state is UserDetailSuccess) {
            final user = state.userDetail;

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nama: ${user.fullName ?? '-'}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Driver ID: ${user.driverId ?? '-'}"),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Presensi berhasil!"), backgroundColor: Colors.green),
                        );
                        Future.delayed(const Duration(milliseconds: 800), () {
                          Navigator.pop(context, true); // ✅ balik ke HomePage
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.fingerprint),
                      label: const Text("Ambil Presensi", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text("Data user belum dimuat"));
        },
      ),
    );
  }
}
