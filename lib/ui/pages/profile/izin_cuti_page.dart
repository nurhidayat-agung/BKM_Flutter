// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class IzinCutiPage extends StatefulWidget {
//   const IzinCutiPage({Key? key}) : super(key: key);
//
//   @override
//   State<IzinCutiPage> createState() => _IzinCutiPageState();
// }
//
// class _IzinCutiPageState extends State<IzinCutiPage> {
//   final _formKey = GlobalKey<FormState>();
//   String? jenisIzin;
//   DateTime? tanggalMulai;
//   DateTime? tanggalSelesai;
//   final teleponController = TextEditingController();
//   final alamatController = TextEditingController();
//
//   Future<void> _selectDate(BuildContext context, bool isMulai) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2024),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isMulai) {
//           tanggalMulai = picked;
//         } else {
//           tanggalSelesai = picked;
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: const BoxConstraints(maxHeight: 500, maxWidth: 400),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Alasan Izin / Cuti",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.black54),
//                       onPressed: () => Navigator.pop(context),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Jenis Izin
//                 DropdownButtonFormField<String>(
//                   value: jenisIzin,
//                   items: const [
//                     DropdownMenuItem(
//                         value: "Izin Cuti", child: Text("Izin Cuti")),
//                     DropdownMenuItem(
//                         value: "Izin Sakit", child: Text("Izin Sakit")),
//                     DropdownMenuItem(
//                         value: "Izin Pribadi", child: Text("Izin Pribadi")),
//                   ],
//                   decoration: InputDecoration(
//                     labelText: "Jenis Izin",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 12, horizontal: 12),
//                   ),
//                   onChanged: (value) => setState(() => jenisIzin = value),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Tanggal Mulai
//                 GestureDetector(
//                   onTap: () => _selectDate(context, true),
//                   child: AbsorbPointer(
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Tanggal Mulai",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 12, horizontal: 12),
//                       ),
//                       controller: TextEditingController(
//                         text: tanggalMulai == null
//                             ? ''
//                             : DateFormat('MM/dd/yyyy').format(tanggalMulai!),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Tanggal Selesai
//                 GestureDetector(
//                   onTap: () => _selectDate(context, false),
//                   child: AbsorbPointer(
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         labelText: "Tanggal Selesai",
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                         contentPadding: const EdgeInsets.symmetric(
//                             vertical: 12, horizontal: 12),
//                       ),
//                       controller: TextEditingController(
//                         text: tanggalSelesai == null
//                             ? ''
//                             : DateFormat('MM/dd/yyyy').format(tanggalSelesai!),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Nomor Telepon
//                 TextFormField(
//                   controller: teleponController,
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: "Nomor Telepon yang bisa dihubungi",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 12, horizontal: 12),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Alamat
//                 TextFormField(
//                   controller: alamatController,
//                   maxLines: 2,
//                   decoration: InputDecoration(
//                     labelText: "Alamat saat cuti",
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 12, horizontal: 12),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//
//                 // Tombol Simpan
//                 Center(
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blueGrey[900],
//                       minimumSize: const Size(160, 45),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("Izin berhasil diajukan")),
//                         );
//                         Navigator.pop(context);
//                       }
//                     },
//                     child: const Text(
//                       "Simpan",
//                       style: TextStyle(fontSize: 15, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


//

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class IzinCutiPage extends StatefulWidget {
//   final VoidCallback onSukses; // callback ke ProfilePage
//
//   const IzinCutiPage({Key? key, required this.onSukses}) : super(key: key);
//
//   @override
//   State<IzinCutiPage> createState() => _IzinCutiPageState();
// }
//
// class _IzinCutiPageState extends State<IzinCutiPage> {
//   final _formKey = GlobalKey<FormState>();
//   String? jenisIzin;
//   DateTime? tanggalMulai;
//   DateTime? tanggalSelesai;
//   final teleponController = TextEditingController();
//   final alamatController = TextEditingController();
//
//   Future<void> _selectDate(BuildContext context, bool isMulai) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2024),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isMulai) {
//           tanggalMulai = picked;
//         } else {
//           tanggalSelesai = picked;
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding:
//       EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     "Alasan Izin / Cuti",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.close, color: Colors.black54),
//                     onPressed: () => Navigator.pop(context),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 16),
//
//               // Jenis Izin
//               DropdownButtonFormField<String>(
//                 value: jenisIzin,
//                 items: const [
//                   DropdownMenuItem(
//                       value: "Izin Cuti", child: Text("Izin Cuti")),
//                   DropdownMenuItem(
//                       value: "Izin Sakit", child: Text("Izin Sakit")),
//                   DropdownMenuItem(
//                       value: "Izin Pribadi", child: Text("Izin Pribadi")),
//                 ],
//                 decoration: InputDecoration(
//                   labelText: "Jenis Izin",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 onChanged: (value) => setState(() => jenisIzin = value),
//                 validator: (value) =>
//                 value == null ? "Pilih jenis izin" : null,
//               ),
//               const SizedBox(height: 16),
//
//               // Tanggal Mulai
//               GestureDetector(
//                 onTap: () => _selectDate(context, true),
//                 child: AbsorbPointer(
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       labelText: "Tanggal Mulai",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                     controller: TextEditingController(
//                       text: tanggalMulai == null
//                           ? ''
//                           : DateFormat('dd/MM/yyyy').format(tanggalMulai!),
//                     ),
//                     validator: (_) =>
//                     tanggalMulai == null ? "Pilih tanggal mulai" : null,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               // Tanggal Selesai
//               GestureDetector(
//                 onTap: () => _selectDate(context, false),
//                 child: AbsorbPointer(
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       labelText: "Tanggal Selesai",
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10)),
//                     ),
//                     controller: TextEditingController(
//                       text: tanggalSelesai == null
//                           ? ''
//                           : DateFormat('dd/MM/yyyy').format(tanggalSelesai!),
//                     ),
//                     validator: (_) =>
//                     tanggalSelesai == null ? "Pilih tanggal selesai" : null,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               // Nomor Telepon
//               TextFormField(
//                 controller: teleponController,
//                 keyboardType: TextInputType.phone,
//                 decoration: InputDecoration(
//                   labelText: "Nomor Telepon yang bisa dihubungi",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 validator: (value) =>
//                 value == null || value.isEmpty ? "Isi nomor telepon" : null,
//               ),
//               const SizedBox(height: 16),
//
//               // Alamat
//               TextFormField(
//                 controller: alamatController,
//                 maxLines: 2,
//                 decoration: InputDecoration(
//                   labelText: "Alamat saat cuti",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                 ),
//                 validator: (value) =>
//                 value == null || value.isEmpty ? "Isi alamat cuti" : null,
//               ),
//               const SizedBox(height: 24),
//
//               // Tombol Simpan
//               Center(
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blueGrey[900],
//                     minimumSize: const Size(160, 45),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       widget.onSukses(); // panggil popup sukses
//                     }
//                   },
//                   child: const Text(
//                     "Simpan",
//                     style: TextStyle(fontSize: 15, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IzinCutiPage extends StatefulWidget {
  final VoidCallback onSukses; // callback ke ProfilePage

  const IzinCutiPage({Key? key, required this.onSukses}) : super(key: key);

  @override
  State<IzinCutiPage> createState() => _IzinCutiPageState();
}

class _IzinCutiPageState extends State<IzinCutiPage> {
  final _formKey = GlobalKey<FormState>();
  String? jenisIzin;
  DateTime? tanggalMulai;
  DateTime? tanggalSelesai;
  final teleponController = TextEditingController();
  final alamatController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isMulai) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isMulai) {
          tanggalMulai = picked;
        } else {
          tanggalSelesai = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Alasan Izin / Cuti",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.black54),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            const SizedBox(height: 16),

            // Jenis Izin
            DropdownButtonFormField<String>(
              value: jenisIzin,
              items: const [
                DropdownMenuItem(value: "Izin Cuti", child: Text("Izin Cuti")),
                DropdownMenuItem(value: "Izin Sakit", child: Text("Izin Sakit")),
                DropdownMenuItem(
                    value: "Izin Pribadi", child: Text("Izin Pribadi")),
              ],
              decoration: InputDecoration(
                labelText: "Jenis Izin",
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) => setState(() => jenisIzin = value),
              validator: (value) => value == null ? "Pilih jenis izin" : null,
            ),
            const SizedBox(height: 16),

            // Tanggal Mulai
            GestureDetector(
              onTap: () => _selectDate(context, true),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Tanggal Mulai",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  controller: TextEditingController(
                    text: tanggalMulai == null
                        ? ''
                        : DateFormat('dd/MM/yyyy').format(tanggalMulai!),
                  ),
                  validator: (_) =>
                  tanggalMulai == null ? "Pilih tanggal mulai" : null,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Tanggal Selesai
            GestureDetector(
              onTap: () => _selectDate(context, false),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Tanggal Selesai",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  controller: TextEditingController(
                    text: tanggalSelesai == null
                        ? ''
                        : DateFormat('dd/MM/yyyy').format(tanggalSelesai!),
                  ),
                  validator: (_) =>
                  tanggalSelesai == null ? "Pilih tanggal selesai" : null,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Nomor Telepon
            TextFormField(
              controller: teleponController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Nomor Telepon yang bisa dihubungi",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              validator: (value) =>
              value == null || value.isEmpty ? "Isi nomor telepon" : null,
            ),
            const SizedBox(height: 16),

            // Alamat
            TextFormField(
              controller: alamatController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: "Alamat saat cuti",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              validator: (value) =>
              value == null || value.isEmpty ? "Isi alamat cuti" : null,
            ),
            const SizedBox(height: 24),

            // Tombol Simpan
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[900],
                  minimumSize: const Size(160, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onSukses(); // panggil callback sukses
                  }
                },
                child: const Text(
                  "Simpan",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
