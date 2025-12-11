import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/leave/leave_bloc.dart';
import 'package:newbkmmobile/blocs/leave/leave_event.dart';
import 'package:newbkmmobile/blocs/leave/leave_state.dart';
import 'package:newbkmmobile/models/leave/leave_list_response.dart';
import 'package:newbkmmobile/repositories/leave_repository.dart';
import 'package:newbkmmobile/ui/pages/leave/leave_detail_page.dart';
import 'package:newbkmmobile/ui/pages/leave/leave_form_page.dart';

class LeaveApplicationPageWrapper extends StatelessWidget {
  const LeaveApplicationPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LeaveBloc(LeaveRepository()),
      child: const LeaveApplicationPage(),
    );
  }
}


class LeaveApplicationPage extends StatefulWidget {
  const LeaveApplicationPage({super.key});

  @override
  State<LeaveApplicationPage> createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  @override
  void initState() {
    super.initState();
    context.read<LeaveBloc>().add(const GetListLeave());
  }

  Future<void> _navigateToAddForm() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LeaveFormPage()),
    );

    // Jika submit berhasil, refresh list
    if (result == true) {
      context.read<LeaveBloc>().add(const GetListLeave());
    }
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF002B4C);
    const orange = Color(0xFFD4552F);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Pengajuan Cuti",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
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
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          // Tombol Tambah
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _navigateToAddForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  "Tambah",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // BLoC STATE
          Expanded(
            child: BlocBuilder<LeaveBloc, LeaveState>(
              builder: (context, state) {
                if (state is LeaveLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is LeaveFailure) {
                  return Center(
                    child: Text(
                      state.error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state is GetListLeaveSuccess) {
                  return _buildList(state.response);
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(LeaveListResponse data) {
    if (data.data == null || data.data!.isEmpty) {
      return const Center(
        child: Text(
          "Belum ada pengajuan cuti.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: data.data!.length,
      itemBuilder: (context, index) {
        LeaveData item = data.data![index];

        return GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LeaveFormPage(existingData: item),
              ),
            );

            if (result == true) {
              context.read<LeaveBloc>().add(const GetListLeave());
            }
          },
          child: _buildLeaveCard(item),
        );
      },
    );
  }

  Color hexToColor(String? hex, {Color defaultColor = const Color(0xFF0A3D62)}) {
    try {
      if (hex == null || hex.isEmpty) return defaultColor;

      hex = hex.replaceAll('#', '');
      if (hex.length == 6) {
        hex = 'FF$hex'; // Tambah opacity
      }

      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return defaultColor; // fallback kalau parsing gagal
    }
  }



  Widget _buildLeaveCard(LeaveData item) {
    Color statusColor = Colors.grey;
    String statusText = item.status?.name ?? "-";

    switch (item.status?.name?.toLowerCase()) {
      case "approved":
        statusColor = const Color(0xFF4CAF50);
        break;
      case "pending":
        statusColor = const Color(0xFFFDD835);
        break;
      case "rejected":
        statusColor = const Color(0xFFE53935);
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tgl Pengajuan : ${item.createdAt ?? '-'}",
            style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.leaveType?.name ?? "-",
                style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF002B4C),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: hexToColor(item.status?.colorHex ?? ""),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Tgl Dimulai", style: TextStyle(fontSize: 11, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(
                      item.startDate ?? "-",
                      style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF002B4C),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Tgl Berakhir", style: TextStyle(fontSize: 11, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(
                      item.endDate ?? "-",
                      style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF002B4C),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
