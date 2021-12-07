import 'dart:convert';
import 'dart:io';

import 'package:diy/models/article.dart';
import 'package:flutter/material.dart';

class ViewArticle extends StatelessWidget {
  const ViewArticle({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    // final decodedBytes = base64Encode(article.images![0]);
    // var file = File("decodedBezkoder.png");
    // file.writeAsBytesSync(decodedBytes);
    return Scaffold(
        appBar: AppBar(
          title: Text(article.name),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // (article.description != null
              //     ? Text(article.description!)
              //     : Container()),
              // Text(article.difficulty!),
              // Text(article.images![0]),
              (article.images != null
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.memory(
                        base64Decode(article.images![0]),
                        fit: BoxFit.fill,
                      ),
                    )
                  : Container()),
              Text(article.name),
            ],
          ),
        ));
  }
}
