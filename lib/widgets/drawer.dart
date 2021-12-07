import 'dart:async';

import 'package:diy/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart'
    show Onboarding;
import 'package:at_utils/at_logger.dart' show AtSignLogger;
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;
import 'package:at_app_flutter/at_app_flutter.dart' show AtEnv;

import '../main.dart';

// The class for the drawer. We need to add drawer: AppDrawer(),
//to the scaffold of every page in the app so the user is always
//able to navigate around.
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _createHeader(),
            // const DrawerHeader(
            //   decoration: BoxDecoration(
            //     color: Colors.purple,
            //   ),
            //   child: Text('Drawer Header'),
            // ),
            ListTile(
              leading: Icon(Icons.search),
              title: const Text('Search DIY Journals'),
              onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage()),
                   );
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: const Text('Homepage'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            ),
          ]
      )
    );
  }
}

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: Colors.purple[800],
              ),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Do It Youself!",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}
