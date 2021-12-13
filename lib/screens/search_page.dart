
import 'package:diy/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:diy/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:diy/models/article.dart';
import 'package:diy/screens/view_article.dart';
import 'package:diy/screens/add_article.dart';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}


class SearchPageState extends State<SearchPage> {
  String? atSign = AtClientManager.getInstance().atClient.getCurrentAtSign();
  var atClientManager = AtClientManager.getInstance();

    TextEditingController editingController = TextEditingController();
    late List <Map <String, dynamic>> foundArticles;

  // List<Map<String, dynamic>>? get yourlist => null;
  //   @override
  //   void initState(){
  //     super.initState();
  //     foundArticles = yourlist;
  //   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Search Page'),
        
      ),
      body:  Column(
        children: [
          FutureBuilder(
            future: scanYourArticles(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.hasData) {
                List<Map<String, dynamic>> yourlist = snapshot.data;
    void initState(){
      super.initState();
      foundArticles = yourlist;
    }
 
  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results;
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = yourlist;
    } else {
      results = yourlist
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      foundArticles = results;
    });
  }

     Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (value) => _runFilter(value),
         controller: editingController,
         decoration: const InputDecoration(
             labelText: "Search for DIY Articles",
             hintText: "Search",
             prefixIcon: Icon(Icons.search),
             border: OutlineInputBorder(
                 borderRadius: BorderRadius.all(Radius.circular(25.0)))),
         ),
     );
              Expanded(
                  //child:foundArticles.isNotEmpty
                  //? ListView.builder(
                    child: ListView.builder(
                    itemCount: foundArticles.length,
                    itemBuilder: (BuildContext context, int index) {
                      var articlejson =
                          json.decode(foundArticles[index].values.elementAt(0));
                      var article = Article.fromJson(articlejson);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewArticle(
                                  article: article,
                                ),
                              ),
                            ),
                          },
                          child: Card(
                            elevation: 0,
                            child: Text(foundArticles[index].keys.elementAt(0)),
                          ),
                        ),
                      );
                    },
                  )
                  
              );
              }
              return const Text ("HAS NO DATA");
            },
            
          ),
           ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>> scanYourArticles() async {
    var atClientManager = AtClientManager.getInstance();

    List<AtKey> response =
        await atClientManager.atClient.getAtKeys(sharedWith: atSign);

    List<Map<String, dynamic>> values = [];

    for (AtKey key in response) {
      String? keyStr = key.key;
      if (keyStr != "signing_privatekey") {
        var val = await lookup(key);
        if (val != null) values.add({keyStr!: val});
        // var isDeleted = await atClientManager.atClient.delete(key);
        // isDeleted ? print("Deleted") : print("Not Deleted");
      }
    }

    return values;
  }
    Future<List<Map<String, dynamic>>> scanNamespaceArticles() async {
    var atClientManager = AtClientManager.getInstance();
    String myRegex = '^(?!public).*diy.*';
    List<AtKey> response =
        await atClientManager.atClient.getAtKeys(regex: myRegex);

    List<Map<String, dynamic>> values = [];

    for (AtKey key in response) {
      String? keyStr = key.key;
      String val = await lookup(key);
      values.add({keyStr!: val});
      // var isDeleted = await atClientManager.atClient.delete(key);
      // isDeleted ? print("Deleted") : print("Not Deleted");
    }

    return values;
  }

  Future<dynamic> lookup(AtKey? atKey) async {
    AtClient client = atClientManager.atClient;
    if (atKey != null) {
      AtValue result = await client.get(atKey);
      return result.value;
    }
    return null;
  }
}
