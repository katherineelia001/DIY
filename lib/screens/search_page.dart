import 'dart:async';

import 'package:diy/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart'
    show Onboarding;
import 'package:at_utils/at_logger.dart' show AtSignLogger;
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;
import 'package:at_app_flutter/at_app_flutter.dart' show AtEnv;

import '../main.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

Icon customIcon = const Icon(Icons.search);
Widget customSearchBar = const Text('Search DIY Journals');
class SearchPageState extends State<SearchPage> {
    TextEditingController editingController = TextEditingController();
  //final List<String> entries = <String>['A', 'B', 'C', 'D', 
  //'E','F','G', 'H', 'I', 'J', 'K', 'L','M','N','O','P',
  //'Q','R', 'S', 'T', 'U','V','W','X','Y','Z'];
final duplicateItems = List<String>.generate(100, (i) => "Item $i");
var items = <String>[];

@override
void initState(){
  items.addAll(duplicateItems);
  super.initState();
}

  void filterSearchResults(String query) {
    List<String> dummySearchList = <String>[];
    dummySearchList.addAll(duplicateItems);
    if(query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      dummySearchList.forEach((item) {
        if(item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
        ),
 body: Column(
   children: <Widget>[
     Padding(
       padding: const EdgeInsets.all(8.0),
       child: TextField(
         onChanged: (value) {
           filterSearchResults(value);
         },
         controller: editingController,
         decoration: const InputDecoration(
             labelText: "Search for DIY Articles",
             hintText: "Search",
             prefixIcon: Icon(Icons.search),
             border: OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(25.0)))),
         ),
     ),
     Expanded(
       child:ListView.builder(
         shrinkWrap: true,
         padding: const EdgeInsets.all(8),
         itemCount: items.length,
         itemBuilder: (BuildContext context, int index){
           return Container(
             
             height: 50,
             color: Colors.blue[100],
             child: Center(child: Text('Entry ${items[index]}')),
       );
         },
       ),
     ),
   ],
 ),
       drawer: const AppDrawer(),
        );
  }
}
