import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:newbkmmobile/blocs/langsir/langsir_bloc.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_event.dart';
import 'package:newbkmmobile/blocs/langsir/langsir_state.dart';
import 'package:newbkmmobile/core/convert_date.dart';
import 'package:newbkmmobile/models/langsir_detail/local_hauling_detail_data.dart';
import 'package:newbkmmobile/models/langsir_detail_item/langsir_detail_item_response.dart';
import 'package:newbkmmobile/ui/widgets/bkm_loading.dart';
import 'package:newbkmmobile/ui/widgets/confirm_dialog.dart';
import 'package:flutter/services.dart';

class LangsirFormPage extends StatefulWidget {
  final LocalHaulingDetailData data;
  final String? detailItemId;

  const LangsirFormPage({
    required this.data,
    this.detailItemId,
    super.key,
  });

  bool get isEdit => detailItemId != null;

  @override
  State<LangsirFormPage> createState() => _LangsirFormPageState();
}

class _LangsirFormPageState extends State<LangsirFormPage> {
  final _spbMuatController = TextEditingController();
  final _muatController = TextEditingController();
  final _tanggalMuatController = TextEditingController();

  final _bongkarController = TextEditingController();
  final _tanggalBongkarController = TextEditingController();

  final _convertDate = ConvertDate();

  File? _photoMuat;
  File? _photoBongkar;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      context.read<LangsirBloc>().add(
        FetchLangsirDetailItem(doId: widget.detailItemId!),
      );
    }
  }

  @override
  void dispose() {
    _spbMuatController.dispose();
    _muatController.dispose();
    _tanggalMuatController.dispose();
    _bongkarController.dispose();
    _tanggalBongkarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkBlue = const Color(0xFF002B4C);
    final orange = const Color(0xFFE55300);

    return BlocListener<LangsirBloc, LangsirState>(
      listener: (context, state) {
        if (state is LangsirLoading) {
          BkmLoading.show(context, message: "mohon tunggu");
        }

        if (state is LangsirSubmitSuccess) {
          BkmLoading.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true);
        }

        if (state is LangsirSubmitFailed) {
          BkmLoading.hide(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        }

        if (state is FetchLangsirDetailItemSuccess) {
          BkmLoading.hide(context);
          _fillFormFromResponse(state.resp);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          title: Text(
            widget.isEdit ? 'Edit Item Langsir' : 'Tambah Item Langsir',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          backgroundColor: darkBlue,
          centerTitle: true,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFF2C4A64),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 16,
                color: Colors.white,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        body: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFF8F9FA),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.data.doNumber ?? "-",
                    style: TextStyle(
                      color: darkBlue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                          "${widget.data.pks?.code ?? "-"} → ${widget.data.destination?.code ?? "-"}",
                          style: TextStyle(
                            color: orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: " | ${widget.data.commodity?.code ?? '-'}",
                          style: TextStyle(color: orange),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _convertDate.isoFormatToReadable(
                      widget.data.doDate ?? "",
                    ),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            // ================= SCROLL AREA =================
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 140,
                ),
                child: Column(
                  children: [
                    // MUAT
                    Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          _buildSectionHeader("MUAT", darkBlue),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                _buildInput("No. SPB", _spbMuatController),
                                _buildInput(
                                  "Jumlah Muat",
                                  _muatController,
                                  isNumeric: true,
                                ),
                                _buildInput(
                                  "Tanggal Muat",
                                  _tanggalMuatController,
                                  isDate: true,
                                ),
                                _buildPhotoUpload(true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // BONGKAR
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          _buildSectionHeader("BONGKAR", darkBlue),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                _buildInput(
                                  "Jumlah Bongkar",
                                  _bongkarController,
                                  isNumeric: true,
                                ),
                                _buildInput(
                                  "Tanggal Bongkar",
                                  _tanggalBongkarController,
                                  isDate: true,
                                ),
                                _buildPhotoUpload(false),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // ================= FIXED BUTTON =================
        bottomNavigationBar: SafeArea(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSaveButton(),
                const SizedBox(height: 12),
                _buildFinishButton(darkBlue),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= BUTTONS =================

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () async {
        final confirmed = await ConfirmDialog.show(
          context: context,
          title: 'Konfirmasi',
          message: 'Apakah data akan disimpan ?',
        );

        if (!confirmed) return;

        if (_spbMuatController.text.isEmpty ||
            _muatController.text.isEmpty ||
            _tanggalMuatController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data muat belum lengkap")),
          );
          return;
        }

        final isEdit = widget.isEdit;
        final detailId = widget.detailItemId;

        if (isEdit) {
          context.read<LangsirBloc>().add(
            UpdateLangsirDetailItem(
              detailId: detailId!,
              doId: widget.data.id!,
              spbNumber: _spbMuatController.text,
              loadQuantity: _muatController.text,
              unloadQuantity:
              _bongkarController.text.isEmpty ? '0' : _bongkarController.text,
              loadDate: _toApiDate(_tanggalMuatController.text),
              unloadDate: _tanggalBongkarController.text.isEmpty
                  ? ''
                  : _toApiDate(_tanggalBongkarController.text),
              actionButton: 'partial_save',
              imgSpbLoad: _photoMuat,
              imgSpbUnload: _photoBongkar,
            ),
          );
        } else {
          context.read<LangsirBloc>().add(
            SubmitLocalHauling(
              doId: widget.data.id!,
              spbNumber: _spbMuatController.text,
              loadQuantity: _muatController.text,
              unloadQuantity:
              _bongkarController.text.isEmpty ? '0' : _bongkarController.text,
              loadDate: _toApiDate(_tanggalMuatController.text),
              unloadDate: _tanggalBongkarController.text.isEmpty
                  ? ''
                  : _toApiDate(_tanggalBongkarController.text),
              actionButton: 'partial_save',
              imgSpbLoad: _photoMuat,
              imgSpbUnload: _photoBongkar,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFD4552F),
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        "Simpan",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFinishButton(Color darkBlue) {
    return ElevatedButton(
      onPressed: () async {
        final confirmed = await ConfirmDialog.show(
          context: context,
          title: 'Konfirmasi',
          message:
          'Apakah data MUAT & BONGKAR sudah selesai dan akan dikirim?',
        );

        if (!confirmed) return;

        if (_spbMuatController.text.isEmpty ||
            _muatController.text.isEmpty ||
            _tanggalMuatController.text.isEmpty ||
            _photoMuat == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data MUAT belum lengkap")),
          );
          return;
        }

        if (_bongkarController.text.isEmpty ||
            _tanggalBongkarController.text.isEmpty ||
            _photoBongkar == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data BONGKAR belum lengkap")),
          );
          return;
        }

        final isEdit = widget.isEdit;
        final detailId = widget.detailItemId;

        if (isEdit) {
          context.read<LangsirBloc>().add(
            UpdateLangsirDetailItem(
              detailId: detailId!,
              doId: widget.data.id!,
              spbNumber: _spbMuatController.text,
              loadQuantity: _muatController.text,
              unloadQuantity:
              _bongkarController.text.isEmpty ? '0' : _bongkarController.text,
              loadDate: _toApiDate(_tanggalMuatController.text),
              unloadDate: _tanggalBongkarController.text.isEmpty
                  ? ''
                  : _toApiDate(_tanggalBongkarController.text),
              actionButton: 'final_save',
              imgSpbLoad: _photoMuat,
              imgSpbUnload: _photoBongkar,
            ),
          );
        } else {
          context.read<LangsirBloc>().add(
            SubmitLocalHauling(
              doId: widget.data.id!,
              spbNumber: _spbMuatController.text,
              loadQuantity: _muatController.text,
              unloadQuantity:
              _bongkarController.text.isEmpty ? '0' : _bongkarController.text,
              loadDate: _toApiDate(_tanggalMuatController.text),
              unloadDate: _tanggalBongkarController.text.isEmpty
                  ? ''
                  : _toApiDate(_tanggalBongkarController.text),
              actionButton: 'final_save',
              imgSpbLoad: _photoMuat,
              imgSpbUnload: _photoBongkar,
            ),
          );
        }

      },
      style: ElevatedButton.styleFrom(
        backgroundColor: darkBlue,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        "Selesai",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  // ================= HELPERS =================

  void _fillFormFromResponse(LangsirDetailItemResponse resp) {
    final data = resp.data;
    if (data == null) return;

    _spbMuatController.text = data.spbNumber ?? '';
    _muatController.text = data.loadQuantity?.toString() ?? '';
    _tanggalMuatController.text =
        _convertDate.isoFormatToReadable(data.loadDate ?? '');

    _bongkarController.text = data.unloadQuantity?.toString() ?? '';
    _tanggalBongkarController.text =
        _convertDate.isoFormatToReadable(data.unloadDate ?? '');
  }

  String _toApiDate(String value) {
    if (value.isEmpty) return '';
    final parsed = DateFormat('dd MMM yyyy').parse(value);
    return DateFormat('yyyy-MM-dd').format(parsed);
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
    final picked =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 60);
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

  Widget _buildSectionHeader(String title, Color color) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F9FA),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildInput(
      String label,
      TextEditingController controller, {
        bool isDate = false,
        bool isNumeric = false,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: TextField(
          controller: controller,
          readOnly: isDate,
          onTap: isDate ? () => _pickDate(controller) : null,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          inputFormatters:
          isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoUpload(bool isMuat) {
    final file = isMuat ? _photoMuat : _photoBongkar;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Unggah Foto SPB",
              style: TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 8),
          if (file != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Image.file(file, height: 100, fit: BoxFit.cover),
            ),
          ElevatedButton(
            onPressed: () => _pickImage(isMuat),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF002B4C),
              minimumSize: const Size(140, 40),
            ),
            child: const Text(
              "Unggah Foto",
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
