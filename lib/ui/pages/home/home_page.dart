import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/user_detail/user_detail_bloc.dart';
import 'package:newbkmmobile/core/grid_item.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';
import 'package:newbkmmobile/ui/pages/history/history_page.dart';
import 'package:newbkmmobile/ui/pages/payslip/payslip_page.dart';
import 'package:newbkmmobile/ui/pages/trip/trip_page.dart';
import 'package:newbkmmobile/ui/widgets/banner_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _userDetailBloc = UserDetailBloc(UserDetailRepository());
  int numberOfTrip = 0;
  int currentPos = 0;
  List<GridItem> listGrid = [
    GridItem(title: R.strings.menuTrip, image: AssetImage(R.assets.menuTrip), color: Colors.deepPurple[300]!, widget: const TripPage()),
    GridItem(title: R.strings.menuHistory, image: AssetImage(R.assets.menuHistory), color: Colors.lightBlue[500]!, widget: const HistoryPage()),
    GridItem(title: R.strings.menuSalary, image: AssetImage(R.assets.menuSalary), color: Colors.green[600]!, widget: const PaySlipPage()),
    GridItem(title: R.strings.menuWorkshop, image: AssetImage(R.assets.menuWorkshop), color: Colors.orange[800]!, widget: const TripPage()),
    GridItem(title: R.strings.menuService, image: AssetImage(R.assets.menuService), color: Colors.red[700]!, widget: const TripPage()),
    GridItem(title: R.strings.menuPart, image: AssetImage(R.assets.menuPart), color: Colors.teal[600]!, widget: const TripPage()),
    GridItem(title: R.strings.menuHelp, image: AssetImage(R.assets.menuHelp), color: Colors.brown[400]!, widget: const TripPage()),

  ];

  @override
  void initState() {
    super.initState();
    _userDetailBloc.add(UserDetail());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocBuilder<UserDetailBloc, UserDetailState>(
            bloc: _userDetailBloc,
            builder: (context, state) {
              if (state is UserDetailInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserDetailLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UserDetailSuccess) {
                if (state.listUserDetailLocal[0].numberOfTrip.isNotEmpty && int.parse(state.listUserDetailLocal[0].numberOfTrip) > 0) {
                  numberOfTrip = int.parse(state.listUserDetailLocal[0].numberOfTrip);
                }
                final listAnnouncement = state.listUserDetailLocal[0].announcement;
                if (listAnnouncement.isNotEmpty) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CarouselSlider.builder(
                            itemCount: listAnnouncement.length,
                            options: CarouselOptions(
                              height: MediaQuery.of(context).size.height/3,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentPos = index;
                                });
                              }
                            ),
                            itemBuilder: (ctx, index, _) {
                              return BannerSlider(announcementLocal: listAnnouncement[index]);
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: listAnnouncement.map((data) {
                            int index = listAnnouncement.indexOf(data);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 2.0,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentPos == index ? R.colors.colorPrimary : Colors.grey[350]!
                              ),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: listGrid.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 5.0,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (BuildContext context) {
                                    return listGrid[index].widget;
                                  }));
                                },
                                child: Card(
                                  color: listGrid[index].color,
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Center(
                                          child: ImageIcon(
                                            listGrid[index].image,
                                            color: Colors.white,
                                            size: 80.0,
                                          ),
                                        ),
                                        Visibility(
                                          visible: index == 0 && numberOfTrip > 0 ? true : false,
                                          child: Positioned(
                                            top: 30.0,
                                            right: 20.0,
                                            child: Card(
                                              color: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(80.0),
                                                //set border radius more than 50% of height and width to make circle
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 4.0,
                                                  horizontal: 8.0,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    numberOfTrip.toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: FractionalOffset.bottomCenter,
                                          child: Text(
                                            listGrid[index].title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ),
                        ),
                      ],
                  );
                } else {
                  return const Center();
                }
              } else if (state is UserDetailError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message)));
              }
              throw ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(R.strings.errorWidget)));
            },
          ),
        ],
      ),
    );
  }
}