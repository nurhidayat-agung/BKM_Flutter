import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:newbkmmobile/core/constants.dart';
import 'package:newbkmmobile/core/drawer_item.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/core/storage_helper.dart';
import 'package:newbkmmobile/models/user_detail_resp.dart';
import 'package:newbkmmobile/ui/pages/change_password/change_password.dart';

import 'home/home_page.dart';

class DrawerMenuPage extends StatefulWidget {
  const DrawerMenuPage({Key? key}) : super(key: key);

  @override
  State<DrawerMenuPage> createState() => _DrawerMenuPageState();
}

class _DrawerMenuPageState extends State<DrawerMenuPage> {
  final listDrawer = [
    DrawerItem("Menu Utama", Icons.home),
    DrawerItem("Ganti Password", Icons.key),
    DrawerItem("Keluar", Icons.logout),
  ];

  String urlPhoto = "";
  String fullName = "";
  String phone = "";
  String dedication = "";
  int selectedDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
    _getDataLogin();
  }

  Future _getDataLogin() async {
    try {
      var userDetail = await StorageHelper().getString(Constants.userDetail);
      Map<String, dynamic> map = await jsonDecode(userDetail!);
      var result = UserDetailResp.fromJson(map);
      setState(() {
        fullName = result.fullName ?? "";
        phone = result.mobileNumber ?? "";
        dedication = result.dedication ?? "";
        urlPhoto = result.profilImg ?? "";
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString())));
    }
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const HomePage();
      case 1:
        return const ChangePasswordPage();
      case 2:
        _logout();
        return SchedulerBinding.instance.addPostFrameCallback((_) {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) =>
          //         LoginPage()), (Route<dynamic> route) => false
          // );
        });
      default:
        return Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => selectedDrawerIndex = index);
    Navigator.of(context).pop();
  }

  Future _logout() async {
    // final _sp = await SharedPreferences.getInstance();
    // await _sp.clear();
    // return true;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listDrawerOptions = [];
    for (var i = 0; i < listDrawer.length; i++) {
      var d = listDrawer[i];
      listDrawerOptions.add(
          ListTile(
            leading: Icon(d.icon),
            title: Text(d.title),
            selected: i == selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
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
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                            child: Container(
                              height: 70.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100.0),
                                image: DecorationImage(
                                  image: NetworkImage(urlPhoto),
                                  onError: (error, stackTrace) => const Text(""),
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
