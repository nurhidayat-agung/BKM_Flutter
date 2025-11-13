// import 'dart:ui'; // ✅ untuk efek blur
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../login/login_page.dart'; // pastikan path sesuai struktur project-mu
// import 'izin_cuti_page.dart';
// import 'riwayat_izin_page.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//
//   // ✅ Fungsi logout yang menghapus data login & arahkan ke LoginPage
//   Future<void> _logout(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear(); // hapus semua data tersimpan (token, username, dsb)
//
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginPage()),
//           (route) => false,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 1,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Profil',
//           style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12.withOpacity(0.05),
//                 blurRadius: 5,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // Foto profil dan nama
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const CircleAvatar(
//                       radius: 35,
//                       backgroundImage: AssetImage('assets/ic_bkm_512.png'),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             "BASUKI RAHMAT",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 4),
//                           Text("B 9807 AA",
//                               style: TextStyle(color: Colors.black54)),
//                           Text("NIK: M-0018",
//                               style: TextStyle(color: Colors.black54)),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Divider(),
//
//                 _buildInfoRow("User Name", "basukirahmat"),
//                 _buildInfoRow("Status Karyawan", "Mitra"),
//                 _buildInfoRow("Status Driver", "PRIMARY"),
//                 _buildInfoRow("Site", "RIAU"),
//                 _buildInfoRow("Unit", "TRUCKING"),
//                 _buildInfoRow("No Telepon", "081365627455"),
//                 _buildInfoRow("NIK KTP", "1217021407440001"),
//                 _buildInfoRow("Tempat Lahir", "Pekanbaru"),
//                 _buildInfoRow("Tanggal Lahir", "24/4/1974"),
//                 _buildInfoRow("Alamat",
//                     "JL. RAJA ALI HAJI RT 015 RW 001 KEL PURNAMA KEC DUMAI BARAT KOTA DUMAI"),
//                 _buildInfoRow("Pendidikan Terakhir", "SMA"),
//                 _buildInfoRow("No SIM", "0916740400003"),
//                 _buildInfoRow("Jenis SIM", "SIM B2 Umum"),
//                 _buildInfoRow("No Rekening", "1720002033144"),
//                 _buildInfoRow("Bergabung Sejak", "Rabu, 31 Desember 2014"),
//
//                 const SizedBox(height: 24),
//
//                 // Tombol Aksi
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.pink[200],
//                         minimumSize: const Size.fromHeight(45),
//                       ),
//                       onPressed: () => _showIzinCutiDialog(context),
//                       child: const Text("Ajukan Izin / Cuti"),
//                     ),
//                     const SizedBox(height: 12),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange[400],
//                         minimumSize: const Size.fromHeight(45),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const RiwayatIzinPage()),
//                         );
//                       },
//                       child: const Text("Riwayat Izin / Cuti"),
//                     ),
//                     const SizedBox(height: 24),
//                     // 🔹 Tombol Logout Aktif
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueGrey[900],
//                         minimumSize: const Size.fromHeight(45),
//                       ),
//                       onPressed: () => _logout(context),
//                       child: const Text("Logout"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//               flex: 3,
//               child: Text(label,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w600, color: Colors.black87))),
//           Expanded(
//               flex: 5,
//               child: Text(value,
//                   style: const TextStyle(color: Colors.black54, height: 1.4))),
//         ],
//       ),
//     );
//   }
//
//   // ✅ Dialog izin/cuti dengan efek blur
//   void _showIzinCutiDialog(BuildContext context) {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: '',
//       barrierColor: Colors.black.withOpacity(0.1),
//       transitionDuration: const Duration(milliseconds: 200),
//       pageBuilder: (context, anim1, anim2) {
//         return Center(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
//             child: Dialog(
//               elevation: 0,
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const IzinCutiPage(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../login/login_page.dart';
// import 'izin_cuti_page.dart';
// import 'riwayat_izin_page.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//
//   // 🔹 Fungsi logout
//   Future<void> _logout(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginPage()),
//           (route) => false,
//     );
//   }
//
//   // 🔹 Fungsi tampilkan dialog sukses seperti pada gambar ke-2
//   void _showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Icon(Icons.check_circle, color: Colors.green, size: 60),
//               SizedBox(height: 16),
//               Text(
//                 "Izin Berhasil Diajukan",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "Permintaan izin kamu berhasil diajukan!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.black54),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//     // otomatis tutup setelah 2 detik
//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.pop(context);
//     });
//   }
//
//   // 🔹 Tampilkan modal form izin
//   void _showIzinForm(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => DraggableScrollableSheet(
//         expand: false,
//         maxChildSize: 0.9,
//         minChildSize: 0.4,
//         initialChildSize: 0.75,
//         builder: (context, scrollController) => Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           child: IzinCutiPage(
//             onSukses: () {
//               Navigator.pop(context); // tutup form
//               _showSuccessDialog(context); // tampilkan popup sukses
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 2,
//         centerTitle: true,
//         title: const Text(
//           'Profil',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.orange),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12.withOpacity(0.05),
//                 blurRadius: 6,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // 🔹 Header profil
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const CircleAvatar(
//                       radius: 35,
//                       backgroundImage: AssetImage('assets/ic_bkm_512.png'),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text("BASUKI RAHMAT",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold)),
//                           SizedBox(height: 4),
//                           Text("B 9807 AA",
//                               style: TextStyle(color: Colors.black54)),
//                           Text("NIK: M-0018",
//                               style: TextStyle(color: Colors.black54)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Divider(),
//
//                 // 🔹 Data Profil
//                 _buildInfoRow("User Name", "basukirahmat"),
//                 _buildInfoRow("Status Karyawan", "Mitra"),
//                 _buildInfoRow("Status Driver", "PRIMARY"),
//                 _buildInfoRow("Site", "RIAU"),
//                 _buildInfoRow("Unit", "TRUCKING"),
//                 _buildInfoRow("No Telepon", "081365627455"),
//                 _buildInfoRow("NIK KTP", "1217021407440001"),
//                 _buildInfoRow("Tempat Lahir", "Pekanbaru"),
//                 _buildInfoRow("Tanggal Lahir", "24/4/1974"),
//                 _buildInfoRow("Alamat",
//                     "JL. RAJA ALI HAJI RT 015 RW 001 KEL PURNAMA KEC DUMAI BARAT KOTA DUMAI"),
//                 _buildInfoRow("Pendidikan Terakhir", "SMA"),
//                 _buildInfoRow("No SIM", "0916740400003"),
//                 _buildInfoRow("Jenis SIM", "SIM B2 Umum"),
//                 _buildInfoRow("No Rekening", "1720002033144"),
//                 _buildInfoRow("Bergabung Sejak", "Rabu, 31 Desember 2014"),
//
//                 const SizedBox(height: 24),
//
//                 // 🔹 Tombol Aksi
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.pink[200],
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () {
//                         _showIzinForm(context); // tampilkan form izin cuti
//                       },
//                       child: const Text("Ajukan Izin / Cuti"),
//                     ),
//                     const SizedBox(height: 12),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange[400],
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const RiwayatIzinPage()),
//                         );
//                       },
//                       child: const Text("Riwayat Izin / Cuti"),
//                     ),
//                     const SizedBox(height: 24),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueGrey[900],
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () => _logout(context),
//                       child: const Text("Logout"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // 🔹 Widget untuk baris informasi
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 3,
//             child: Text(
//               label,
//               style: const TextStyle(
//                   fontWeight: FontWeight.w600, color: Colors.black87),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Text(
//               value,
//               style: const TextStyle(color: Colors.black54, height: 1.4),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../login/login_page.dart';
// import 'izin_cuti_page.dart';
// import 'riwayat_izin_page.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//
//   // 🔹 Fungsi logout
//   Future<void> _logout(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginPage()),
//           (route) => false,
//     );
//   }
//
//   // 🔹 Fungsi tampilkan dialog sukses
//   void _showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Icon(Icons.check_circle, color: Colors.green, size: 60),
//               SizedBox(height: 12),
//               Text(
//                 "Izin Berhasil Diajukan",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "Permintaan izin kamu berhasil diajukan!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.black54),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//     Future.delayed(const Duration(seconds: 2), () {
//       Navigator.of(context).pop(); // Tutup popup
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 2,
//         centerTitle: true,
//         title: const Text(
//           'Profil',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.orange),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12.withOpacity(0.05),
//                 blurRadius: 6,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // Header profil
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const CircleAvatar(
//                       radius: 35,
//                       backgroundImage: AssetImage('assets/ic_bkm_512.png'),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text("BASUKI RAHMAT",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold)),
//                           SizedBox(height: 4),
//                           Text("B 9807 AA",
//                               style: TextStyle(color: Colors.black54)),
//                           Text("NIK: M-0018",
//                               style: TextStyle(color: Colors.black54)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Divider(),
//
//                 // Data Profil
//                 _buildInfoRow("User Name", "basukirahmat"),
//                 _buildInfoRow("Status Karyawan", "Mitra"),
//                 _buildInfoRow("Status Driver", "PRIMARY"),
//                 _buildInfoRow("Site", "RIAU"),
//                 _buildInfoRow("Unit", "TRUCKING"),
//                 _buildInfoRow("No Telepon", "081365627455"),
//                 _buildInfoRow("NIK KTP", "1217021407440001"),
//                 _buildInfoRow("Tempat Lahir", "Pekanbaru"),
//                 _buildInfoRow("Tanggal Lahir", "24/4/1974"),
//                 _buildInfoRow("Alamat",
//                     "JL. RAJA ALI HAJI RT 015 RW 001 KEL PURNAMA KEC DUMAI BARAT KOTA DUMAI"),
//                 _buildInfoRow("Pendidikan Terakhir", "SMA"),
//                 _buildInfoRow("No SIM", "0916740400003"),
//                 _buildInfoRow("Jenis SIM", "SIM B2 Umum"),
//                 _buildInfoRow("No Rekening", "1720002033144"),
//                 _buildInfoRow("Bergabung Sejak", "Rabu, 31 Desember 2014"),
//
//                 const SizedBox(height: 24),
//
//                 // Tombol Aksi
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.pink[200],
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () async {
//                         // Buka form izin
//                         final result = await Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => const IzinCutiPage(),
//                           ),
//                         );
//
//                         // Jika form dikirim dan return 'success', tampilkan dialog
//                         if (result == 'success') {
//                           _showSuccessDialog(context);
//                         }
//                       },
//                       child: const Text("Ajukan Izin / Cuti"),
//                     ),
//                     const SizedBox(height: 12),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange[400],
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const RiwayatIzinPage()),
//                         );
//                       },
//                       child: const Text("Riwayat Izin / Cuti"),
//                     ),
//                     const SizedBox(height: 24),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueGrey[900],
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () => _logout(context),
//                       child: const Text("Logout"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // 🔹 Widget untuk baris informasi
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 3,
//             child: Text(
//               label,
//               style: const TextStyle(
//                   fontWeight: FontWeight.w600, color: Colors.black87),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Text(
//               value,
//               style: const TextStyle(color: Colors.black54, height: 1.4),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../login/login_page.dart';
// import 'izin_cuti_page.dart';
// import 'riwayat_izin_page.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//
//   // 🔹 Fungsi logout
//   Future<void> _logout(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginPage()),
//           (route) => false,
//     );
//   }
//
//   // 🔹 Fungsi tampilkan dialog sukses seperti pada gambar ke-2
//   void _showSuccessDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) => Dialog(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: const [
//               Icon(Icons.check_circle, color: Colors.green, size: 60),
//               SizedBox(height: 16),
//               Text(
//                 "Izin Berhasil Diajukan",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 "Permintaan izin kamu berhasil diajukan!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.black54),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//     // otomatis tutup setelah 2 detik
//     Future.delayed(const Duration(milliseconds: 1500), () {
//       Navigator.pop(context);
//     });
//   }
//
//   // 🔹 Ganti modal sheet → tampilkan dialog form di tengah layar
//   void _showIzinForm(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxHeight: 550),
//             child: IzinCutiPage(
//               onSukses: () {
//                 Navigator.pop(context); // tutup form izin
//                 _showSuccessDialog(context); // tampilkan popup sukses
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 2,
//         centerTitle: true,
//         title: const Text(
//           'Profil',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.orange),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12.withOpacity(0.05),
//                 blurRadius: 6,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // 🔹 Header profil
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const CircleAvatar(
//                       radius: 35,
//                       backgroundImage: AssetImage('assets/ic_bkm_512.png'),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text("BASUKI RAHMAT",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold)),
//                           SizedBox(height: 4),
//                           Text("B 9807 AA",
//                               style: TextStyle(color: Colors.black54)),
//                           Text("NIK: M-0018",
//                               style: TextStyle(color: Colors.black54)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Divider(),
//
//                 // 🔹 Data Profil
//                 _buildInfoRow("User Name", "basukirahmat"),
//                 _buildInfoRow("Status Karyawan", "Mitra"),
//                 _buildInfoRow("Status Driver", "PRIMARY"),
//                 _buildInfoRow("Site", "RIAU"),
//                 _buildInfoRow("Unit", "TRUCKING"),
//                 _buildInfoRow("No Telepon", "081365627455"),
//                 _buildInfoRow("NIK KTP", "1217021407440001"),
//                 _buildInfoRow("Tempat Lahir", "Pekanbaru"),
//                 _buildInfoRow("Tanggal Lahir", "24/4/1974"),
//                 _buildInfoRow("Alamat",
//                     "JL. RAJA ALI HAJI RT 015 RW 001 KEL PURNAMA KEC DUMAI BARAT KOTA DUMAI"),
//                 _buildInfoRow("Pendidikan Terakhir", "SMA"),
//                 _buildInfoRow("No SIM", "0916740400003"),
//                 _buildInfoRow("Jenis SIM", "SIM B2 Umum"),
//                 _buildInfoRow("No Rekening", "1720002033144"),
//                 _buildInfoRow("Bergabung Sejak", "Rabu, 31 Desember 2014"),
//
//                 const SizedBox(height: 24),
//
//                 // 🔹 Tombol Aksi
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.pink[200],
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () {
//                         _showIzinForm(context); // tampilkan form izin cuti
//                       },
//                       child: const Text("Ajukan Izin / Cuti"),
//                     ),
//                     const SizedBox(height: 12),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange[400],
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const RiwayatIzinPage()),
//                         );
//                       },
//                       child: const Text("Riwayat Izin / Cuti"),
//                     ),
//                     const SizedBox(height: 24),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueGrey[900],
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () => _logout(context),
//                       child: const Text("Logout"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // 🔹 Widget untuk baris informasi
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 3,
//             child: Text(
//               label,
//               style: const TextStyle(
//                   fontWeight: FontWeight.w600, color: Colors.black87),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Text(
//               value,
//               style: const TextStyle(color: Colors.black54, height: 1.4),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../login/login_page.dart';
// import 'izin_cuti_page.dart';
// import 'riwayat_izin_page.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({Key? key}) : super(key: key);
//
//   // 🔹 Fungsi logout
//   Future<void> _logout(BuildContext context) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginPage()),
//           (route) => false,
//     );
//   }
//
//   // 🔹 Fungsi tampilkan dialog sukses dengan animasi halus (fade + scale)
//   void _showSuccessDialog(BuildContext context) {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: false,
//       barrierLabel: '',
//       barrierColor: Colors.black45,
//       transitionDuration: const Duration(milliseconds: 250),
//       pageBuilder: (context, anim1, anim2) {
//         return const SizedBox.shrink();
//       },
//       transitionBuilder: (context, anim1, anim2, child) {
//         final curvedValue =
//             Curves.easeInOutBack.transform(anim1.value) - 1.0;
//         return Transform(
//           transform:
//           Matrix4.translationValues(0.0, curvedValue * -50, 0.0),
//           child: Opacity(
//             opacity: anim1.value,
//             child: Center(
//               child: Dialog(
//                 backgroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(24),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: const [
//                       Icon(Icons.check_circle,
//                           color: Colors.green, size: 60),
//                       SizedBox(height: 16),
//                       Text(
//                         "Izin Berhasil Diajukan",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         "Permintaan izin kamu berhasil diajukan!",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.black54),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//
//     // 🔸 Tutup otomatis setelah 1.5 detik
//     Future.delayed(const Duration(milliseconds: 1500), () {
//       if (Navigator.of(context).canPop()) {
//         Navigator.of(context).pop();
//       }
//     });
//   }
//
//   // 🔹 Ganti modal sheet → tampilkan dialog form di tengah layar
//   void _showIzinForm(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(maxHeight: 550),
//             child: IzinCutiPage(
//               onSukses: () {
//                 Navigator.pop(context); // Tutup form izin
//                 _showSuccessDialog(context); // Tampilkan popup sukses
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 2,
//         centerTitle: true,
//         title: const Text(
//           'Profil',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.orange),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12.withOpacity(0.05),
//                 blurRadius: 6,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // 🔹 Header profil
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const CircleAvatar(
//                       radius: 35,
//                       backgroundImage: AssetImage('assets/ic_bkm_512.png'),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text("BASUKI RAHMAT",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold)),
//                           SizedBox(height: 4),
//                           Text("B 9807 AA",
//                               style: TextStyle(color: Colors.black54)),
//                           Text("NIK: M-0018",
//                               style: TextStyle(color: Colors.black54)),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 const Divider(),
//
//                 // 🔹 Data Profil
//                 _buildInfoRow("User Name", "basukirahmat"),
//                 _buildInfoRow("Status Karyawan", "Mitra"),
//                 _buildInfoRow("Status Driver", "PRIMARY"),
//                 _buildInfoRow("Site", "RIAU"),
//                 _buildInfoRow("Unit", "TRUCKING"),
//                 _buildInfoRow("No Telepon", "081365627455"),
//                 _buildInfoRow("NIK KTP", "1217021407440001"),
//                 _buildInfoRow("Tempat Lahir", "Pekanbaru"),
//                 _buildInfoRow("Tanggal Lahir", "24/4/1974"),
//                 _buildInfoRow("Alamat",
//                     "JL. RAJA ALI HAJI RT 015 RW 001 KEL PURNAMA KEC DUMAI BARAT KOTA DUMAI"),
//                 _buildInfoRow("Pendidikan Terakhir", "SMA"),
//                 _buildInfoRow("No SIM", "0916740400003"),
//                 _buildInfoRow("Jenis SIM", "SIM B2 Umum"),
//                 _buildInfoRow("No Rekening", "1720002033144"),
//                 _buildInfoRow("Bergabung Sejak", "Rabu, 31 Desember 2014"),
//
//                 const SizedBox(height: 24),
//
//                 // 🔹 Tombol Aksi
//                 Column(
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.pink[200],
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () {
//                         _showIzinForm(context); // tampilkan form izin cuti
//                       },
//                       child: const Text("Ajukan Izin / Cuti"),
//                     ),
//                     const SizedBox(height: 12),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange[400],
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) => const RiwayatIzinPage()),
//                         );
//                       },
//                       child: const Text("Riwayat Izin / Cuti"),
//                     ),
//                     const SizedBox(height: 24),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueGrey[900],
//                         minimumSize: const Size.fromHeight(45),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10)),
//                       ),
//                       onPressed: () => _logout(context),
//                       child: const Text("Logout"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // 🔹 Widget untuk baris informasi
//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 3,
//             child: Text(
//               label,
//               style: const TextStyle(
//                   fontWeight: FontWeight.w600, color: Colors.black87),
//             ),
//           ),
//           Expanded(
//             flex: 5,
//             child: Text(
//               value,
//               style: const TextStyle(color: Colors.black54, height: 1.4),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/ui/pages/login/login_page.dart';
import 'package:newbkmmobile/ui/pages/profile/riwayat_izin_page.dart';
import 'package:newbkmmobile/ui/pages/profile/izin_cuti_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // 🔹 Fungsi utama untuk logout
  Future<void> _performLogout(BuildContext context) async {
    final repo = LoginRepository();

    // 🔹 Tampilkan dialog loading modern
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Dialog(
            elevation: 0,
            backgroundColor: Colors.black54.withOpacity(0.5),
            child: const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: Colors.white),
                  SizedBox(height: 16),
                  Text(
                    "Sedang logout...",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    try {
      // 🔹 Hit API Postman (logout endpoint)
      final success = await repo.logoutRemote();

      // 🔹 Tutup loading popup
      Navigator.pop(context);

      if (success) {
        // 🔹 Navigasi ke halaman login
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logout gagal di server, coba lagi.'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan saat logout: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // 🔹 Popup konfirmasi sebelum logout
  Future<void> _confirmLogout(BuildContext context) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          'Konfirmasi Logout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Apakah kamu yakin ingin keluar dari akun ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Tidak'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ya'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // 🔸 Tambahkan jeda kecil agar UI sempat menutup dialog dulu
      await Future.delayed(const Duration(milliseconds: 200));
      await _performLogout(context);
    }
  }

  // 🔹 Navigasi ke form izin dengan callback sukses
  void _showIzinCutiForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => IzinCutiPage(
          onSukses: () {
            Navigator.pop(context); // tutup form izin
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Pengajuan izin berhasil disimpan!"),
                backgroundColor: Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Profil Pengguna",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/user_placeholder.png'),
            ),
            const SizedBox(height: 16),
            const Text(
              "Nama Pengguna",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              "user@example.com",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[200],
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _showIzinCutiForm(context),
                  child: const Text("Ajukan Izin / Cuti"),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[400],
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RiwayatIzinPage(),
                      ),
                    );
                  },
                  child: const Text("Riwayat Izin / Cuti"),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[900],
                    minimumSize: const Size.fromHeight(45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => _confirmLogout(context),
                  child: const Text("Logout"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
