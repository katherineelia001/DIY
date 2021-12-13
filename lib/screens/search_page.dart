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
  List<Map<String, dynamic>> allArticles = [];
  List<Map<String, dynamic>> filteredArticles = [];

  @override
  void initState() {
    super.initState();
    scanYourArticles().then((articles) {
      setState(() {
        allArticles = articles;
        filteredArticles = articles;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Search Page'),
      ),
      body: Column(children: [
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
                  borderRadius: BorderRadius.all(Radius.circular(25.0),
                  )
                  )
                  ),
          ),
        ),
        Expanded(
            child: filteredArticles.isEmpty
                ? const Text(
                    'No results found.',
                  )
                : ListView.builder(
                    itemCount: filteredArticles.length,
                    itemBuilder: (BuildContext context, int index) {
                      var article = Article.fromJson(filteredArticles[index]);

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
                          // child: Card(
                          //   elevation: 0,
                          //   child: Text(article.name),

                            child: Card(
                                elevation: 0,
                                color: Colors.grey[850],
                                child: Column(children: [
                                  Text(article.name,
                                      textAlign: TextAlign.center,
                                      style: (const TextStyle(
                                          color: Colors.white,
                                          fontSize: 26,
                                          height: 1.5))),
                                  Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(article.description!,
                                          style: const TextStyle(
                                              color: Colors.white))),
                                  (article.difficulty != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: RichText(
                                              text:
                                                  TextSpan(children: <TextSpan>[
                                            const TextSpan(
                                                text: "Difficulty: ",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                            TextSpan(
                                                text: article.difficulty!,
                                                style: const TextStyle(
                                                    color: Colors.white))
                                          ])))
                          : Container()),
                                ]))),
                        );
                      
                    },
                  )),
      ]),
    );
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results;
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = allArticles;
    } else {
      results = allArticles.where((articles) {
        // print(articles.values.first);
        return (articles["name"] as String).toLowerCase().contains(enteredKeyword.toLowerCase());
      }).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      filteredArticles = results;
    });
  }

  Future<List<Map<String, dynamic>>> scanYourArticles() async {
    var atClientManager = AtClientManager.getInstance();

    List<AtKey> response = await atClientManager.atClient.getAtKeys(sharedWith: atSign);

    List<Map<String, dynamic>> values = [];

    for (AtKey key in response) {
      String? keyStr = key.key;
      if (keyStr != "signing_privatekey") {
        var val = await lookup(key);
        print(val);
        if (val != null) {
          Map<String, dynamic> data = jsonDecode(val);
          values.add(data);
        }

        // var isDeleted = await atClientManager.atClient.delete(key);
        // isDeleted ? print("Deleted") : print("Not Deleted");
      }
    }

    return values;
  }

  Future<List<Map<String, dynamic>>> scanNamespaceArticles() async {
    var atClientManager = AtClientManager.getInstance();
    String myRegex = '^(?!public).*diy.*';
    List<AtKey> response = await atClientManager.atClient.getAtKeys(regex: myRegex);
    List<Map<String, dynamic>> values = [];

    for (AtKey key in response) {
      String? keyStr = key.key;
      String val = await lookup(key);
      values.add(jsonDecode(val));
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