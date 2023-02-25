import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newbkmmobile/blocs/user_detail/user_detail_bloc.dart';
import 'package:newbkmmobile/core/drawer_item.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/repositories/user_detail_repository.dart';
import 'package:newbkmmobile/ui/pages/change_password/change_password_page.dart';
import 'package:newbkmmobile/ui/widgets/logout_dialog.dart';

import 'home/home_page.dart';

class DrawerMenuPage extends StatefulWidget {
  const DrawerMenuPage({Key? key}) : super(key: key);

  @override
  State<DrawerMenuPage> createState() => _DrawerMenuPageState();
}

class _DrawerMenuPageState extends State<DrawerMenuPage> {
  final _userDetailBloc     = UserDetailBloc(UserDetailRepository());
  final listDrawer          = [
    DrawerItem(R.strings.mainMenu, Icons.home),
    DrawerItem(R.strings.changePassword, Icons.key),
    DrawerItem(R.strings.exit, Icons.logout),
  ];
  int selectedDrawerIndex   = 0;

  @override
  void initState() {
    super.initState();
    _userDetailBloc.add(UserDetail());
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
        return Center(child: Text(R.strings.errorWidget));
    }
  }

  _onSelectItem(int index) {
    if (index == 2) {
      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (BuildContext context) => const LogoutDialog());
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
          color: i == selectedDrawerIndex
              ? R.colors.colorPrimary
              : R.colors.colorTextLight,
        ),
        title: Text(
          d.title,
          style: TextStyle(
            color: i == selectedDrawerIndex
                ? R.colors.colorPrimaryDark
                : R.colors.colorTextLight,
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
        child: BlocBuilder<UserDetailBloc, UserDetailState>(
          bloc: _userDetailBloc,
          builder: (context, state) {
            if (state is UserDetailInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserDetailSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
                                  child: Container(
                                    height: 70.0,
                                    width: 70.0,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      image: DecorationImage(
                                        image: NetworkImage(state
                                            .listUserDetailLocal[0].profilImg),
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
                                margin: const EdgeInsets.only(
                                    left: 5.0, right: 10.0),
                                child: Text(
                                  state.listUserDetailLocal[0].fullName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 5.0, right: 10.0),
                                child: Text(
                                  state.listUserDetailLocal[0].mobileNumber,
                                  style: TextStyle(
                                    color: Colors.grey[350]!,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 5.0, right: 10.0),
                                child: Text(
                                  "${R.strings.pengabdian} : ${state.listUserDetailLocal[0].dedication}",
                                  style: TextStyle(
                                    color: Colors.grey[350]!,
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
              );
            } else if (state is UserDetailError) {
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
      body: _getDrawerItemWidget(selectedDrawerIndex),
    );
  }
}
