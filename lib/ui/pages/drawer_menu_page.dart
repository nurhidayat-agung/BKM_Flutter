import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/drawer_item.dart';
import 'package:newbkmmobile/core/r.dart';
import 'package:newbkmmobile/models/login/UserSession.dart';
import 'package:newbkmmobile/repositories/login_repository.dart';
import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'package:newbkmmobile/ui/pages/change_password/change_password_page.dart';
import 'package:newbkmmobile/ui/widgets/logout_dialog.dart';
import 'home/home_page.dart';

class DrawerMenuPage extends StatefulWidget {
  const DrawerMenuPage({Key? key}) : super(key: key);

  @override
  State<DrawerMenuPage> createState() => _DrawerMenuPageState();
}

class _DrawerMenuPageState extends State<DrawerMenuPage> {
  final LoginRepository _loginRepository = LoginRepository();
  UserSession? _userSession;

  final listDrawer = [
    DrawerItem(R.strings.mainMenu, Icons.home),
    DrawerItem(R.strings.changePassword, Icons.key),
    DrawerItem(R.strings.exit, Icons.logout),
  ];

  int selectedDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserSession();
  }

  Future<void> _loadUserSession() async {
    final session = await SessionManager.getUserSession();
    setState(() => _userSession = session);
  }

  Widget _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomePage(loginRepository: _loginRepository);
      case 1:
        return const ChangePasswordPage();
      default:
        return const Center();
    }
  }

  void _onSelectItem(int index) {
    if (index == 2) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) => const LogoutDialog(),
      );
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
      listDrawerOptions.add(
        ListTile(
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
        ),
      );
    }

    final name = _userSession?.name ?? "User Offline";
    final roleId = _userSession?.roleId ?? "-";

    return Scaffold(
      appBar: selectedDrawerIndex == 0
          ? null
          : AppBar(
        title: Text(
          listDrawer[selectedDrawerIndex].title,
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      drawer: Drawer(
        child: Column(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.white,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: Container(
                            height: 70.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/default_user.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          "Role ID: $roleId",
                          style: TextStyle(
                            color: Colors.grey[350],
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: ListView(children: listDrawerOptions)),
          ],
        ),
      ),

      body: _getDrawerItemWidget(selectedDrawerIndex),
    );
  }
}

