// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:newbkmmobile/models/leave//leave_model.dart';
//
// class LeaveDetailPage extends StatelessWidget {
//   final LeaveModel leave;
//   const LeaveDetailPage({super.key, required this.leave});
//
//   String _formatDate(String dateString) {
//     if (dateString.isEmpty) return "-";
//     try {
//       DateTime dt = DateTime.parse(dateString);
//       return DateFormat('dd MMM yyyy').format(dt);
//     } catch (e) {
//       return dateString;
//     }
//   }
//
//   Color _getStatusColor(String apiClass) {
//     if (apiClass.contains('success') || apiClass.toLowerCase().contains('approved')) return const Color(0xFF4CAF50);
//     if (apiClass.contains('warning') || apiClass.toLowerCase().contains('pending')) return const Color(0xFFFDD835);
//     if (apiClass.contains('danger') || apiClass.toLowerCase().contains('rejected')) return const Color(0xFFE53935);
//     return Colors.blue;
//   }
//
//   String _mapStatusName(String raw) {
//     if (raw.toLowerCase() == 'approved') return 'Disetujui';
//     if (raw.toLowerCase() == 'pending') return 'Ditunda';
//     if (raw.toLowerCase() == 'rejected') return 'Ditolak';
//     return raw;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const darkBlue = Color(0xFF002B4C);
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F6F8), // Background abu
//       appBar: AppBar(
//         backgroundColor: darkBlue,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           "Pengajuan Cuti",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 12),
//           child: InkWell(
//             borderRadius: BorderRadius.circular(8),
//             onTap: () => Navigator.pop(context),
//             child: Container(
//               margin: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(24), // Padding dalam kartu lebih besar
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Tgl Pengajuan
//               Text(
//                 "Tgl Pengajuan : ${_formatDate(leave.createdAt)}",
//                 style: const TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w600),
//               ),
//               const SizedBox(height: 12),
//
//               // Title & Status
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     leave.leaveTypeName,
//                     style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkBlue),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: _getStatusColor(leave.statusColorClass),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       _mapStatusName(leave.statusName),
//                       style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//
//               // Dates Row
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text("Tgl Dimulai", style: TextStyle(fontSize: 12, color: Colors.black54)),
//                         const SizedBox(height: 4),
//                         Text(
//                           _formatDate(leave.startDate),
//                           style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: darkBlue),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text("Tgl Berakhir", style: TextStyle(fontSize: 12, color: Colors.black54)),
//                         const SizedBox(height: 4),
//                         Text(
//                           _formatDate(leave.endDate),
//                           style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: darkBlue),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//
//               // Alasan Section
//               const Text("Alasan Cuti", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: darkBlue)),
//               const SizedBox(height: 8),
//               Text(
//                 leave.reason,
//                 style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class LeaveDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const LeaveDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF002B4C);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8), // Background Abu
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tgl Pengajuan
              Text(
                "Tgl Pengajuan : ${data['dateApplied']}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              // Title & Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: data['statusColor'],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      data['status'],
                      style: TextStyle(
                        color: data['textColor'] ?? Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Dates Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tgl Dimulai",
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data['startDate'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: darkBlue,
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
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data['endDate'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Alasan Section
              const Text(
                "Alasan Cuti",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                data['reason'] ?? "Tidak ada deskripsi alasan.",
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}