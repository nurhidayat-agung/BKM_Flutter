// import 'package:flutter/material.dart';
// import 'package:newbkmmobile/ui/pages/leave/leave_form_page.dart'; // Sesuaikan import
//
// class LeaveApplicationPage extends StatefulWidget {
//   const LeaveApplicationPage({super.key});
//
//   @override
//   State<LeaveApplicationPage> createState() => _LeaveApplicationPageState();
// }
//
// class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
//   // Data Dummy Awal (Sesuai Mockup)
//   final List<Map<String, dynamic>> _leaveHistory = [
//     {
//       "title": "Cuti Tahunan",
//       "dateApplied": "10 Nov 2025",
//       "startDate": "13 Nov 2025",
//       "endDate": "13 Nov 2025",
//       "status": "Disetujui",
//       "statusColor": const Color(0xFF4CAF50), // Hijau
//       "textColor": Colors.white,
//     },
//     {
//       "title": "Sakit",
//       "dateApplied": "10 Nov 2025",
//       "startDate": "13 Nov 2025",
//       "endDate": "13 Nov 2025",
//       "status": "Ditunda",
//       "statusColor": const Color(0xFFFDD835), // Kuning
//       "textColor": Colors.white,
//     },
//     {
//       "title": "Izin",
//       "dateApplied": "10 Nov 2025",
//       "startDate": "13 Nov 2025",
//       "endDate": "13 Nov 2025",
//       "status": "Ditolak",
//       "statusColor": const Color(0xFFE53935), // Merah
//       "textColor": Colors.white,
//     },
//   ];
//
//   // Fungsi untuk navigasi dan menangkap data balik
//   Future<void> _navigateToAddForm() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const LeaveFormPage()),
//     );
//
//     // Jika ada data yang dikirim balik (berarti sukses submit)
//     if (result != null && result is Map<String, dynamic>) {
//       setState(() {
//         // Tambahkan data baru ke paling atas list
//         _leaveHistory.insert(0, result);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const darkBlue = Color(0xFF002B4C);
//     const orange = Color(0xFFD4552F);
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       appBar: AppBar(
//         backgroundColor: darkBlue,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           "Pengajuan Cuti",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 12),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(8),
//             onTap: () => Navigator.pop(context),
//             child: Container(
//               margin: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF2C4A64),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           // TOMBOL TAMBAH (Fixed di bagian atas scroll)
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: _navigateToAddForm, // Panggil fungsi navigasi baru
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: orange,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   elevation: 0,
//                 ),
//                 child: const Text(
//                   "Tambah",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           // LIST DATA
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               itemCount: _leaveHistory.length,
//               itemBuilder: (context, index) {
//                 final item = _leaveHistory[index];
//                 return _buildLeaveCard(
//                   title: item['title'],
//                   dateApplied: item['dateApplied'],
//                   startDate: item['startDate'],
//                   endDate: item['endDate'],
//                   status: item['status'],
//                   statusColor: item['statusColor'],
//                   textColor: item['textColor'] ?? Colors.white,
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLeaveCard({
//     required String title,
//     required String dateApplied,
//     required String startDate,
//     required String endDate,
//     required String status,
//     required Color statusColor,
//     Color textColor = Colors.white,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Tgl Pengajuan : $dateApplied",
//             style: const TextStyle(
//               fontSize: 11,
//               color: Colors.grey,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF002B4C),
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: statusColor,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   status,
//                   style: TextStyle(
//                     color: textColor,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Tgl Dimulai",
//                       style: TextStyle(fontSize: 11, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       startDate,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF002B4C),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Tgl Berakhir",
//                       style: TextStyle(fontSize: 11, color: Colors.grey),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       endDate,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF002B4C),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import 'package:newbkmmobile/ui/pages/leave/leave_form_page.dart';
import 'package:newbkmmobile/ui/pages/leave/leave_detail_page.dart'; // Pastikan file detail ada

class LeaveApplicationPage extends StatefulWidget {
  const LeaveApplicationPage({super.key});

  @override
  State<LeaveApplicationPage> createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {
  // Data Dummy Awal (Sesuai source code Anda)
  final List<Map<String, dynamic>> _leaveHistory = [
    {
      "title": "Cuti Tahunan",
      "dateApplied": "10 Nov 2025",
      "startDate": "13 Nov 2025",
      "endDate": "13 Nov 2025",
      "status": "Disetujui",
      "statusColor": const Color(0xFF4CAF50), // Hijau
      "textColor": Colors.white,
      "reason": "Acara keluarga tahunan." // Tambahan dummy reason untuk detail
    },
    {
      "title": "Sakit",
      "dateApplied": "10 Nov 2025",
      "startDate": "13 Nov 2025",
      "endDate": "13 Nov 2025",
      "status": "Ditunda",
      "statusColor": const Color(0xFFFDD835), // Kuning
      "textColor": Colors.white,
      "reason": "Sakit demam."
    },
    {
      "title": "Izin",
      "dateApplied": "10 Nov 2025",
      "startDate": "13 Nov 2025",
      "endDate": "13 Nov 2025",
      "status": "Ditolak",
      "statusColor": const Color(0xFFE53935), // Merah
      "textColor": Colors.white,
      "reason": "Urusan mendadak."
    },
  ];

  // Fungsi navigasi (Logic lama tetap dipertahankan)
  Future<void> _navigateToAddForm() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LeaveFormPage()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _leaveHistory.insert(0, result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF002B4C);
    const orange = Color(0xFFD4552F);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8), // Background abu muda sesuai mockup
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
          // TOMBOL TAMBAH BESAR (Sesuai Mockup Kiri)
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

          // LIST DATA
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _leaveHistory.length,
              itemBuilder: (context, index) {
                final item = _leaveHistory[index];
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke Detail Page (Mockup Tengah)
                    // Kita oper data Map ke detail page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeaveDetailPage(data: item),
                      ),
                    );
                  },
                  child: _buildLeaveCard(
                    title: item['title'],
                    dateApplied: item['dateApplied'],
                    startDate: item['startDate'],
                    endDate: item['endDate'],
                    status: item['status'],
                    statusColor: item['statusColor'],
                    textColor: item['textColor'] ?? Colors.white,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveCard({
    required String title,
    required String dateApplied,
    required String startDate,
    required String endDate,
    required String status,
    required Color statusColor,
    Color textColor = Colors.white,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // Radius sedikit lebih besar
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // Shadow halus
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tgl Pengajuan Kecil di atas
          Text(
            "Tgl Pengajuan : $dateApplied",
            style: const TextStyle(
              fontSize: 11,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),

          // Row Judul & Status Badge Oval
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF002B4C),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20), // Oval sempurna
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Row Tanggal Mulai & Akhir
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tgl Dimulai",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      startDate,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF002B4C),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Tgl Berakhir",
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      endDate,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF002B4C),
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
