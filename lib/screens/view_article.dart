import 'dart:convert';

import 'package:diy/models/article.dart';
import 'package:flutter/material.dart';

class ViewArticle extends StatelessWidget {
  const ViewArticle({Key? key, required this.article}) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text(article.difficulty!),
            // Text(article.images![0]),
            (article.images != null
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.memory(
                      base64Decode(article.images![0]),
                      fit: BoxFit.fill,
                    ),
                  )
                : Container()),
            (article.description != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          const Text(
                            "Description",
                            // style: Theme.of(context).textTheme.headline1,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(article.description!),
                        ],
                      ),
                    ),
                  )
                : Container()),
          ],
        ),
      ),
    );
  }
}
