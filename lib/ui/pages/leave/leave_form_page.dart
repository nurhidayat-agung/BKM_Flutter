import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newbkmmobile/blocs/leave/leave_bloc.dart';
import 'package:newbkmmobile/blocs/leave/leave_event.dart';
import 'package:newbkmmobile/blocs/leave/leave_state.dart';
import 'package:newbkmmobile/repositories/leave_repository.dart';

class LeaveFormPage extends StatefulWidget {
  const LeaveFormPage({super.key});

  @override
  State<LeaveFormPage> createState() => _LeaveFormPageState();
}

class _LeaveFormPageState extends State<LeaveFormPage> {
  final _startDateController = TextEditingController(text: "24 Nov 2025");
  final _endDateController = TextEditingController(text: "26 Nov 2025");
  final _reasonController = TextEditingController();

  final _leaveBloc = LeaveBloc(LeaveRepository());

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2028),
    );

    if (picked != null) {
      // Format tanggal manual atau gunakan DateFormat dari package intl
      const List<String> months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
        'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
      ];
      controller.text = "${picked.day} ${months[picked.month - 1]} ${picked.year}";
    }
  }

  void _submitLeave() {
    if (_startDateController.text.isEmpty ||
        _endDateController.text.isEmpty ||
        _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua field harus diisi!"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    _leaveBloc.add(
      SubmitLeave(
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        reason: _reasonController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF002B4C);
    const orange = Color(0xFFD4552F);

    return Scaffold(
      backgroundColor: Colors.white,
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
                color: const Color(0xFF2C4A64),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            ),
          ),
        ),
      ),
      body: BlocProvider<LeaveBloc>(
        create: (context) => _leaveBloc,
        child: BlocConsumer<LeaveBloc, LeaveState>(
          listener: (context, state) {
            if (state is LeaveSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.green),
              );

              // ============================================
              // KUNCI PERUBAHAN: KIRIM DATA BALIK KE LIST
              // ============================================
              // buat simulasi data baru berdasarkan inputan
              final newItem = {
                "title": "Cuti Tahunan", // Default title, atau bisa diambil dari dropdown tipe cuti jika ada
                "dateApplied": DateFormat('dd MMM yyyy').format(DateTime.now()), // Tanggal hari ini Tidak perlu input tangal manual
                "startDate": _startDateController.text,
                "endDate": _endDateController.text,
                "status": "Menunggu", // Status default pengajuan baru
                "statusColor": Colors.blue,
                "textColor": Colors.white,
              };

              // Kembali ke halaman list dengan membawa data
              Navigator.pop(context, newItem);

            } else if (state is LeaveFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error.replaceAll("Exception: ", "")),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is LeaveLoading;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Tanggal Mulai", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: darkBlue)),
                  const SizedBox(height: 8),
                  _buildDateField(_startDateController),
                  const SizedBox(height: 16),

                  const Text("Tanggal Berakhir", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: darkBlue)),
                  const SizedBox(height: 8),
                  _buildDateField(_endDateController),
                  const SizedBox(height: 16),

                  const Text("Alasan Cuti", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: darkBlue)),
                  const SizedBox(height: 8),
                  _buildReasonField(),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitLeave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text("Ajukan Cuti", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDateField(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(controller),
      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF002B4C), fontSize: 14),
      decoration: InputDecoration(
        hintText: "Pilih Tanggal",
        suffixIcon: const Icon(Icons.calendar_today_outlined, color: Color(0xFFD4552F), size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFD4552F))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildReasonField() {
    return TextFormField(
      controller: _reasonController,
      maxLines: 5,
      style: const TextStyle(fontWeight: FontWeight.normal, color: Color(0xFF002B4C), fontSize: 14),
      decoration: InputDecoration(
        hintText: "Masukkan alasan pengajuan cuti...",
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE0E0E0))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFD4552F))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}