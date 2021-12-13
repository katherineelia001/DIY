

import 'package:diy/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:diy/screens/home_screen.dart';
import 'package:diy/screens/add_article.dart';





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
            ListTile(
              leading: const Icon(Icons.search),
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
              leading: const Icon(Icons.home),
              title: const Text('Homepage'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              }
            ),
            ListTile(
              leading: const Icon(Icons.note_add_rounded),
              title: const Text('Add a new article'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddArticle()),
                );
              }
            ),
            ListTile(
              leading: const Icon(Icons.article_sharp),
              title: const Text('My articles'),
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
      decoration: const BoxDecoration(
          color: Colors.black,
              ),
      child: Stack(children: const <Widget>[
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
