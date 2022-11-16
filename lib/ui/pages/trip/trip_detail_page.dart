import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/trip_detail/trip_detail_bloc.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/trip_detail_resp.dart';
import 'package:newbkmmobile/repositories/trip_repository.dart';
import 'package:newbkmmobile/ui/widgets/full_image_view.dart';
import 'package:newbkmmobile/ui/widgets/pair_horizontal_text.dart';

class TripDetailPage extends StatefulWidget {
  const TripDetailPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> {
  final _tripDetailBloc = TripDetailBloc(TripRepository());
  final _spbController = TextEditingController();
  final _muatController = TextEditingController();
  final _bongkarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tripDetailBloc.add(TripDetail(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    ListStatusTrip? _selectedListStatusTrip;

    return Scaffold(
      appBar: AppBar(
        title: Text(R.strings.titleTripDetailPage),
      ),
      body: BlocBuilder<TripDetailBloc, TripDetailState>(
        bloc: _tripDetailBloc,
        builder: (context, state) {
          if (state is TripDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TripDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TripDetailSuccess) {
            _spbController.text = state.tripDetailResp.spbNumber ?? "";
            _muatController.text = state.tripDetailResp.amountSent ?? "";
            _bongkarController.text = state.tripDetailResp.amountReceived ?? "";
            final listStatusTrip = state.tripDetailResp.listStatusTrip;
            if (listStatusTrip!.isNotEmpty) {
              _selectedListStatusTrip = listStatusTrip[0];
            } else {
              _selectedListStatusTrip = null;
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
                              state.tripDetailResp.doNumber ?? "",
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
                                        image: state.tripDetailResp.qrcode ??
                                            "")));
                              },
                              child: Image.network(
                                state.tripDetailResp.qrcode ?? "",
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
                    child: Column(
                      children: [
                        PairHorizontalText(
                          title: R.strings.doKecil,
                          content: state.tripDetailResp.subDo ?? "",
                          colorTitle: R.colors.colorText,
                          colorContent: Colors.black,
                          fontSizeTitle: 14.0,
                          fontSizeContent: 14.0,
                          fontWeightTitle: FontWeight.normal,
                          fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                          title: R.strings.pengemudi,
                          content: state.tripDetailResp.driverName ?? "",
                          colorTitle: R.colors.colorText,
                          colorContent: Colors.black,
                          fontSizeTitle: 14.0,
                          fontSizeContent: 14.0,
                          fontWeightTitle: FontWeight.normal,
                          fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                          title: R.strings.noKendaraan,
                          content: state.tripDetailResp.vehicleNumber ?? "",
                          colorTitle: R.colors.colorText,
                          colorContent: Colors.black,
                          fontSizeTitle: 14.0,
                          fontSizeContent: 14.0,
                          fontWeightTitle: FontWeight.normal,
                          fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                          title: R.strings.uangJalan,
                          content: state.tripDetailResp.trvlExpenses ?? "",
                          colorTitle: R.colors.colorText,
                          colorContent: Colors.black,
                          fontSizeTitle: 14.0,
                          fontSizeContent: 14.0,
                          fontWeightTitle: FontWeight.normal,
                          fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                          title: R.strings.pks,
                          content: state.tripDetailResp.pksName ?? "",
                          colorTitle: R.colors.colorText,
                          colorContent: Colors.black,
                          fontSizeTitle: 14.0,
                          fontSizeContent: 14.0,
                          fontWeightTitle: FontWeight.normal,
                          fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                          title: R.strings.tujuanBongkar,
                          content: state.tripDetailResp.destinationName ?? "",
                          colorTitle: R.colors.colorText,
                          colorContent: Colors.black,
                          fontSizeTitle: 14.0,
                          fontSizeContent: 14.0,
                          fontWeightTitle: FontWeight.normal,
                          fontWeightContent: FontWeight.bold,
                        ),
                        const SizedBox(height: 18.0),
                        PairHorizontalText(
                          title: R.strings.produk,
                          content: state.tripDetailResp.commodityName ?? "",
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
                                underline: Container(),
                                value: _selectedListStatusTrip,
                                onChanged: (ListStatusTrip? newValue) {
                                  setState(() {
                                    _selectedListStatusTrip = newValue!;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 18.0),
                        TextField(
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
                                )),
                            labelStyle: TextStyle(
                              color: R.colors.colorText,
                            ),
                            labelText: R.strings.spbNo,
                          ),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: R.colors.colorText,
                            fontSize: 16.0,
                          ),
                          controller: _spbController,
                        ),
                        const SizedBox(height: 18.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextField(
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
                                      )),
                                  labelStyle: TextStyle(
                                    color: R.colors.colorText,
                                  ),
                                  labelText:
                                      "${R.strings.muat} (${R.strings.kg})",
                                ),
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: R.colors.colorText,
                                  fontSize: 16.0,
                                ),
                                controller: _muatController,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: TextField(
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
                                      )),
                                  labelStyle: TextStyle(
                                    color: R.colors.colorText,
                                  ),
                                  labelText:
                                      "${R.strings.bongkar} (${R.strings.kg})",
                                ),
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  color: R.colors.colorText,
                                  fontSize: 16.0,
                                ),
                                controller: _bongkarController,
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
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text(R.strings.titleChooseImage),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            GestureDetector(
                                              child: Text(R.strings.takePhoto),
                                              onTap: () {
                                                // openCamera();
                                              },
                                            ),
                                            const SizedBox(height: 18.0),
                                            GestureDetector(
                                              child:
                                                  Text(R.strings.openGallery),
                                              onTap: () {
                                                // openGallery();
                                              },
                                            ),
                                            const SizedBox(height: 18.0),
                                            GestureDetector(
                                              child:
                                              Text(R.strings.cancel),
                                              onTap: () {
                                                // openGallery();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Image.network(
                                    state.tripDetailResp.spb ?? "",
                                    height: 100.0,
                                    width: double.infinity,
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
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return const Icon(
                                        Icons.photo_camera,
                                        color: Colors.grey,
                                        size: 100.0,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: R.colors.greenLogo,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                R.strings.finish.toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is TripDetailError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          throw ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(R.strings.errorWidget)));
        },
      ),
    );
  }
}
