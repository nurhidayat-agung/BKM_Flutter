import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:newbkmmobile/blocs/langsir/langsir_bloc.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_event.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_state.dart';
import 'langsir_detail_page.dart';

class LangsirFormPage extends StatefulWidget {
  final String id;
  const LangsirFormPage({required this.id, super.key});

  @override
  State<LangsirFormPage> createState() => _LangsirFormPageState();
}

class _LangsirFormPageState extends State<LangsirFormPage> {
  final _spbMuatController = TextEditingController();
  final _muatController = TextEditingController();
  final _tanggalMuatController = TextEditingController();

  final _spbBongkarController = TextEditingController();
  final _bongkarController = TextEditingController();
  final _tanggalBongkarController = TextEditingController();

  File? _photoMuat;
  File? _photoBongkar;

  @override
  void dispose() {
    _spbMuatController.dispose();
    _muatController.dispose();
    _tanggalMuatController.dispose();
    _spbBongkarController.dispose();
    _bongkarController.dispose();
    _tanggalBongkarController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(TextEditingController ctrl) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      ctrl.text = DateFormat('dd MMM yyyy').format(picked);
    }
  }

  Future<void> _pickImage(bool isMuat) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera, imageQuality: 60);
    if (picked != null) {
      setState(() {
        if (isMuat) {
          _photoMuat = File(picked.path);
        } else {
          _photoBongkar = File(picked.path);
        }
      });
    }
  }

  // Widget Header Section (MUAT / BONGKAR)
  Widget _buildSectionHeader(String title, Color color) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F9FA),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Text(
        title,
        textAlign: TextAlign.center, // Center title sesuai mockup
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller, {bool isDate = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input Field dengan Border
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: controller,
              readOnly: isDate,
              onTap: isDate ? () => _pickDate(controller) : null,
              keyboardType: isDate ? TextInputType.none : TextInputType.text,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                labelText: label, // Label melayang (Floating Label)
                labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoUpload(bool isMuat) {
    File? file = isMuat ? _photoMuat : _photoBongkar;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Unggah Foto SPB", style: TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 8),
          if (file != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Image.file(file, height: 100, fit: BoxFit.cover),
            ),
          ElevatedButton(
            onPressed: () => _pickImage(isMuat),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF002B4C), // Dark Blue Button
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              minimumSize: const Size(140, 40),
            ),
            child: const Text("Unggah Foto", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color darkBlue = const Color(0xFF002B4C);
    final Color orange = const Color(0xFFE55300);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Langsir', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white)),
        backgroundColor: darkBlue,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Color(0xFF2C4A64), borderRadius: BorderRadius.all(Radius.circular(4))),
              child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.white)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Header Info Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFF8F9FA),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("051/KAL-EUP/IP-CPO/X/2025", style: TextStyle(color: darkBlue, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(text: "SAM1 → ASK", style: TextStyle(color: orange, fontWeight: FontWeight.bold)),
                    TextSpan(text: " | CPO", style: TextStyle(color: orange)),
                  ]),
                ),
                const SizedBox(height: 4),
                const Text("11 Nov 2025", style: TextStyle(color: Colors.grey, fontSize: 12, fontStyle: FontStyle.italic)),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // --- KOTAK MUAT ---
                  Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [
                        _buildSectionHeader("MUAT", darkBlue),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _buildInput("No. SPB", _spbMuatController),
                              _buildInput("Jumlah Muat", _muatController),
                              _buildInput("Tanggal Muat", _tanggalMuatController, isDate: true),
                              _buildPhotoUpload(true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // --- KOTAK BONGKAR ---
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [
                        _buildSectionHeader("BONGKAR", darkBlue),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _buildInput("Jumlah Bongkar", _bongkarController),
                              _buildInput("Tanggal Bongkar", _tanggalBongkarController, isDate: true),
                              _buildPhotoUpload(false),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100), // Space extra bawah
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TOMBOL SIMPAN
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data Disimpan sementara!")));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4552F), // Orange Bata
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Simpan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(height: 12),

            // TOMBOL SELESAI -> Masuk ke DETAIL
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<LangsirBloc>(),
                    child: LangsirDetailPage(id: widget.id),
                  ),
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: darkBlue,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Selesai", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}