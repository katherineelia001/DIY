import 'dart:async';

import 'package:flutter/material.dart';
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart'
    show Onboarding;
import 'package:at_utils/at_logger.dart' show AtSignLogger;
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;
import 'package:at_app_flutter/at_app_flutter.dart' show AtEnv;

Future<void> main() async {
  await AtEnv.load();
  runApp(const MyApp());
}

Future<AtClientPreference> loadAtClientPreference() async {
  var dir = await getApplicationSupportDirectory();
  return AtClientPreference()
        ..rootDomain = AtEnv.rootDomain
        ..namespace = AtEnv.appNamespace
        ..hiveStoragePath = dir.path
        ..commitLogPath = dir.path
        ..isLocalStoreRequired = true
      // TODO set the rest of your AtClientPreference here
      ;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // * load the AtClientPreference in the background
  Future<AtClientPreference> futurePreference = loadAtClientPreference();
  AtClientPreference? atClientPreference;

  final AtSignLogger _logger = AtSignLogger(AtEnv.appNamespace);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // * The onboarding screen (first screen)
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MyApp'),
        ),
        body: Builder(
          builder: (context) => Center(
            child: ElevatedButton(
              onPressed: () async {
                var preference = await futurePreference;
                setState(() {
                  atClientPreference = preference;
                });
                Onboarding(
                  context: context,
                  atClientPreference: atClientPreference!,
                  domain: AtEnv.rootDomain,
                  rootEnvironment: AtEnv.rootEnvironment,
                  appAPIKey: AtEnv.appApiKey,
                  onboard: (value, atsign) {
                    _logger.finer('Successfully onboarded $atsign');
                  },
                  onError: (error) {
                    _logger.severe('Onboarding throws $error error');
                  },
                  nextScreen: const HomeScreen(),
                );
              },
              child: const Text('Onboard the @sign'),
            ),
          ),
        ),
      ),
    );
  }
}
// The class for the drawer
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Search DIY Journals'),
              onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchPage()),
                   );
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Dashboard'),
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
//* The next screen after onboarding (second screen)
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Get the AtClientManager instance
    var atClientManager = AtClientManager.getInstance();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        children: [
          const Text('Success onboarded and navigated to FirstAppScreen'),

          /// Use the AtClientManager instance to get the current atsign
          Text('Current @sign: ${atClientManager.atClient.getCurrentAtSign()}'),
          ElevatedButton(
              child: const Text('Search DIY Journals'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
              })
        ],
      ),
      drawer: const AppDrawer(),
    );
  }
}

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
      // appBar: AppBar(
      //   //drawer: const AppDrawer(),
      //   title: customSearchBar,
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           setState(() {
      //             if (customIcon.icon == Icons.search) {
      //               customIcon = const Icon(Icons.cancel);
      //               customSearchBar = const ListTile(
      //                 leading: Icon(
      //                   Icons.search,
      //                   color: Colors.white,
      //                   size: 28,
      //                 ),
      //                 title: TextField(
      //                   decoration: InputDecoration(
      //                     border: InputBorder.none,
      //                     labelText: 'type in DYI journal name...',
      //                     labelStyle: TextStyle(
      //                       color: Colors.white,
      //                       fontSize: 18,
      //                       fontStyle: FontStyle.italic,
      //                     ),
      //                   ),
      //                 ),
      //               );
      //             } else {
      //               customIcon = const Icon(Icons.search);
      //               customSearchBar = const Text('Search DIY journals');
      //             }
      //           });
      //         },
      //         icon: customIcon)
      //   ],
      // ),

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



// class ArticleListView extends StatefulWidget {
//   const ArticleListView({Key? key}) : super(key: key);

//   @override
//   _ArticleListViewState createState() => _ArticleListViewState();
// }
// class _ArticleListViewState extends State<ArticleListView> {

// @override
//   Widget build(BuildContext context) {
// final List<String> entries = <String>['A', 'B', 'C'];
// final List<int> colorCodes = <int>[600, 500, 100];
//   return ListView.builder(
//       padding: const EdgeInsets.all(8),
//       itemCount: entries.length,
//       itemBuilder: (BuildContext context, int index){
//         return Container(
//           height: 50,
//           color: Colors.amber[colorCodes[index]],
//           child: Center(child: Text('Entry ${entries[index]}')),
//         );
//       },
//     );
// }
// }
