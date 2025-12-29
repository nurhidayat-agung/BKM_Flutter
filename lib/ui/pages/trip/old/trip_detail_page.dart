import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/save_trip/save_trip_bloc.dart';
import 'package:newbkmmobile/blocs/trip_detail/trip_detail_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/legacy/trip_detail_resp.dart';
import 'package:newbkmmobile/repositories/trip_repository.dart';
import 'package:newbkmmobile/ui/pages/trip/old/trip_detail_capture_photo.dart';
import 'package:newbkmmobile/ui/widgets/custom_loading.dart';
import 'package:newbkmmobile/ui/widgets/full_image_view.dart';
import 'package:newbkmmobile/ui/widgets/space_between_horizontal_text.dart';

class TripDetailPage extends StatefulWidget {
  const TripDetailPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  final _tripDetailBloc = TripDetailBloc(TripRepository());
  final _saveTripBloc   = SaveTripBloc(TripRepository());
  late TripDetailResp _tripDetail;
  ListStatusTrip? selectedListStatusTrip;
  String? _spbNo, _muat, _bongkar;
  File? _imgFile;

  @override
  void initState() {
    super.initState();
    _tripDetailBloc.add(TripDetailDataEvent(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleTripDetailPage),
      ),
      body: SafeArea(
        child: BlocBuilder<TripDetailBloc, TripDetailState>(
          bloc: _tripDetailBloc,
          builder: (context, state) {
            if (state is TripDetailInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TripDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TripDetailSuccess) {
              _tripDetail           = state.tripDetailResp;
              _spbNo                = _tripDetail.spbNumber ?? "";
              _muat                 = _tripDetail.amountSent ?? "";
              _bongkar              = _tripDetail.amountReceived ?? "";
              final listStatusTrip  = _tripDetail.listStatusTrip;
              if (listStatusTrip!.isNotEmpty) {
                selectedListStatusTrip = listStatusTrip[0];
              } else {
                selectedListStatusTrip = null;
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${R.strings.nomorDo} :",
                                style: TextStyle(
                                  color: R.colors.colorTextLight,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Text(
                                _tripDetail.doNumber ?? "",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FullImageView(
                                          image: _tripDetail.qrcode ??
                                              "")));
                                },
                                child: Image.network(
                                  _tripDetail.qrcode ?? "",
                                  height: 55.0,
                                  width: 55.0,
                                  fit: BoxFit.fill,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object exception, StackTrace? stackTrace) {
                                    return Container(
                                      color: Colors.transparent,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.grey[300],
                      height: 4.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 10.0,
                        right: 8.0,
                      ),
                      child: Form(
                        child: Column(
                          children: [
                            SpaceBetweenHorizontalText(
                              title: R.strings.doKecil,
                              content: _tripDetail.subDo ?? "",
                              colorTitle: R.colors.colorText,
                              colorContent: Colors.black,
                              fontSizeTitle: 14.0,
                              fontSizeContent: 14.0,
                              fontWeightTitle: FontWeight.normal,
                              fontWeightContent: FontWeight.bold,
                            ),
                            const SizedBox(height: 18.0),
                            SpaceBetweenHorizontalText(
                              title: R.strings.pengemudi,
                              content: _tripDetail.driverName ?? "",
                              colorTitle: R.colors.colorText,
                              colorContent: Colors.black,
                              fontSizeTitle: 14.0,
                              fontSizeContent: 14.0,
                              fontWeightTitle: FontWeight.normal,
                              fontWeightContent: FontWeight.bold,
                            ),
                            const SizedBox(height: 18.0),
                            SpaceBetweenHorizontalText(
                              title: R.strings.noKendaraan,
                              content: _tripDetail.vehicleNumber ?? "",
                              colorTitle: R.colors.colorText,
                              colorContent: Colors.black,
                              fontSizeTitle: 14.0,
                              fontSizeContent: 14.0,
                              fontWeightTitle: FontWeight.normal,
                              fontWeightContent: FontWeight.bold,
                            ),
                            const SizedBox(height: 18.0),
                            SpaceBetweenHorizontalText(
                              title: R.strings.uangJalan,
                              content: _tripDetail.trvlExpenses ?? "",
                              colorTitle: R.colors.colorText,
                              colorContent: Colors.black,
                              fontSizeTitle: 14.0,
                              fontSizeContent: 14.0,
                              fontWeightTitle: FontWeight.normal,
                              fontWeightContent: FontWeight.bold,
                            ),
                            const SizedBox(height: 18.0),
                            SpaceBetweenHorizontalText(
                              title: R.strings.pks,
                              content: _tripDetail.pksName ?? "",
                              colorTitle: R.colors.colorText,
                              colorContent: Colors.black,
                              fontSizeTitle: 14.0,
                              fontSizeContent: 14.0,
                              fontWeightTitle: FontWeight.normal,
                              fontWeightContent: FontWeight.bold,
                            ),
                            const SizedBox(height: 18.0),
                            SpaceBetweenHorizontalText(
                              title: R.strings.tujuanBongkar,
                              content: _tripDetail.destinationName ?? "",
                              colorTitle: R.colors.colorText,
                              colorContent: Colors.black,
                              fontSizeTitle: 14.0,
                              fontSizeContent: 14.0,
                              fontWeightTitle: FontWeight.normal,
                              fontWeightContent: FontWeight.bold,
                            ),
                            const SizedBox(height: 18.0),
                            SpaceBetweenHorizontalText(
                              title: R.strings.produk,
                              content: _tripDetail.commodityName ?? "",
                              colorTitle: R.colors.colorText,
                              colorContent: Colors.black,
                              fontSizeTitle: 14.0,
                              fontSizeContent: 14.0,
                              fontWeightTitle: FontWeight.normal,
                              fontWeightContent: FontWeight.bold,
                            ),
                            const SizedBox(height: 18.0),
                            StatefulBuilder(
                              builder: (ctx, setState) {
                                return Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: R.colors.greenLogo,
                                      width: 0.8,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ),
                                    ),
                                  ),
                                  child: DropdownButton<ListStatusTrip>(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: R.colors.greenLogo,
                                    ),
                                    isExpanded: true,
                                    items: listStatusTrip.map((ListStatusTrip val) {
                                      return DropdownMenuItem<ListStatusTrip>(
                                        value: val,
                                        child: Text(
                                          val.longName ?? "",
                                          style: TextStyle(
                                            color: R.colors.colorText,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (ListStatusTrip? newValue) {
                                      setState(() {
                                        selectedListStatusTrip = newValue!;
                                      });
                                    },
                                    underline: Container(),
                                    value: selectedListStatusTrip,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 18.0),
                            TextFormField(
                              cursorColor: R.colors.colorText,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: R.colors.greenLogo,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: R.colors.greenLogo,
                                    ),
                                ),
                                labelStyle: TextStyle(
                                  color: R.colors.colorText,
                                ),
                                labelText: R.strings.spbNo,
                              ),
                              initialValue: _spbNo,
                              keyboardType: TextInputType.number,
                              onChanged: (newValue) {
                                _spbNo = newValue;
                              },
                              style: TextStyle(
                                color: R.colors.colorText,
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 18.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: R.colors.colorText,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: R.colors.greenLogo,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: R.colors.greenLogo,
                                          ),
                                      ),
                                      labelStyle: TextStyle(
                                        color: R.colors.colorText,
                                      ),
                                      labelText:
                                          "${R.strings.muat} (${R.strings.kg})",
                                    ),
                                    initialValue: _muat,
                                    keyboardType: TextInputType.number,
                                    onChanged: (newValue) {
                                      _muat = newValue;
                                    },
                                    style: TextStyle(
                                      color: R.colors.colorText,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: TextFormField(
                                    cursorColor: R.colors.colorText,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: R.colors.greenLogo,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: R.colors.greenLogo,
                                          ),
                                      ),
                                      labelStyle: TextStyle(
                                        color: R.colors.colorText,
                                      ),
                                      labelText:
                                          "${R.strings.bongkar} (${R.strings.kg})",
                                    ),
                                    initialValue: _bongkar,
                                    keyboardType: TextInputType.number,
                                    onChanged: (newValue) {
                                      _bongkar = newValue;
                                    },
                                    style: TextStyle(
                                      color: R.colors.colorText,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 18.0),
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    R.strings.tapCamera,
                                    style: TextStyle(
                                      color: R.colors.colorTextLight,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  TripDetailCapturePhoto(
                                    spbImg: _tripDetail.spb ?? "",
                                    onPhotoSelected: (file) {
                                      _imgFile = file;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return AlertDialog(
                                          content: Text(R.strings.msgConfirmSave),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  _saveTripBloc.add(SaveTrip(
                                                      id: _tripDetail.id ?? "",
                                                      statusTrip: selectedListStatusTrip?.id ?? "",
                                                      numberOfLoad: _muat ?? "",
                                                      numberOfUnload: _bongkar ?? "",
                                                      spbNo: _spbNo ?? "",
                                                      trigger: "btn_submit",
                                                      spbImg: _imgFile ?? File(""))
                                                  );
                                                },
                                                child: Text(R.strings.yes)),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(R.strings.no))
                                          ],
                                        );
                                      });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: R.colors.greenLogo,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: BlocListener<SaveTripBloc, SaveTripState>(
                                  bloc: _saveTripBloc,
                                  listener: (context, state) {
                                    if (state is SaveTripInitial) {
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          R.strings.finish.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      );
                                    }
                                    if (state is SaveTripLoading) {
                                      CustomLoading(
                                          message: R.strings.loadingGetData);
                                    }
                                    if (state is SaveTripSuccess) {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          content: Text(
                                              state.strResponse ?? ""),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Text(
                                                R.strings.ok,
                                                style: TextStyle(
                                                  color: R.colors.colorPrimary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    if (state is SaveTripError) {
                                      Navigator.pop(context);
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          content: Text(
                                              state.message ?? ""),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Text(
                                                R.strings.ok,
                                                style: TextStyle(
                                                  color: R.colors.colorPrimary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: BlocBuilder<SaveTripBloc, SaveTripState>(
                                    bloc: _saveTripBloc,
                                    builder: (context, state) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          R.strings.finish.toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is TripDetailError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50.0,
                    ),
                    Text(
                      state.message,
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              );
            }
            throw ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(R.strings.errorWidget)));
          },
        ),
      ),
    );
  }
}
