import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/repair/repair_bloc.dart';
import 'package:newbkmmobile/blocs/repair/repair_event.dart';
import 'package:newbkmmobile/blocs/repair/repair_state.dart';
import 'package:newbkmmobile/models/common/hive/hive_simple_master.dart';
import 'package:newbkmmobile/models/leave/leave_list_response.dart';
import 'package:newbkmmobile/models/repair/vehicle_repair_data.dart';
import 'package:newbkmmobile/repositories/repair_repository.dart';

import '../../../models/repair/maintenance_model.dart';
import '../../widgets/confirm_dialog.dart';

class RepairFormPage extends StatefulWidget {
  const RepairFormPage(
    this.repairTypes,
    this.urgencyLevels,
    this.maintenanceTypes, {
    this.data, // ⬅️ object edit
    super.key,
  });

  final List<HiveSimpleMaster>? repairTypes;
  final List<HiveSimpleMaster>? urgencyLevels;

  final MaintenanceListData? data; // ⬅️ ADD

  // DATA MASTER dari API
  final List<HiveSimpleMaster>? maintenanceTypes;

  @override
  State<RepairFormPage> createState() => _RepairFormPageState();
}

class _RepairFormPageState extends State<RepairFormPage> {
  final _kmController = TextEditingController();
  final _descController = TextEditingController();

  String? _selectedType;
  String? _selectedUrgency;

  // ID yang dipilih user
  List<String> _selectedMaintenanceTypeIds = [];

  late final List<String> _types;
  late final List<String> _urgencies;

  bool get _canSubmit {
    // CREATE
    if (widget.data == null) return true;

    // EDIT tapi hanya kalau status PENDING
    return widget.data?.status?.fieldValue == 'pending';
  }

  // Inisialisasi Bloc
  final RepairBloc _repairBloc = RepairBloc(RepairRepository());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _types = widget.maintenanceTypes
            ?.map((e) => e.name ?? '')
            .where((e) => e.isNotEmpty)
            .toList() ??
        [];

    _urgencies = widget.urgencyLevels
            ?.map((e) => e.name ?? '')
            .where((e) => e.isNotEmpty)
            .toList() ??
        [];

    /// =====================
    /// EDIT MODE
    /// =====================
    if (widget.data != null) {
      final data = widget.data!;

      _descController.text = data.description ?? '';

      // contoh mapping leaveTypeId -> name
      _selectedType = widget.maintenanceTypes
          ?.firstWhere(
            (e) => e.fieldValue == data.maintenanceType?.code,
            orElse: () => HiveSimpleMaster(),
          )
          .name;

      // contoh urgency dari status / field lain (sesuaikan API)
      _selectedUrgency = widget.urgencyLevels
          ?.firstWhere(
            (e) => e.fieldValue == data.priority?.code,
            orElse: () => HiveSimpleMaster(),
          )
          .name;

      /// ⬇️⬇️⬇️ INI YANG PENTING ⬇️⬇️⬇️
      _selectedMaintenanceTypeIds = data.damages
          ?.map((e) => e?.damageType?.id)
          .whereType<String>() // buang null
          .toList() ??
          [];


      // kalau ada KM di object
      _kmController.text = data.currentKm.toString() ?? '0';
    }
  }

  @override
  void dispose() {
    _kmController.dispose();
    _descController.dispose();
    _repairBloc.close();
    super.dispose();
  }

  Future<void> _submit() async {
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Konfirmasi',
      message: 'Apakah data akan disimpan ?',
    );

    if (!confirmed) return;

    if (_selectedType == null ||
        _selectedUrgency == null ||
        _kmController.text.isEmpty ||
        _descController.text.isEmpty ||
        _selectedMaintenanceTypeIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Semua field harus diisi!"),
            backgroundColor: Colors.orange),
      );
      return;
    }

    _repairBloc.add(
      SubmitRepair(
        id: widget.data?.id,
        type: _selectedType!,
        urgency: _selectedUrgency!,
        lastKm: _kmController.text,
        description: _descController.text,
        listRepairType: widget.repairTypes!,
        listUrgencyLevel: widget.urgencyLevels!,
        maintenanceType: widget.maintenanceTypes!,
        listRepair: _selectedMaintenanceTypeIds
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF002B4C);
    const orange = Color(0xFFD4552F);

    return BlocProvider(
        create: (context) => _repairBloc,
        child: BlocListener<RepairBloc, RepairState>(
          listener: (BuildContext context, RepairState state) {},
          child: Scaffold(
            backgroundColor: const Color(0xFFF5F6F8),
            appBar: AppBar(
              backgroundColor: darkBlue,
              elevation: 0,
              centerTitle: true,
              title: Text(
                widget.data == null
                    ? "Pengajuan Perbaikan"
                    : "Edit Pengajuan perbaikan",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
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
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 18),
                  ),
                ),
              ),
            ),
            body: BlocConsumer<RepairBloc, RepairState>(
              listener: (context, state) {
                if (state is RepairSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.green),
                  );
                  // Kembali ke halaman list dengan sinyal sukses
                  Navigator.pop(context, true);
                } else if (state is RepairFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is RepairLoading;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      if (widget.data?.status != null) _statusBadge(),
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
                            DropdownButtonFormField<String>(
                              value: _selectedType,
                              decoration:
                              _inputDecoration("Pilih Jenis Perbaikan ..."),
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.grey),
                              items: _types.map((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type,
                                      style: const TextStyle(fontSize: 14)),
                                );
                              }).toList(),
                              onChanged: (val) =>
                                  setState(() => _selectedType = val),
                            ),
                            const SizedBox(height: 20),
                            _maintenanceMultiSelectField(),
                            const SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              value: _selectedUrgency,
                              decoration: _inputDecoration("Urgensi Level..."),
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.grey),
                              items: _urgencies.map((String val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val,
                                      style: const TextStyle(fontSize: 14)),
                                );
                              }).toList(),
                              onChanged: (val) =>
                                  setState(() => _selectedUrgency = val),
                            ),
                            const SizedBox(height: 20),
                            const Text("Kilometer Terakhir",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black54)),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _kmController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                // ⬅️ HANYA ANGKA 0–9
                              ],
                              style: const TextStyle(fontSize: 14),
                              decoration: _inputDecoration(""),
                            ),
                            const SizedBox(height: 20),
                            const Text("Keterangan",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black54)),
                            const SizedBox(height: 6),
                            TextFormField(
                              controller: _descController,
                              maxLines: 4,
                              style: const TextStyle(fontSize: 14),
                              decoration: _inputDecoration(""),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (_canSubmit)
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: orange,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 2,
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2))
                                : Text(
                                    widget.data == null ? "Simpan" : "Edit",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
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
        borderSide: const BorderSide(color: Color(0xFFD4552F)),
      ),
    );
  }

  Widget _maintenanceMultiSelectField() {
    return InkWell(
      onTap: _showMaintenanceDialog,
      child: InputDecorator(
        decoration: _inputDecoration("Jenis Maintenance"),
        child: _selectedMaintenanceTypeIds.isEmpty
            ? const Text(
                "Pilih Jenis Maintenance",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              )
            : Wrap(
                spacing: 6,
                runSpacing: -8,
                children: widget.repairTypes!
                    .where((e) => _selectedMaintenanceTypeIds.contains(e.id))
                    .map(
                      (e) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3E0), // orange soft
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFFFB74D)),
                        ),
                        child: Text(
                          e.name ?? '-',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFE65100),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }

  void _showMaintenanceDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final tempSelected = List<String>.from(_selectedMaintenanceTypeIds);

        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text("Pilih Jenis Maintenance"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.repairTypes!.map((item) {
                    return CheckboxListTile(
                      value: tempSelected.contains(item.id),
                      title: Text(item.name ?? '-'),
                      onChanged: (checked) {
                        setStateDialog(() {
                          if (checked == true) {
                            tempSelected.add(item.id!);
                          } else {
                            tempSelected.remove(item.id);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Batal"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedMaintenanceTypeIds = tempSelected;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text("Simpan"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Color _hexToColor(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  Widget _statusBadge() {
    final status = widget.data!.status!;
    final bgColor = _hexToColor(status.colorHex ?? '#E0E0E0');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: bgColor.withOpacity(0.7)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 18),
          const SizedBox(width: 8),
          Text(
            status.name ?? '-',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }





}
