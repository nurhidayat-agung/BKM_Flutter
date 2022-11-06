import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/user_detail/user_detail_bloc.dart';
import 'package:newbkmmobile/core/grid_item.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';
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
    GridItem(title: R.strings.menuTrip, image: AssetImage(R.assets.menuTrip)),
    GridItem(title: R.strings.menuHistory, image: AssetImage(R.assets.menuHistory)),
    GridItem(title: R.strings.menuSalary, image: AssetImage(R.assets.menuSalary)),
    GridItem(title: R.strings.menuHelp, image: AssetImage(R.assets.menuHelp)),
    GridItem(title: R.strings.menuService, image: AssetImage(R.assets.menuService)),
    GridItem(title: R.strings.menuPart, image: AssetImage(R.assets.menuPart)),
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
                        CarouselSlider.builder(
                          itemCount: listAnnouncement.length,
                          options: CarouselOptions(
                              height: 300.0,
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
                                color: currentPos == index ? R.colors.colorPrimary : R.colors.grey1
                              ),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
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
                                      Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Center(
                                                child: ImageIcon(
                                                  listGrid[index].image,
                                                  size: 60.0,
                                                ),
                                              ),
                                              Visibility(
                                                visible: index == 0 && numberOfTrip > 0 ? true : false,
                                                child: Positioned(
                                                  top: 30.0,
                                                  right: 30.0,
                                                  child: Card(
                                                    color: Colors.red,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(80),
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
                                                    fontSize: 16.0,
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
                      ],
                  );
                } else {
                  return const Center();
                }
              } else if (state is UserDetailError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message)));
              }
              throw ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Error create widget")));
            },
          ),
        ],
      ),
    );
  }
}