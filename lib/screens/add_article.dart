import 'package:flutter/material.dart';

import 'package:at_client_mobile/at_client_mobile.dart';

class AddArticle extends StatefulWidget {
  const AddArticle({Key? key}) : super(key: key);

  @override
  State<AddArticle> createState() => _AddArticleState();
}

bool isSwitched = true;

class _AddArticleState extends State<AddArticle> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descController = TextEditingController();

    // var atClientManager = AtClientManager.getInstance();
    // print(atClientManager.atClient.getCurrentAtSign());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Article'),
      ),
      body: Column(
        children: [newMethod(nameController)],
      ),
    );
  }

  Container newMethod(TextEditingController nameController) {
    return Container(
      width: MediaQuery.of(context).size.width * .5,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: nameController,
              onChanged: (_) {
                print(nameController.text);
              },
              decoration: const InputDecoration(
                hintText: "Enter aricle name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                ),
              ),
            ),
          ),
          Switch(
            value: isSwitched,
            onChanged: (bool val) {
              setState(() {
                isSwitched = val;
              });
            },
            // activeTrackColor: Colors.lightGreenAccent,
            // activeColor: Colors.green
          ),
        ],
      ),
    );
  }
}
