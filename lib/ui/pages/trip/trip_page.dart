import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/trip/trip_bloc.dart';
import 'package:newbkmmobile/core/image_picker.dart';
import 'package:newbkmmobile/models/trip/delivery_response.dart';
import 'package:newbkmmobile/models/trip/muat_request.dart';
import 'package:newbkmmobile/models/trip/trip_detail_response.dart';

import '../../../repositories/trip_repository.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key? key}) : super(key: key);

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  String _step = "";

  String noDO = "";
  String noDOSambung = "";
  String namaSupir = "";
  String noKendaraan = "";

  bool showMuatEdit = false;
  bool showBongkarEdit = false;

  // Controller MUAT
  final TextEditingController spbMuat = TextEditingController();
  final TextEditingController tarraMuat = TextEditingController();
  final TextEditingController brutoMuat = TextEditingController();
  final TextEditingController nettoMuat = TextEditingController();
  final TextEditingController spbMuatSambung = TextEditingController();
  final TextEditingController tarraMuatSambung = TextEditingController();
  final TextEditingController brutoMuatSambung = TextEditingController();
  final TextEditingController nettoMuatSambung = TextEditingController();

  // Controller BONGKAR
  final TextEditingController tarraBongkar = TextEditingController();
  final TextEditingController brutoBongkar = TextEditingController();
  final TextEditingController nettoBongkar = TextEditingController();
  final TextEditingController tarraBongkarSambung = TextEditingController();
  final TextEditingController brutoBongkarSambung = TextEditingController();
  final TextEditingController nettoBongkarSambung = TextEditingController();

  File? fotoSPB;

  @override
  void dispose() {
    spbMuat.dispose();
    tarraMuat.dispose();
    brutoMuat.dispose();
    nettoMuat.dispose();
    spbMuatSambung.dispose();
    tarraMuatSambung.dispose();
    brutoMuatSambung.dispose();
    nettoMuatSambung.dispose();
    tarraBongkar.dispose();
    brutoBongkar.dispose();
    nettoBongkar.dispose();
    tarraBongkarSambung.dispose();
    brutoBongkarSambung.dispose();
    nettoBongkarSambung.dispose();
    super.dispose();
  }

  // ========== BUILD UI ==========
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: AppBar(
          backgroundColor: const Color(0xFF002B4C),
          elevation: 0,
          centerTitle: true,
          title: const Text("Pengangkutan Baru",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0B3B54),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.all(8),
                child: const Icon(Icons.chevron_left, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => TripBloc(TripRepository())..add(GetTrip()),
        child: BlocBuilder<TripBloc, TripState>(
          builder: (context, state) {
            if (state is TripLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TripError) {
              return Center(child: Text("Error: ${state.message}"));
            }

            if (state is TripSuccess) {
              final trip = state.tripDetail;
              final delivery = state.deliveryData;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    generateContent(context, trip, delivery),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget generateContent(
      BuildContext context, TripDetail tripDetail, DeliveryData deliveryData) {
    Widget content = Container();
    _step = deliveryData.status ?? "";

    noDO = deliveryData.deliveryOrder?.doNumber ?? "";
    namaSupir = deliveryData.driver?.name ?? "";
    noKendaraan = deliveryData.vehicle?.policeNumber ?? "";
    // cek apakah ada do sambung
    if (deliveryData.linkedDetail != null &&
        deliveryData.linkedDetailId != null) {
      noDOSambung = deliveryData.linkedDetail?.deliveryOrder?.doNumber ?? "";
    }

    if (deliveryData.status == "waiting") {
      content = Column(
        children: [
          buildInfoCard(tripDetail, deliveryData),
          buildFirstButtons(context, tripDetail.id ?? ""),
        ],
      );
    } else if (deliveryData.status == "accepted" &&
        deliveryData.latestStatusLog == "0") {
      content = Column(
        children: [
          buildInfoCard(tripDetail, deliveryData),
          mainButton("Menuju Lokasi Muat", () async {
            if (await showConfirmDialog(
                "Menuju Lokasi Muat", "Apakah anda akan menuju pemuatan?")) {
              context.read<TripBloc>().add(
                    LoadingLocationTrip(
                        deliveryOrderDetailId: tripDetail.id ?? "",
                        nextStatus: "1"),
                  );
            }
          }),
        ],
      );
    } else if (deliveryData.status == "process" &&
        deliveryData.latestStatusLog == "1") {
      content = Column(
        children: [
          buildInfoCard(tripDetail, deliveryData),
          mainButton("Tiba Lokasi Muat", () async {
            if (await showConfirmDialog("Sampai Lokasi Muat",
                "Apakah anda sampai di lokasi pemuatan?")) {
              context.read<TripBloc>().add(
                    LoadingLocationTrip(
                        deliveryOrderDetailId: tripDetail.id ?? "",
                        nextStatus: "2"),
                  );
            }
          }),
        ],
      );
    } else if (deliveryData.status == "process" &&
        deliveryData.latestStatusLog == "2") {
      content = Column(
        children: [
          buildInfoCard(tripDetail, deliveryData),
          buildFormMuat(context, tripDetail, deliveryData),
        ],
      );
    } else if (deliveryData.status == "process" &&
        deliveryData.latestStatusLog == "3") {
      content = Column(
        children: [
          buildInfoCard(tripDetail, deliveryData),
          mainButton("Menuju Lokasi Bongkar", () async {
            if (await showConfirmDialog(
                "Menuju Lokasi Bongkar", "Apakah anda akan menuju bongkar?")) {
              context.read<TripBloc>().add(PushTripUnload(
                  deliveryData: deliveryData, tripDetail: tripDetail));
            }
          }),
          statusCard(
            expanded: showMuatEdit,
            "MUAT",
            onTap: () {
              setState(() {
                showMuatEdit = !showMuatEdit;
              });
            },
          ),
          // FORM EXPANDED (tanpa tombol simpan)
          if (showMuatEdit)
            buildFormMuat(
              context,
              tripDetail,
              deliveryData,
              isAction: false, // ⬅ tidak ada tombol save
            ),
        ],
      );
    } else if (deliveryData.latestStatusLog == "4" &&
        deliveryData.status == "process") {
      content = Column(
        children: [
          buildInfoCard(tripDetail, deliveryData),
          mainButton("Tiba Lokasi Bongkar", () async {
            if (await showConfirmDialog(
                "Tiba Lokasi Bongkar", "Apakah anda sudah tiba di lokasi?")) {
              context.read<TripBloc>().add(PushTillUnload(
                  deliveryData: deliveryData, tripDetail: tripDetail));
            }
          }),
          statusCard(
            expanded: showMuatEdit,
            "MUAT",
            onTap: () {
              setState(() {
                showMuatEdit = !showMuatEdit;
              });
            },
          ),
          // FORM EXPANDED (tanpa tombol simpan)
          if (showMuatEdit)
            buildFormMuat(
              context,
              tripDetail,
              deliveryData,
              isAction: false, // ⬅ tidak ada tombol save
            ),
        ],
      );
    } else if (deliveryData.latestStatusLog == "5" &&
        deliveryData.status == "process") {
      content = Column(
        children: [
          buildInfoCard(tripDetail, deliveryData),
          buildFormBongkar(context, deliveryData, tripDetail),
          statusCard(
            expanded: showMuatEdit,
            "MUAT",
            onTap: () {
              setState(() {
                showMuatEdit = !showMuatEdit;
              });
            },
          ),
          // FORM EXPANDED (tanpa tombol simpan)
          if (showMuatEdit)
            buildFormMuat(
              context,
              tripDetail,
              deliveryData,
              isAction: false, // ⬅ tidak ada tombol save
            ),
        ],
      );
    } else if (deliveryData.latestStatusLog == "6" &&
        deliveryData.status == "process") {
      content = Column(
        children: [
          buildInfoCard(tripDetail, deliveryData),
          mainButton("Pengangkutan Selesai", () async {
            if (await showConfirmDialog("Selesaikan pengangkutan",
                "Apakah anda ingin menyelesaikan pengangkutan?")) {
              context.read<TripBloc>().add(
                    LoadingLocationTrip(
                        deliveryOrderDetailId: tripDetail.id ?? "",
                        nextStatus: "7"),
                  );
            }
          }),
          statusCard(
            expanded: showMuatEdit,
            "MUAT",
            onTap: () {
              setState(() {
                showMuatEdit = !showMuatEdit;
              });
            },
          ),
          // FORM EXPANDED (tanpa tombol simpan)
          if (showMuatEdit)
            buildFormMuat(
              context,
              tripDetail,
              deliveryData,
              isAction: true,
              isEdit: true// ⬅ tidak ada tombol save
            ),
          statusCard(
            expanded: showMuatEdit,
            "Edit Bongkar",
            onTap: () {
              setState(() {
                showBongkarEdit = !showBongkarEdit;
              });
            },
          ),
          // FORM EXPANDED (tanpa tombol simpan)
          if (showBongkarEdit)
            buildFormBongkar(
                context,
                deliveryData,
                tripDetail,
                isAction: true,
                isEdit: true// ⬅ tidak ada tombol save
            ),
        ],
      );
    }

    return content;
  }

  Future<bool> showConfirmDialog(String title, String msg) async {
    return await showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(msg, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 45),
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Batal",
                          style: TextStyle(color: Colors.black54)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(0, 45),
                        backgroundColor: const Color(0xFF002B4C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Ya",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  //Perubahan detail Pengangkutan(Card Info)
  Widget buildInfoCard(TripDetail detail, DeliveryData deliveryData) {
    final origin = deliveryData.deliveryOrder?.pksId ?? "-";
    final destination = deliveryData.deliveryOrder?.destinationId ?? "-";
    final commodity = deliveryData.deliveryOrder?.commodityId ?? "-";
    final doBesar = deliveryData.deliveryOrder?.doNumber ?? "-";
    final doDate = deliveryData.deliveryOrder?.doDate ?? "-";
    final doKecil = deliveryData.linkedDetail?.deliveryOrder?.doNumber ?? "-";
    final supir = detail.driver?.name ?? "-";
    final kendaraan = detail.vehicle?.policeNumber ?? "-";

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 18, 16, 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// SAM1 → ASK
          Text(
            "$origin → $destination",
            style: const TextStyle(
              color: Color(0xFFD35400),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),

          /// Sub description
          Text(
            "$origin → $destination",
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),

          const SizedBox(height: 12),

          /// KOMODITI
          const Text("Kommodity", style: TextStyle(fontSize: 13)),
          Text(
            commodity,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B3B54),
            ),
          ),

          const SizedBox(height: 12),

          /// DO BESAR
          const Text("No DO Besar", style: TextStyle(fontSize: 13)),
          const SizedBox(height: 4),
          Text(
            doBesar,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
          ),
          Text(
            doDate,
            style: const TextStyle(color: Colors.black54),
          ),

          const Divider(height: 20),

          /// DO KECIL
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("No DO Kecil",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text(
                doKecil,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),

          /// Supir
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Nama Supir",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text(
                supir,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),

          /// Kendaraan
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("No Kendaraan",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text(
                kendaraan,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // TEXTFIELD basic
  Widget inputField(TextEditingController c, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: c,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 13),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),

          // Border default
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),

          // Border ketika tidak fokus
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey, // warna border
              width: 1,
            ),
          ),

          // Border ketika fokus
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 1.5,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  // Button utama
  Widget mainButton(String text, VoidCallback onTap,
      {Color bg = const Color(0xFFD35400)}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: bg,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
          child: Text(text,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ),
      ),
    );
  }

  // Halaman awal: tombol Terima & Tolak
  Widget buildFirstButtons(BuildContext context, String deliveryOrderDetailId) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () async {
                bool res = await showConfirmDialog(
                    "Terima Trip", "Terima Pengantaran ?");

                if (res) {
                  // Panggil AcceptTrip event Bloc
                  context.read<TripBloc>().add(
                        AcceptTrip(
                            deliveryOrderDetailId: deliveryOrderDetailId),
                      );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD35400),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Terima",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () async {
                final res = await showConfirmDialog(
                    "Tolak Pengangkutan", "Apakah Anda yakin menolak?");
                if (res) {
                  setState(() => _step = "0");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF002B4C),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Tolak",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  // FORM MUAT
  Widget buildFormMuat(
      BuildContext context, TripDetail data, DeliveryData deliveryData,
      {bool isAction = true, bool isEdit = false}) {
    spbMuat.text = deliveryData.spbNumber ?? "";
    tarraMuat.text = deliveryData.loadTare.toString() ?? "0";
    brutoMuat.text = deliveryData.loadBruto.toString();
    nettoMuat.text = deliveryData.loadQuantity.toString();

    if (deliveryData.linkedDetail != null) {
      spbMuatSambung.text = deliveryData.linkedDetail?.spbNumber ?? "";
      tarraMuatSambung.text =
          deliveryData.linkedDetail?.loadTare.toString() ?? "";
      brutoMuatSambung.text =
          deliveryData.linkedDetail?.loadBruto.toString() ?? "";
      nettoMuatSambung.text =
          deliveryData.linkedDetail?.loadQuantity.toString() ?? "";
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "MUAT",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          const SizedBox(height: 10),

          Text(
            "DO : $noDO",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // ------ INPUT DO UTAMA ------
          inputField(spbMuat, "No. SPB"),
          inputField(tarraMuat, "Jumlah Tarra Muat"),
          inputField(brutoMuat, "Jumlah Bruto Muat"),
          inputField(nettoMuat, "Netto Muat (Kg)"),

          const SizedBox(height: 10),

          // ==========================
          //    UPLOAD FOTO HANYA DO UTAMA
          // ==========================
          if (isAction)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF002B4C),
              ),
              onPressed: () {
                pickImage(
                  context: context,
                  onImagePicked: (file) {
                    setState(() => fotoSPB = file);
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text("Unggah Foto SPB",
                    style: TextStyle(color: Colors.white)),
              ),
            ),

          // Preview gambar DO Utama
          if (fotoSPB != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  fotoSPB!,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

          const SizedBox(height: 20),

          // ==========================
          //     DO SAMBUNG (TANPA FOTO)
          // ==========================
          if (deliveryData.linkedDetail != null) ...[
            Text(
              "DO Sambung : $noDOSambung",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            inputField(spbMuatSambung, "No. SPB"),
            inputField(tarraMuatSambung, "Jumlah Tarra Muat"),
            inputField(brutoMuatSambung, "Jumlah Bruto Muat"),
            inputField(nettoMuatSambung, "Netto Muat (Kg)"),
          ],

          const SizedBox(height: 20),

          // Tombol Simpan
          // Tombol simpan → collect data
          if (isAction)
            mainButton("Simpan", () async {
              if (await showConfirmDialog(
                "Simpan Data Muat",
                "Apakah anda yakin akan menyimpan ke server ?",
              )) {
                final req = collectMuatData(deliveryData);

                print("==== MUAT REQUEST ====");
                print("NO DO: ${req.noDo}");
                print("SPB: ${req.spb}");
                print("Foto path: ${req.fotoSpb?.path}");

                if (req.noDoSambung != null) {
                  print("DO Sambung: ${req.noDoSambung}");
                  print("SPB Sambung: ${req.spbSambung}");
                }

                context.read<TripBloc>().add(
                      PushMuat(
                        deliveryData: deliveryData,
                        tripDetail: data,
                        muatRequest: req,
                        isEdit: isEdit
                      ),
                    );
              }
            }),
        ],
      ),
    );
  }

  // FORM BONGKAR
  Widget buildFormBongkar(
    BuildContext context,
    DeliveryData deliveryData,
    TripDetail tripDetail, {
    bool isAction = true, bool isEdit = false // PARAMETER TAMBAHAN
  }) {
    tarraBongkar.text = deliveryData.unloadTare.toString();
    brutoBongkar.text = deliveryData.unloadBruto.toString();
    nettoBongkar.text = deliveryData.unloadQuantity.toString();

    if (deliveryData.linkedDetail != null) {
      tarraBongkarSambung.text =
          deliveryData.linkedDetail?.unloadTare.toString() ?? "";
      brutoBongkarSambung.text =
          deliveryData.linkedDetail?.unloadBruto.toString() ?? "";
      nettoBongkarSambung.text =
          deliveryData.linkedDetail?.unloadQuantity.toString() ?? "";
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("BONGKAR",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black54)),
          const SizedBox(height: 10),
          Text("DO : $noDO",
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          inputField(tarraBongkar, "Jumlah Tarra Bongkar"),
          inputField(brutoBongkar, "Jumlah Bruto Bongkar"),
          inputField(nettoBongkar, "Netto Bongkar (Kg)"),
          const SizedBox(height: 10),

          // ==========================
          //    UPLOAD FOTO HANYA DO UTAMA
          // ==========================
          if (isAction)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF002B4C),
              ),
              onPressed: () {
                pickImage(
                  context: context,
                  onImagePicked: (file) {
                    setState(() => fotoSPB = file);
                  },
                );
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text("Unggah Foto SPB",
                    style: TextStyle(color: Colors.white)),
              ),
            ),

          // Preview gambar DO Utama
          if (fotoSPB != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  fotoSPB!,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          const SizedBox(height: 20),

          // ==========================
          //     DO SAMBUNG (TANPA FOTO)
          // ==========================
          if (deliveryData.linkedDetail != null) ...[
            Text("DO Sambung : $noDOSambung",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            inputField(tarraBongkarSambung, "Jumlah Tarra Bongkar"),
            inputField(brutoBongkarSambung, "Jumlah Bruto Bongkar"),
            inputField(nettoBongkarSambung, "Netto Bongkar (Kg)"),
          ],

          if (isAction)
            mainButton("Simpan", () async {
              if (await showConfirmDialog("Simpan Data Bongkar",
                  "Apakah anda yakin akan menyimpan ke server ?")) {
                final req = collectBongkarData(deliveryData);

                context.read<TripBloc>().add(PushBongkar(
                    deliveryData: deliveryData,
                    tripDetail: tripDetail,
                    bongkarRequest: req,
                    isEdit: isEdit
                ));
              }
            }),
        ],
      ),
    );
  }

  Widget statusCard(
    String title, {
    bool expanded = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, expanded ? 0 : 8),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(expanded ? 12 : 12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 15)),
            Icon(expanded ? Icons.expand_less : Icons.expand_more),
          ],
        ),
      ),
    );
  }

  LoadUnloadRequest collectMuatData(DeliveryData deliveryData) {
    return LoadUnloadRequest(
      noDo: noDO,
      spb: spbMuat.text,
      tarra: tarraMuat.text,
      bruto: brutoMuat.text,
      netto: nettoMuat.text,
      fotoSpb: fotoSPB,

      // hanya diisi jika DO sambung ada
      noDoSambung: deliveryData.linkedDetail != null ? noDOSambung : null,
      spbSambung:
          deliveryData.linkedDetail != null ? spbMuatSambung.text : null,
      tarraSambung:
          deliveryData.linkedDetail != null ? tarraMuatSambung.text : null,
      brutoSambung:
          deliveryData.linkedDetail != null ? brutoMuatSambung.text : null,
      nettoSambung:
          deliveryData.linkedDetail != null ? nettoMuatSambung.text : null,
    );
  }

  LoadUnloadRequest collectBongkarData(DeliveryData deliveryData) {
    return LoadUnloadRequest(
      noDo: noDO,
      spb: "",
      tarra: tarraBongkar.text,
      bruto: brutoBongkar.text,
      netto: nettoBongkar.text,
      fotoSpb: fotoSPB,

      // hanya diisi jika DO sambung ada
      tarraSambung:
          deliveryData.linkedDetail != null ? tarraBongkarSambung.text : null,
      brutoSambung:
          deliveryData.linkedDetail != null ? brutoBongkarSambung.text : null,
      nettoSambung:
          deliveryData.linkedDetail != null ? nettoBongkarSambung.text : null,
    );
  }
}
