import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/drawer_item.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';
import 'package:newbkmmobile/ui/pages/change_password/change_password.dart';
import 'package:newbkmmobile/ui/widgets/logout_dialog.dart';

import 'home/home_page.dart';

class DrawerMenuPage extends StatefulWidget {
  const DrawerMenuPage({Key? key}) : super(key: key);

  @override
  State<DrawerMenuPage> createState() => _DrawerMenuPageState();
}

class _DrawerMenuPageState extends State<DrawerMenuPage> {
  final listDrawer = [
    DrawerItem(R.strings.mainMenu, Icons.home),
    DrawerItem(R.strings.changePassword, Icons.key),
    DrawerItem(R.strings.exit, Icons.logout),
  ];

  String urlPhoto = "";
  String fullName = "";
  String phone = "";
  String dedication = "";
  int selectedDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
    _getUserDetail();
  }

  Future _getUserDetail() async {
    try {
      var userDetail = await UserDetailRepository().getUserDetailLocal();
      if (userDetail.isNotEmpty) {
        setState(() {
          fullName = userDetail[0].fullName;
          phone = userDetail[0].mobileNumber;
          dedication = userDetail[0].dedication;
          urlPhoto = userDetail[0].profilImg;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const HomePage();
      case 1:
        return const ChangePasswordPage();
      case 2:
      return const Center();
      default:
        return const Center(child: Text("Error"));
    }
  }

  _onSelectItem(int index) {
    if (index == 2) {
      Navigator.of(context).pop();
      showDialog(context: context, builder: (BuildContext context) => const LogoutDialog());
    } else {
      setState(() => selectedDrawerIndex = index);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listDrawerOptions = [];
    for (var i = 0; i < listDrawer.length; i++) {
      var d = listDrawer[i];
      listDrawerOptions.add(ListTile(
        leading: Icon(
          d.icon,
          color:
              i == selectedDrawerIndex ? R.colors.colorPrimaryDark : R.colors.bgGrey,
        ),
        title: Text(
          d.title,
          style: TextStyle(
            color: i == selectedDrawerIndex
                ? R.colors.colorPrimaryDark
                : R.colors.bgGrey,
          ),
        ),
        selected: i == selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          listDrawer[selectedDrawerIndex].title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: R.colors.colorPrimary,
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 15.0,
                    left: 15.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Card(
                            color: Colors.white,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0)),
                            child: Container(
                              height: 70.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                image: DecorationImage(
                                  image: NetworkImage(urlPhoto),
                                  onError: (error, stackTrace) =>
                                      const Text(""),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Container(
                          margin: const EdgeInsets.only(left: 5.0, right: 10.0),
                          child: Text(
                            fullName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Container(
                          margin: const EdgeInsets.only(left: 5.0, right: 10.0),
                          child: Text(
                            phone,
                            style: TextStyle(
                              color: R.colors.grey1,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Container(
                          margin: const EdgeInsets.only(left: 5.0, right: 10.0),
                          child: Text(
                            "Pengabdian : $dedication",
                            style: TextStyle(
                              color: R.colors.grey1,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(children: listDrawerOptions),
          ],
        ),
      ),
      body: _getDrawerItemWidget(selectedDrawerIndex),
    );
  }
}
