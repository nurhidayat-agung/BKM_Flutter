import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/trip/trip_bloc.dart';
import 'package:newbkmmobile/models/new_trip/delivery_response.dart';
import 'package:newbkmmobile/repositories/trip_repository.dart';
import 'package:newbkmmobile/ui/pages/trip/time_line/trip_timeline.dart';

class TripPage extends StatelessWidget {
  const TripPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TripBloc(TripRepository())..add(Trip()),
      child: const TripView(),
    );
  }
}

class TripView extends StatelessWidget {
  const TripView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengangkutan Baru"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<TripBloc, TripState>(
        builder: (context, state) {
          if (state is TripLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TripError) {
            return Center(child: Text("Error: ${state.message}"));
          }

          if (state is TripSuccess) {
            if (state.listTripResp.isEmpty) {
              return const Center(
                child: Text("Tidak ada pengangkutan baru."),
              );
            }

            final trip = state.listTripResp.first;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: _TripCard(trip),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final DeliveryData data;

  const _TripCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SAM1 → ASK
          Text(
            "${data.deliveryOrder?.status ?? '-'} → ${data.status ?? '-'}",
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 6),

          // PT. ...
          Text(
            data.deliveryOrder?.doDate ?? '',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 12),

          // Komoditi
          const Text(
            "Komoditi",
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          Text(
            data.deliveryOrder?.status ?? "CPO (Crude Palm Oil)",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 14),

          // No DO Besar
          const Text(
            "No DO Besar",
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          Text(
            data.deliveryOrder?.doNumber ?? "-",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          Text(
            data.deliveryOrder?.id ?? "",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 20),

          _row("No DO Kecil", "${data.doNumber}/${data.deliveryOrder?.quantity}"),
          const SizedBox(height: 8),
          _row("Nama Supir", data.driver?.name ?? "-"),
          const SizedBox(height: 8),
          _row("No Kendaraan", data.vehicle?.policeNumber ?? "-"),

          const SizedBox(height: 20),

          if (data.appLogs != null)
            TripTimeline(logs: data.appLogs!),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black87)),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}




// import 'package:flutter/material.dart';

// class TripPage extends StatefulWidget {
//   const TripPage({Key? key}) : super(key: key);

//   @override
//   State<TripPage> createState() => _TripPageState();
// }

// class _TripPageState extends State<TripPage> {
//   // Step 0: Awal, Step 2: Form Muat, Step 5: Form Bongkar
//   int _step = 0;

//   // Data dummy supir, kendaraan, dan DO
//   final String noDO = "051/KAL-EUP/IP-CPO/X/2025";
//   final String noDOSambung = "10002/TEST/VIII/2025";
//   final String namaSupir = "DEDI PURWANTO";
//   final String noKendaraan = "B 9501 UVX";

//   // Data input MUAT
//   final TextEditingController muatTarraController = TextEditingController();
//   final TextEditingController muatBrutoController = TextEditingController();
//   final TextEditingController muatNettoController = TextEditingController();
//   final TextEditingController muatNoSPBController = TextEditingController();

//   // Data input BONGKAR
//   final TextEditingController bongkarTarraController = TextEditingController();
//   final TextEditingController bongkarBrutoController = TextEditingController();
//   final TextEditingController bongkarNettoController = TextEditingController();
//   final TextEditingController bongkarNoSPBController = TextEditingController();

//   @override
//   void dispose() {
//     muatTarraController.dispose();
//     muatBrutoController.dispose();
//     muatNettoController.dispose();
//     muatNoSPBController.dispose();
//     bongkarTarraController.dispose();
//     bongkarBrutoController.dispose();
//     bongkarNettoController.dispose();
//     bongkarNoSPBController.dispose();
//     super.dispose();
//   }

//   // Helper untuk baris informasi (dipakai di Card Trip Info)
//   Widget _infoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title,
//               style:
//               const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//           Text(value,
//               style: const TextStyle(
//                   fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
//         ],
//       ),
//     );
//   }

//   // Widget Card Informasi Trip (sesuai PB-1)
//   Widget _buildTripInfo() {
//     return Card(
//       margin: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "SAM1 → ASK",
//               style: TextStyle(
//                   color: Colors.orange,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16),
//             ),
//             const SizedBox(height: 4),
//             const Text("PT. Subur Arum Makmur 1 → PT. Adhitya Serayakorita"),
//             const SizedBox(height: 8),
//             const Text("Komoditi",
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             const Text("CPO (Crud Palm Oil)",
//                 style: TextStyle(color: Colors.black54)),
//             const SizedBox(height: 8),
//             const Text("No DO Besar",
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             Text(noDO,
//                 style:
//                 const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//             Text(noDOSambung, style: const TextStyle(color: Colors.black54)),
//             const Divider(height: 20),
//             _infoRow("No DO Kecil", "01/15"),
//             _infoRow("Nama Supir", namaSupir),
//             _infoRow("No Kendaraan", noKendaraan),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget TextField (digunakan di form muat dan bongkar)
//   Widget _textField(TextEditingController controller, String label) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: TextField(
//         controller: controller,
//         keyboardType: TextInputType.number, // Biasanya input angka untuk berat
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//           isDense: true,
//         ),
//       ),
//     );
//   }

//   // Widget Tombol Utama
//   Widget _buildButton(String text, VoidCallback onPressed,
//       {Color color = Colors.deepOrange}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: color,
//           minimumSize: const Size(double.infinity, 50),
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(
//               color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }

//   // Widget Form Input MUAT (PB-3)
//   Widget _buildFormMuat() {
//     return Card(
//       margin: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("MUAT",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.black54)),
//             const SizedBox(height: 8),
//             // --- DO UTAMA ---
//             Text("DO : $noDO",
//                 style:
//                 const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//             const SizedBox(height: 8),
//             _textField(muatNoSPBController, "No. SPB"),
//             _textField(muatTarraController, "Jumlah Tarra Muat"),
//             _textField(muatBrutoController, "Jumlah Bruto Muat"),
//             _textField(muatNettoController, "Netto Muat (Kg)"),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF002B4C),
//               ),
//               child: const Text("Unggah Foto SPB", style: TextStyle(color: Colors.white)),
//             ),
//             const SizedBox(height: 20),
//             // --- DO SAMBUNG ---
//             Text("DO Sambung : $noDOSambung",
//                 style:
//                 const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//             const SizedBox(height: 8),
//             _textField(TextEditingController(), "No. SPB"),
//             _textField(TextEditingController(), "Jumlah Tarra Muat"),
//             _textField(TextEditingController(), "Jumlah Bruto Muat"),
//             _textField(TextEditingController(), "Netto Muat (Kg)"),
//             const SizedBox(height: 12),
//             _buildButton("Simpan", () {
//               // Validasi input di sini
//               setState(() => _step = 3);
//             }, color: Colors.red), // Menggunakan warna merah/oranye tua sesuai contoh
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget Form Input BONGKAR (PB-6)
//   Widget _buildFormBongkar() {
//     return Card(
//       margin: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("BONGKAR",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.black54)),
//             const SizedBox(height: 8),
//             // --- DO UTAMA ---
//             Text("DO : $noDO",
//                 style:
//                 const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//             const SizedBox(height: 8),
//             _textField(bongkarTarraController, "Jumlah Tarra Bongkar"),
//             _textField(bongkarBrutoController, "Jumlah Bruto Bongkar"),
//             _textField(bongkarNettoController, "Netto Bongkar (Kg)"),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF002B4C),
//               ),
//               child: const Text("Unggah Foto SPB", style: TextStyle(color: Colors.white)),
//             ),
//             const SizedBox(height: 20),
//             // --- DO SAMBUNG ---
//             Text("DO Sambung : $noDOSambung",
//                 style:
//                 const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//             const SizedBox(height: 8),
//             _textField(TextEditingController(), "Jumlah Tarra Bongkar"),
//             _textField(TextEditingController(), "Jumlah Bruto Bongkar"),
//             _textField(TextEditingController(), "Netto Bongkar (Kg)"),
//             const SizedBox(height: 12),
//             _buildButton("Simpan", () {
//               // Validasi input di sini
//               setState(() => _step = 6);
//             }, color: Colors.red), // Menggunakan warna merah/oranye tua sesuai contoh
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget Status Ringkasan Muat/Bongkar (PB-4 & PB-5)
//   Widget _buildStatusContainer(String title, {bool isEditable = false}) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: Colors.grey.shade300)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//                 fontWeight: FontWeight.bold, color: Colors.black54),
//           ),
//           if (isEditable)
//             GestureDetector(
//               onTap: () {
//                 // Tambahkan logika untuk edit (kembali ke form)
//               },
//               child: const Text("EDIT",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.orange)),
//             ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Ubah content menjadi nullable Widget
//     Widget? content;
//     String buttonText = '';
//     VoidCallback? buttonAction;
//     // showTripInfo tidak diperlukan lagi jika kita mengatur semua di dalam switch

//     // Logika Alur
//     switch (_step) {
//       case 0:
//         content = _buildTripInfo();
//         buttonText = "Menuju Lokasi Muat";
//         buttonAction = () => setState(() => _step = 1);
//         break;
//       case 1:
//         content = _buildTripInfo();
//         buttonText = "Tiba Lokasi Muat";
//         buttonAction = () => setState(() => _step = 2);
//         break;
//       case 2:
//       // Gabungkan TripInfo dan Form Muat di sini
//         content = Column(children: [_buildTripInfo(), _buildFormMuat()]);
//         buttonAction = null; // Tombol ada di dalam form _buildFormMuat()
//         break;
//       case 3:
//         content = Column(
//           children: [
//             _buildTripInfo(),
//             _buildStatusContainer("MUAT"),
//           ],
//         );
//         buttonText = "Menuju Lokasi Bongkar";
//         buttonAction = () => setState(() => _step = 4);
//         break;
//       case 4:
//         content = Column(
//           children: [
//             _buildTripInfo(),
//             _buildStatusContainer("MUAT"),
//           ],
//         );
//         buttonText = "Tiba Lokasi Bongkar";
//         buttonAction = () => setState(() => _step = 5);
//         break;
//       case 5:
//       // Gabungkan TripInfo, Status Muat, dan Form Bongkar di sini
//         content = Column(children: [
//           _buildTripInfo(),
//           _buildStatusContainer("MUAT"),
//           _buildFormBongkar(), // Form Bongkar Baru
//         ]);
//         buttonAction = null; // Tombol ada di dalam form _buildFormBongkar()
//         break;
//       case 6:
//         content = Column(
//           children: [
//             _buildTripInfo(),
//             _buildStatusContainer("EDIT MUAT", isEditable: true),
//             _buildStatusContainer("EDIT BONGKAR", isEditable: true),
//           ],
//         );
//         buttonText = "Selesai";
//         buttonAction = () {
//           // Logika untuk menyelesaikan trip
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//               content: Text("Proses pengangkutan selesai ✅")));
//           setState(() => _step = 0);
//         };
//         break;
//       default:
//         content = Container();
//     }

//     // Menggabungkan konten dan tombol dengan operator null-aware
//     List<Widget> children = [];

//     // Tambahkan konten utama (content tidak mungkin null karena semua case di handle)
//     // Jika content adalah Column (step 2, 3, 4, 5, 6), ambil children-nya
//     if (content is Column) {
//       children.addAll(content.children);
//     } else if (content != null) {
//       // Jika content adalah widget tunggal (step 0, 1), tambahkan langsung
//       children.add(content);
//     }

//     // Tambahkan tombol di akhir jika ada
//     if (buttonAction != null) {
//       children.add(_buildButton(buttonText, buttonAction!));
//     }


//     return Scaffold(
//       backgroundColor: Colors.grey.shade100, // Background lebih cerah
//       appBar: AppBar(
//         // Sesuai PDF, header terintegrasi dengan AppBar
//         title: const Text(
//           "Pengangkutan Baru",
//           style: TextStyle(
//               color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF002B4C),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: children,
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newbkmmobile/blocs/trip/trip_bloc.dart';
// import 'package:newbkmmobile/core/r.dart';
// import 'package:newbkmmobile/repositories/trip_repository.dart';
// import 'package:newbkmmobile/ui/pages/trip/trip_detail_page.dart';
// import 'package:newbkmmobile/ui/pages/trip/trip_row.dart';
//
// class TripPage extends StatefulWidget {
//   const TripPage({Key? key}) : super(key: key);
//
//   @override
//   State<TripPage> createState() => _TripPageState();
// }
//
// class _TripPageState extends State<TripPage> {
//   final _tripBloc = TripBloc(TripRepository());
//
//   @override
//   void initState() {
//     super.initState();
//     _tripBloc.add(Trip());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(R.strings.titleTripPage),
//       ),
//       backgroundColor: Colors.grey[100]!,
//       body: SafeArea(
//         child: BlocBuilder<TripBloc, TripState>(
//           bloc: _tripBloc,
//           builder: (context, state) {
//             if (state is TripInitial) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is TripLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is TripSuccess) {
//               if (state.listTripResp.isNotEmpty) {
//                 return ListView.builder(
//                     itemCount: state.listTripResp.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) =>
//                                   TripDetailPage(id: state.listTripResp[index].id ?? "")
//                           )).then((value) => setState(() {
//                             _tripBloc.add(Trip());
//                           }));
//                         },
//                         child: TripRow(tripResp: state.listTripResp[index]),
//                       );
//                     }
//                 );
//               } else {
//                 return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           R.assets.imgNoFeed,
//                           scale: 6.0,
//                         ),
//                         Text(
//                           R.strings.emptyData,
//                           style: const TextStyle(
//                             fontSize: 14.0,
//                           ),
//                         ),
//                       ],
//                     ),
//                 );
//               }
//             } else if (state is TripError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.error,
//                       color: Colors.red,
//                       size: 50.0,
//                     ),
//                     Text(
//                       state.message,
//                       style: const TextStyle(
//                         fontSize: 14.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//             throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text(R.strings.errorWidget)));
//           },
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:newbkmmobile/blocs/trip/trip_bloc.dart';
// import 'package:newbkmmobile/core/r.dart';
// import 'package:newbkmmobile/repositories/trip_repository.dart';
// import 'package:newbkmmobile/ui/pages/trip/trip_detail_page.dart';
// import 'package:newbkmmobile/ui/pages/trip/trip_row.dart';
//
// class TripPage extends StatefulWidget {
//   const TripPage({Key? key}) : super(key: key);
//
//   @override
//   State<TripPage> createState() => _TripPageState();
// }
//
// class _TripPageState extends State<TripPage> {
//   final _tripBloc = TripBloc(TripRepository());
//   String _status = "mulai"; // mulai → menuju_muat → muat → menuju_bongkar → bongkar → selesai
//
//   @override
//   void initState() {
//     super.initState();
//     _tripBloc.add(Trip());
//   }
//
//   void _nextStep() {
//     setState(() {
//       switch (_status) {
//         case "mulai":
//           _status = "menuju_muat";
//           break;
//         case "menuju_muat":
//           _status = "muat";
//           break;
//         case "muat":
//           _status = "menuju_bongkar";
//           break;
//         case "menuju_bongkar":
//           _status = "bongkar";
//           break;
//         case "bongkar":
//           _status = "selesai";
//           break;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(R.strings.titleTripPage),
//         backgroundColor: const Color(0xFF002E5B),
//       ),
//       backgroundColor: Colors.grey[100],
//       body: SafeArea(
//         child: BlocBuilder<TripBloc, TripState>(
//           bloc: _tripBloc,
//           builder: (context, state) {
//             if (state is TripInitial || state is TripLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is TripSuccess) {
//               if (state.listTripResp.isNotEmpty) {
//                 // 🔹 Jika ada data trip → tampilkan daftar trip (kode asli)
//                 return ListView.builder(
//                   itemCount: state.listTripResp.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(
//                             builder: (context) => TripDetailPage(
//                                 id: state.listTripResp[index].id ?? "")))
//                             .then((value) => setState(() {
//                           _tripBloc.add(Trip());
//                         }));
//                       },
//                       child: TripRow(tripResp: state.listTripResp[index]),
//                     );
//                   },
//                 );
//               } else {
//                 // 🔹 Jika data kosong → tampilkan UI Pengangkutan Baru
//                 return _buildTripSimulationUI();
//               }
//             } else if (state is TripError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.error, color: Colors.red, size: 50),
//                     Text(state.message,
//                         style: const TextStyle(fontSize: 14.0)),
//                   ],
//                 ),
//               );
//             }
//
//             return Center(child: Text(R.strings.errorWidget));
//           },
//         ),
//       ),
//     );
//   }
//
//   // 🔹 UI Simulasi Perjalanan Bongkar/Muat
//   Widget _buildTripSimulationUI() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           // 🔸 Informasi Kendaraan / DO
//           Card(
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             elevation: 3,
//             child: Padding(
//               padding: const EdgeInsets.all(14.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Informasi Kendaraan / DO",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87),
//                   ),
//                   const Divider(),
//                   _infoRow("No. Polisi", "BK 1234 CD"),
//                   _infoRow("Tujuan Muat", "PKS Sei Mangke"),
//                   _infoRow("Tujuan Bongkar", "Gudang Medan"),
//                   _infoRow("Tanggal",
//                       DateFormat('dd MMM yyyy').format(DateTime.now())),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),
//
//           // 🔸 Status perjalanan saat ini
//           Text(
//             _getStatusTitle(),
//             style: const TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
//           ),
//           const SizedBox(height: 20),
//
//           // 🔸 Tombol dinamis
//           _buildActionButton(),
//         ],
//       ),
//     );
//   }
//
//   Widget _infoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 14)),
//           Text(value,
//               style: const TextStyle(
//                   fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButton() {
//     String buttonText = "";
//     Color buttonColor = Colors.orange;
//
//     switch (_status) {
//       case "mulai":
//         buttonText = "Menuju Lokasi Muat";
//         buttonColor = Colors.orange;
//         break;
//       case "menuju_muat":
//         buttonText = "Muat";
//         buttonColor = Colors.green;
//         break;
//       case "muat":
//         buttonText = "Menuju Lokasi Bongkar";
//         buttonColor = Colors.orange;
//         break;
//       case "menuju_bongkar":
//         buttonText = "Bongkar";
//         buttonColor = Colors.green;
//         break;
//       case "bongkar":
//         buttonText = "Selesai";
//         buttonColor = Colors.blueAccent;
//         break;
//       case "selesai":
//         buttonText = "Perjalanan Selesai";
//         buttonColor = Colors.grey;
//         break;
//     }
//
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: buttonColor,
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 60),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//       onPressed: _status == "selesai" ? null : _nextStep,
//       child: Text(
//         buttonText,
//         style: const TextStyle(
//             color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
//       ),
//     );
//   }
//
//   String _getStatusTitle() {
//     switch (_status) {
//       case "mulai":
//         return "Mulai Perjalanan";
//       case "menuju_muat":
//         return "Sedang Menuju Lokasi Muat";
//       case "muat":
//         return "Proses Muat";
//       case "menuju_bongkar":
//         return "Sedang Menuju Lokasi Bongkar";
//       case "bongkar":
//         return "Proses Bongkar";
//       case "selesai":
//         return "Perjalanan Selesai";
//       default:
//         return "";
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:newbkmmobile/blocs/trip/trip_bloc.dart';
// import 'package:newbkmmobile/core/r.dart';
// import 'package:newbkmmobile/repositories/trip_repository.dart';
// import 'package:newbkmmobile/ui/pages/trip/trip_detail_page.dart';
// import 'package:newbkmmobile/ui/pages/trip/trip_row.dart';
//
// class TripPage extends StatefulWidget {
//   const TripPage({Key? key}) : super(key: key);
//
//   @override
//   State<TripPage> createState() => _TripPageState();
// }
//
// class _TripPageState extends State<TripPage> {
//   final _tripBloc = TripBloc(TripRepository());
//   String _status = "mulai"; // mulai → menuju_muat → muat → menuju_bongkar → bongkar → selesai
//
//   @override
//   void initState() {
//     super.initState();
//     _tripBloc.add(Trip());
//   }
//
//   void _nextStep() {
//     setState(() {
//       switch (_status) {
//         case "mulai":
//           _status = "menuju_muat";
//           break;
//         case "menuju_muat":
//           _status = "muat";
//           break;
//         case "muat":
//           _status = "menuju_bongkar";
//           break;
//         case "menuju_bongkar":
//           _status = "bongkar";
//           break;
//         case "bongkar":
//           _status = "selesai";
//           break;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//
//       // 🔹 AppBar seperti halaman Profil
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 2,
//         centerTitle: true,
//         title: const Text(
//           'Perjalanan',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.orange),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//
//       body: SafeArea(
//         child: BlocBuilder<TripBloc, TripState>(
//           bloc: _tripBloc,
//           builder: (context, state) {
//             if (state is TripInitial || state is TripLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is TripSuccess) {
//               if (state.listTripResp.isNotEmpty) {
//                 // 🔹 Jika ada data trip → tampilkan daftar trip
//                 return ListView.builder(
//                   itemCount: state.listTripResp.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(
//                           builder: (context) => TripDetailPage(
//                               id: state.listTripResp[index].id ?? ""),
//                         ))
//                             .then((value) => setState(() {
//                           _tripBloc.add(Trip());
//                         }));
//                       },
//                       child: TripRow(tripResp: state.listTripResp[index]),
//                     );
//                   },
//                 );
//               } else {
//                 // 🔹 Jika tidak ada data trip → tampilkan simulasi
//                 return _buildTripSimulationUI();
//               }
//             } else if (state is TripError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.error, color: Colors.red, size: 50),
//                     Text(state.message,
//                         style: const TextStyle(fontSize: 14.0)),
//                   ],
//                 ),
//               );
//             }
//
//             return Center(child: Text(R.strings.errorWidget));
//           },
//         ),
//       ),
//     );
//   }
//
//   // 🔹 UI simulasi trip
//   Widget _buildTripSimulationUI() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           // 🔸 Informasi Kendaraan / DO
//           Card(
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             elevation: 3,
//             child: Padding(
//               padding: const EdgeInsets.all(14.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Informasi Kendaraan / DO",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87),
//                   ),
//                   const Divider(),
//                   _infoRow("No. Polisi", "BK 1234 CD"),
//                   _infoRow("Tujuan Muat", "PKS Sei Mangke"),
//                   _infoRow("Tujuan Bongkar", "Gudang Medan"),
//                   _infoRow("Tanggal",
//                       DateFormat('dd MMM yyyy').format(DateTime.now())),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),
//
//           // 🔸 Status perjalanan saat ini
//           Text(
//             _getStatusTitle(),
//             style: const TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
//           ),
//           const SizedBox(height: 20),
//
//           // 🔸 Tombol aksi seperti profil (rounded & lembut)
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.pink[200],
//               minimumSize: const Size.fromHeight(45),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//             ),
//             onPressed: _status == "selesai" ? null : _nextStep,
//             child: Text(
//               _getButtonText(),
//               style: const TextStyle(
//                   color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _infoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 14)),
//           Text(value,
//               style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87)),
//         ],
//       ),
//     );
//   }
//
//   String _getButtonText() {
//     switch (_status) {
//       case "mulai":
//         return "Menuju Lokasi Muat";
//       case "menuju_muat":
//         return "Muat";
//       case "muat":
//         return "Menuju Lokasi Bongkar";
//       case "menuju_bongkar":
//         return "Bongkar";
//       case "bongkar":
//         return "Selesai";
//       case "selesai":
//         return "Perjalanan Selesai";
//       default:
//         return "";
//     }
//   }
//
//   String _getStatusTitle() {
//     switch (_status) {
//       case "mulai":
//         return "Mulai Perjalanan";
//       case "menuju_muat":
//         return "Sedang Menuju Lokasi Muat";
//       case "muat":
//         return "Proses Muat";
//       case "menuju_bongkar":
//         return "Sedang Menuju Lokasi Bongkar";
//       case "bongkar":
//         return "Proses Bongkar";
//       case "selesai":
//         return "Perjalanan Selesai";
//       default:
//         return "";
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:newbkmmobile/blocs/trip/trip_bloc.dart';
// import 'package:newbkmmobile/core/r.dart';
// import 'package:newbkmmobile/repositories/trip_repository.dart';
// import 'package:newbkmmobile/ui/pages/trip/trip_detail_page.dart';
// import 'package:newbkmmobile/ui/pages/trip/trip_row.dart';
//
// class TripPage extends StatefulWidget {
//   const TripPage({Key? key}) : super(key: key);
//
//   @override
//   State<TripPage> createState() => _TripPageState();
// }
//
// class _TripPageState extends State<TripPage> {
//   final _tripBloc = TripBloc(TripRepository());
//   String _status = "mulai";
//
//   @override
//   void initState() {
//     super.initState();
//     _tripBloc.add(Trip());
//   }
//
//   void _nextStep() {
//     setState(() {
//       switch (_status) {
//         case "mulai":
//           _status = "menuju_muat";
//           break;
//         case "menuju_muat":
//           _status = "muat";
//           break;
//         case "muat":
//           _status = "menuju_bongkar";
//           break;
//         case "menuju_bongkar":
//           _status = "bongkar";
//           break;
//         case "bongkar":
//           _status = "selesai";
//           break;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//
//       // 🔹 Ubah hanya bagian AppBar seperti halaman Profil
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 2,
//         centerTitle: true,
//         title: const Text(
//           'Perjalanan',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.orange),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//
//       body: SafeArea(
//         child: BlocBuilder<TripBloc, TripState>(
//           bloc: _tripBloc,
//           builder: (context, state) {
//             if (state is TripInitial || state is TripLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is TripSuccess) {
//               if (state.listTripResp.isNotEmpty) {
//                 return ListView.builder(
//                   itemCount: state.listTripResp.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(
//                           builder: (context) => TripDetailPage(
//                               id: state.listTripResp[index].id ?? ""),
//                         ))
//                             .then((value) => setState(() {
//                           _tripBloc.add(Trip());
//                         }));
//                       },
//                       child: TripRow(tripResp: state.listTripResp[index]),
//                     );
//                   },
//                 );
//               } else {
//                 return _buildTripSimulationUI();
//               }
//             } else if (state is TripError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.error, color: Colors.red, size: 50),
//                     Text(state.message,
//                         style: const TextStyle(fontSize: 14.0)),
//                   ],
//                 ),
//               );
//             }
//
//             return Center(child: Text(R.strings.errorWidget));
//           },
//         ),
//       ),
//     );
//   }
//
//   // 🔹 UI Simulasi Perjalanan
//   Widget _buildTripSimulationUI() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           // 🔸 Informasi Kendaraan / DO
//           Card(
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             elevation: 3,
//             child: Padding(
//               padding: const EdgeInsets.all(14.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Informasi Kendaraan / DO",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87),
//                   ),
//                   const Divider(),
//                   _infoRow("No. Polisi", "BK 1234 CD"),
//                   _infoRow("Tujuan Muat", "PKS Sei Mangke"),
//                   _infoRow("Tujuan Bongkar", "Gudang Medan"),
//                   _infoRow("Tanggal",
//                       DateFormat('dd MMM yyyy').format(DateTime.now())),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),
//
//           // 🔸 Status perjalanan saat ini
//           Text(
//             _getStatusTitle(),
//             style: const TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
//           ),
//           const SizedBox(height: 20),
//
//           // 🔸 Tombol dinamis (biarkan sesuai kode lama)
//           _buildActionButton(),
//         ],
//       ),
//     );
//   }
//
//   Widget _infoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 14)),
//           Text(value,
//               style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButton() {
//     String buttonText = "";
//     Color buttonColor = Colors.orange;
//
//     switch (_status) {
//       case "mulai":
//         buttonText = "Menuju Lokasi Muat";
//         buttonColor = Colors.orange;
//         break;
//       case "menuju_muat":
//         buttonText = "Muat";
//         buttonColor = Colors.green;
//         break;
//       case "muat":
//         buttonText = "Menuju Lokasi Bongkar";
//         buttonColor = Colors.orange;
//         break;
//       case "menuju_bongkar":
//         buttonText = "Bongkar";
//         buttonColor = Colors.green;
//         break;
//       case "bongkar":
//         buttonText = "Selesai";
//         buttonColor = Colors.blueAccent;
//         break;
//       case "selesai":
//         buttonText = "Perjalanan Selesai";
//         buttonColor = Colors.grey;
//         break;
//     }
//
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: buttonColor,
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 60),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//       onPressed: _status == "selesai" ? null : _nextStep,
//       child: Text(
//         buttonText,
//         style: const TextStyle(
//             color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
//       ),
//     );
//   }
//
//   String _getStatusTitle() {
//     switch (_status) {
//       case "mulai":
//         return "Mulai Perjalanan";
//       case "menuju_muat":
//         return "Sedang Menuju Lokasi Muat";
//       case "muat":
//         return "Proses Muat";
//       case "menuju_bongkar":
//         return "Sedang Menuju Lokasi Bongkar";
//       case "bongkar":
//         return "Proses Bongkar";
//       case "selesai":
//         return "Perjalanan Selesai";
//       default:
//         return "";
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:newbkmmobile/blocs/trip/trip_bloc.dart';
// import 'package:newbkmmobile/core/r.dart';
// import 'package:newbkmmobile/repositories/trip_repository.dart';
// import 'package:newbkmmobile/ui/pages/trip/trip_detail_page.dart';
// import 'package:newbkmmobile/ui/pages/trip/trip_row.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class TripPage extends StatefulWidget {
//   const TripPage({Key? key}) : super(key: key);
//
//   @override
//   State<TripPage> createState() => _TripPageState();
// }
//
// class _TripPageState extends State<TripPage> {
//   final _tripBloc = TripBloc(TripRepository());
//   String _status = "mulai";
//
//   Map<String, String> _pengangkutanData = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _tripBloc.add(Trip());
//     _loadPengangkutanData();
//   }
//
//   Future<void> _loadPengangkutanData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final barang = prefs.getString('barang');
//     final berat = prefs.getString('berat');
//     final supir = prefs.getString('supir');
//     if (barang != null && berat != null && supir != null) {
//       setState(() {
//         _pengangkutanData = {
//           'barang': barang,
//           'berat': berat,
//           'supir': supir,
//         };
//       });
//     }
//   }
//
//   Future<void> _savePengangkutanData(Map<String, String> data) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('barang', data['barang'] ?? '');
//     await prefs.setString('berat', data['berat'] ?? '');
//     await prefs.setString('supir', data['supir'] ?? '');
//   }
//
//   Future<void> _clearPengangkutanData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('barang');
//     await prefs.remove('berat');
//     await prefs.remove('supir');
//   }
//
//   // 🔹 Tombol Next Step
//   void _nextStep() async {
//     if (_status == "menuju_muat") {
//       await _showInputPengangkutanDialog();
//       return;
//     }
//
//     // 🔹 Saat status bongkar, tampilkan konfirmasi dulu
//     if (_status == "bongkar") {
//       final confirm = await _showConfirmDialog();
//       if (confirm == true) {
//         await _clearPengangkutanData();
//         setState(() {
//           _pengangkutanData.clear();
//           _status = "selesai";
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content:
//             Text("Proses bongkar selesai. Data pengangkutan telah dihapus."),
//             backgroundColor: Colors.blueAccent,
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//       return;
//     }
//
//     setState(() {
//       _status = _getNextStatus(_status);
//     });
//   }
//
//   // 🔹 Konfirmasi sebelum hapus data
//   Future<bool?> _showConfirmDialog() async {
//     return showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Konfirmasi Bongkar"),
//         content: const Text(
//           "Apakah Anda yakin ingin menyelesaikan proses bongkar?\nSemua data pengangkutan akan dihapus.",
//           style: TextStyle(fontSize: 15),
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         actions: [
//           TextButton(
//             child: const Text("Batal"),
//             onPressed: () => Navigator.pop(context, false),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             child: const Text("Ya, Selesai"),
//             onPressed: () => Navigator.pop(context, true),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _getNextStatus(String current) {
//     switch (current) {
//       case "mulai":
//         return "menuju_muat";
//       case "menuju_muat":
//         return "muat";
//       case "muat":
//         return "menuju_bongkar";
//       case "menuju_bongkar":
//         return "bongkar";
//       case "bongkar":
//         return "selesai";
//       default:
//         return current;
//     }
//   }
//
//   // 🔹 Popup input data pengangkutan
//   Future<void> _showInputPengangkutanDialog() async {
//     final TextEditingController barangController = TextEditingController();
//     final TextEditingController beratController = TextEditingController();
//     final TextEditingController supirController = TextEditingController();
//
//     final result = await showDialog<Map<String, String>>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Muat'),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         content: SingleChildScrollView(
//           child: Column(
//             children: [
//               TextField(
//                 controller: barangController,
//                 decoration: const InputDecoration(
//                   labelText: 'Nama Barang',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: beratController,
//                 decoration: const InputDecoration(
//                   labelText: 'Berat (Kg)',
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 controller: supirController,
//                 decoration: const InputDecoration(
//                   labelText: 'Nama Supir',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             child: const Text('Batal'),
//             onPressed: () => Navigator.pop(context),
//           ),
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
//             onPressed: () {
//               if (barangController.text.isNotEmpty &&
//                   beratController.text.isNotEmpty &&
//                   supirController.text.isNotEmpty) {
//                 Navigator.pop(context, {
//                   'barang': barangController.text,
//                   'berat': beratController.text,
//                   'supir': supirController.text,
//                 });
//               }
//             },
//             child: const Text('Simpan'),
//           ),
//         ],
//       ),
//     );
//
//     if (result != null) {
//       await _savePengangkutanData(result);
//       setState(() {
//         _pengangkutanData = result;
//         _status = "muat";
//       });
//     }
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
//           'Perjalanan',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.orange),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: BlocBuilder<TripBloc, TripState>(
//           bloc: _tripBloc,
//           builder: (context, state) {
//             if (state is TripInitial || state is TripLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is TripSuccess) {
//               if (state.listTripResp.isNotEmpty) {
//                 return ListView.builder(
//                   itemCount: state.listTripResp.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.of(context)
//                             .push(MaterialPageRoute(
//                           builder: (context) => TripDetailPage(
//                               id: state.listTripResp[index].id ?? ""),
//                         ))
//                             .then((value) => setState(() {
//                           _tripBloc.add(Trip());
//                         }));
//                       },
//                       child: TripRow(tripResp: state.listTripResp[index]),
//                     );
//                   },
//                 );
//               } else {
//                 return _buildTripSimulationUI();
//               }
//             } else if (state is TripError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.error, color: Colors.red, size: 50),
//                     Text(state.message,
//                         style: const TextStyle(fontSize: 14.0)),
//                   ],
//                 ),
//               );
//             }
//
//             return Center(child: Text(R.strings.errorWidget));
//           },
//         ),
//       ),
//     );
//   }
//
//   // 🔹 UI simulasi perjalanan
//   Widget _buildTripSimulationUI() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           Card(
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             elevation: 3,
//             child: Padding(
//               padding: const EdgeInsets.all(14.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Informasi Kendaraan / DO",
//                     style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87),
//                   ),
//                   const Divider(),
//                   _infoRow("No. Polisi", "BK 1234 CD"),
//                   _infoRow("Tujuan Muat", "PKS Sei Mangke"),
//                   _infoRow("Tujuan Bongkar", "Gudang Medan"),
//                   _infoRow("Tanggal",
//                       DateFormat('dd MMM yyyy').format(DateTime.now())),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 30),
//           Text(
//             _getStatusTitle(),
//             style: const TextStyle(
//                 fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
//           ),
//           const SizedBox(height: 20),
//
//           if (_pengangkutanData.isNotEmpty)
//             Card(
//               color: Colors.white,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               elevation: 2,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   children: [
//                     const Text(
//                       "Data Pengangkutan",
//                       style:
//                       TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                     ),
//                     const Divider(),
//                     _infoRow("Barang", _pengangkutanData['barang'] ?? "-"),
//                     _infoRow("Berat (Kg)", _pengangkutanData['berat'] ?? "-"),
//                     _infoRow("Supir", _pengangkutanData['supir'] ?? "-"),
//                   ],
//                 ),
//               ),
//             ),
//           const SizedBox(height: 20),
//
//           _buildActionButton(),
//         ],
//       ),
//     );
//   }
//
//   Widget _infoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 14)),
//           Text(value,
//               style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButton() {
//     String buttonText = "";
//     Color buttonColor = Colors.orange;
//
//     switch (_status) {
//       case "mulai":
//         buttonText = "Menuju Lokasi Muat";
//         buttonColor = Colors.orange;
//         break;
//       case "menuju_muat":
//         buttonText = "Muat";
//         buttonColor = Colors.green;
//         break;
//       case "muat":
//         buttonText = "Menuju Lokasi Bongkar";
//         buttonColor = Colors.orange;
//         break;
//       case "menuju_bongkar":
//         buttonText = "Bongkar";
//         buttonColor = Colors.green;
//         break;
//       case "bongkar":
//         buttonText = "Selesai";
//         buttonColor = Colors.blueAccent;
//         break;
//       case "selesai":
//         buttonText = "Perjalanan Selesai";
//         buttonColor = Colors.grey;
//         break;
//     }
//
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: buttonColor,
//         padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 60),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//       onPressed: _status == "selesai" ? null : _nextStep,
//       child: Text(
//         buttonText,
//         style: const TextStyle(
//             color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
//       ),
//     );
//   }
//
//   String _getStatusTitle() {
//     switch (_status) {
//       case "mulai":
//         return "Mulai Perjalanan";
//       case "menuju_muat":
//         return "Sedang Menuju Lokasi Muat";
//       case "muat":
//         return "Proses Muat";
//       case "menuju_bongkar":
//         return "Sedang Menuju Lokasi Bongkar";
//       case "bongkar":
//         return "Proses Bongkar";
//       case "selesai":
//         return "Perjalanan Selesai";
//       default:
//         return "";
//     }
//   }
// }

// import 'package:flutter/material.dart';
//
// class TripPage extends StatefulWidget {
//   const TripPage({Key? key}) : super(key: key);
//
//   @override
//   State<TripPage> createState() => _TripPageState();
// }
//
// class _TripPageState extends State<TripPage> {
//   int _step = 0;
//
//   // Data dummy supir, kendaraan, dan DO
//   final String noDO = "051/KAL-EUP/IP-CPO/X/2025";
//   final String noDOSambung = "10002/TEST/VIII/2025";
//   final String namaSupir = "DEDI PURWANTO";
//   final String noKendaraan = "B 9501 UVX";
//
//   // Data input muat
//   final TextEditingController tarraController = TextEditingController();
//   final TextEditingController brutoController = TextEditingController();
//   final TextEditingController nettoController = TextEditingController();
//   final TextEditingController noSPBController = TextEditingController();
//
//   Widget _buildHeader() {
//     return Container(
//       color: const Color(0xFF002B4C),
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: const Center(
//         child: Text(
//           "Pengangkutan Baru",
//           style: TextStyle(
//               color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTripInfo() {
//     return Card(
//       margin: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "SAM1 → ASK",
//               style: TextStyle(
//                   color: Colors.orange,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16),
//             ),
//             const SizedBox(height: 4),
//             const Text("PT. Subur Arum Makmur 1 → PT. Adhitya Serayakorita"),
//             const SizedBox(height: 8),
//             const Text("Komoditi",
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             const Text("CPO (Crud Palm Oil)",
//                 style: TextStyle(color: Colors.black54)),
//             const SizedBox(height: 8),
//             const Text("No DO Besar",
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             Text(noDO,
//                 style:
//                 const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//             Text(noDOSambung, style: const TextStyle(color: Colors.black54)),
//             const Divider(height: 20),
//             _infoRow("No DO Kecil", "01/15"),
//             _infoRow("Nama Supir", namaSupir),
//             _infoRow("No Kendaraan", noKendaraan),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _infoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title,
//               style:
//               const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//           Text(value,
//               style: const TextStyle(
//                   fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildButton(String text, VoidCallback onPressed) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.orange,
//           minimumSize: const Size(double.infinity, 50),
//           shape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: Text(
//           text,
//           style: const TextStyle(
//               color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFormMuat() {
//     return Card(
//       margin: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("MUAT",
//                 style: TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.black54)),
//             const SizedBox(height: 8),
//             Text("DO : $noDO",
//                 style:
//                 const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//             const SizedBox(height: 8),
//             _textField(noSPBController, "No. SPB"),
//             _textField(tarraController, "Jumlah Tarra Muat"),
//             _textField(brutoController, "Jumlah Bruto Muat"),
//             _textField(nettoController, "Netto Muat (Kg)"),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF002B4C),
//               ),
//               child: const Text("Unggah Foto"),
//             ),
//             const SizedBox(height: 20),
//             Text("DO Sambung : $noDOSambung",
//                 style:
//                 const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//             _textField(TextEditingController(), "No. SPB"),
//             _textField(TextEditingController(), "Jumlah Tarra Muat"),
//             _textField(TextEditingController(), "Jumlah Bruto Muat"),
//             _textField(TextEditingController(), "Netto Muat (Kg)"),
//             const SizedBox(height: 12),
//             _buildButton("Simpan", () {
//               setState(() => _step = 3);
//             }),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _textField(TextEditingController controller, String label) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//           isDense: true,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget content;
//
//     switch (_step) {
//       case 0:
//         content = Column(
//           children: [
//             _buildTripInfo(),
//             _buildButton("Menuju Lokasi Muat", () {
//               setState(() => _step = 1);
//             }),
//           ],
//         );
//         break;
//       case 1:
//         content = Column(
//           children: [
//             _buildTripInfo(),
//             _buildButton("Tiba Lokasi Muat", () {
//               setState(() => _step = 2);
//             }),
//           ],
//         );
//         break;
//       case 2:
//         content = Column(
//           children: [
//             _buildTripInfo(),
//             _buildFormMuat(),
//           ],
//         );
//         break;
//       case 3:
//         content = Column(
//           children: [
//             _buildTripInfo(),
//             const SizedBox(height: 8),
//             Container(
//               width: double.infinity,
//               margin: const EdgeInsets.symmetric(horizontal: 16),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade300)),
//               child: const Center(
//                 child: Text(
//                   "MUAT",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.black54),
//                 ),
//               ),
//             ),
//             _buildButton("Menuju Lokasi Bongkar", () {
//               setState(() => _step = 4);
//             }),
//           ],
//         );
//         break;
//       case 4:
//         content = Column(
//           children: [
//             _buildTripInfo(),
//             const SizedBox(height: 8),
//             Container(
//               width: double.infinity,
//               margin: const EdgeInsets.symmetric(horizontal: 16),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade300)),
//               child: const Center(
//                 child: Text(
//                   "MUAT",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.black54),
//                 ),
//               ),
//             ),
//             _buildButton("Tiba Lokasi Bongkar", () {
//               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                   content: Text("Proses pengangkutan selesai ✅")));
//               setState(() => _step = 0);
//             }),
//           ],
//         );
//         break;
//       default:
//         content = Container();
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF002B4C),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildHeader(),
//             content,
//           ],
//         ),
//       ),
//     );
//   }
// }




