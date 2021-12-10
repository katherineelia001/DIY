// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:diy/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:diy/models/article.dart';
import 'package:diy/screens/view_article.dart';
import 'package:diy/screens/add_article.dart';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? atSign = AtClientManager.getInstance().atClient.getCurrentAtSign();
  var atClientManager = AtClientManager.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          const Text("Text View"),
          ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddArticle()),
              )
            },
            child: const Text("Add Article"),
          ),
          FutureBuilder(
            future: scanYourArticles(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                List<Map<String, dynamic>> results = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (BuildContext context, int index) {
                      // print(results);
                      // Article article = Article(
                      //     name: "Testing", isPrivate: false, privateFields: {});
                      var articlejson =
                          json.decode(results[index].values.elementAt(0));
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
                            child: Text(results[index].keys.elementAt(0)),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return const Text("HAS NO DATA");
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
