import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newbkmmobile/blocs/leave/leave_bloc.dart';
import 'package:newbkmmobile/blocs/leave/leave_event.dart';
import 'package:newbkmmobile/blocs/leave/leave_state.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/repositories/leave_repository.dart';

class LeaveFormPage extends StatefulWidget {
  const LeaveFormPage({super.key});

  @override
  State<LeaveFormPage> createState() => _LeaveFormPageState();
}

class _LeaveFormPageState extends State<LeaveFormPage> {
  // Controller dikosongkan agar Hint Text muncul ("Pilih tanggal...")
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _reasonController = TextEditingController();

  // Variabel untuk Dropdown Tipe Cuti
  String? _selectedLeaveType;
  final List<String> _leaveTypes = Constants.leaveTypeMap.keys.toList();

  // Variabel untuk menyimpan tanggal asli (DateTime)
  DateTime? _rawStartDate;
  DateTime? _rawEndDate;

  final _leaveBloc = LeaveBloc(LeaveRepository());

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2028),
    );

    if (picked != null) {
      // Format Tampilan: 24 Nov 2025
      const List<String> months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
        'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
      ];
      controller.text = "${picked.day} ${months[picked.month - 1]} ${picked.year}";

      // Simpan data mentah
      if (isStart) {
        _rawStartDate = picked;
      } else {
        _rawEndDate = picked;
      }
    }
  }

  void _submitLeave() {
    // Validasi sederhana
    if (_selectedLeaveType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih jenis cuti terlebih dahulu!"), backgroundColor: Colors.orange),
      );
      return;
    }
    if (_startDateController.text.isEmpty ||
        _endDateController.text.isEmpty ||
        _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field harus diisi!"), backgroundColor: Colors.orange),
      );
      return;
    }

    // Format tanggal untuk API (YYYY-MM-DD)
    String apiStartDate = _rawStartDate != null
        ? DateFormat('yyyy-MM-dd').format(_rawStartDate!)
        : _startDateController.text;

    String apiEndDate = _rawEndDate != null
        ? DateFormat('yyyy-MM-dd').format(_rawEndDate!)
        : _endDateController.text;

    _leaveBloc.add(
      SubmitLeave(
        leaveType: _selectedLeaveType ?? "",
        startDate: apiStartDate,
        endDate: apiEndDate,
        reason: _reasonController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF002B4C);
    const orange = Color(0xFFD4552F);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8), // Background Abu-abu muda
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
      body: BlocProvider<LeaveBloc>(
        create: (context) => _leaveBloc,
        child: BlocConsumer<LeaveBloc, LeaveState>(
          listener: (context, state) {
            if (state is LeaveSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.green),
              );

              // Kirim data dummy balik ke list agar terupdate realtime
              final newItem = {
                "title": _selectedLeaveType,
                "dateApplied": DateFormat('dd MMM yyyy').format(DateTime.now()),
                "startDate": _startDateController.text,
                "endDate": _endDateController.text,
                "status": "Menunggu",
                "statusColor": Colors.blue,
                "textColor": Colors.white,
                "reason": _reasonController.text,
              };
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
                children: [
                  // === CONTAINER PUTIH (FORM) ===
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dropdown Jenis Cuti
                        DropdownButtonFormField<String>(
                          value: _selectedLeaveType,
                          decoration: _inputDecoration("Pilih jenis cuti ..."),
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                          items: _leaveTypes.map((String type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type, style: const TextStyle(fontSize: 14)),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              _selectedLeaveType = newValue;
                            });
                          },
                        ),
                        const SizedBox(height: 20),

                        // TANGGAL MULAI
                        const Text("Tanggal Mulai", style: TextStyle(fontSize: 13, color: Colors.black54)),
                        const SizedBox(height: 6),
                        _buildDateField(_startDateController, "Pilih tanggal mulai", true),

                        const SizedBox(height: 20),

                        // TANGGAL BERAKHIR
                        const Text("Tanggal Berakhir", style: TextStyle(fontSize: 13, color: Colors.black54)),
                        const SizedBox(height: 6),
                        _buildDateField(_endDateController, "Pilih tanggal berakhir", false),

                        const SizedBox(height: 20),

                        // ALASAN CUTI
                        const Text("Alasan Cuti", style: TextStyle(fontSize: 13, color: Colors.black54)),
                        const SizedBox(height: 6),
                        _buildReasonField(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // === TOMBOL SIMPAN ===
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submitLeave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: isLoading
                          ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text(
                        "Simpan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
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

  // Helper untuk Date Field dengan Hint Text Custom
  Widget _buildDateField(TextEditingController controller, String hintText, bool isStart) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: () => _selectDate(controller, isStart),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF002B4C),
        fontSize: 14,
      ),
      decoration: _inputDecoration(hintText),
    );
  }

  // Helper untuk Reason Field
  Widget _buildReasonField() {
    return TextFormField(
      controller: _reasonController,
      maxLines: 4,
      style: const TextStyle(
        fontWeight: FontWeight.normal,
        color: Color(0xFF002B4C),
        fontSize: 14,
      ),
      decoration: _inputDecoration("Masukkan alasan..."),
    );
  }

  // Style Input Global
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.grey.shade400,
        fontSize: 13,
        fontWeight: FontWeight.normal,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFD4552F)), // Warna Orange saat aktif
      ),
    );
  }
}