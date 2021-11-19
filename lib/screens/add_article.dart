// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_commons/at_commons.dart';

import '../models/article.dart';

class AddArticle extends StatefulWidget {
  const AddArticle({Key? key}) : super(key: key);

  @override
  State<AddArticle> createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  bool isDescPublic = false;
  bool isToolsPublic = false;
  bool isStepsPublic = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController toolsController = TextEditingController();
  TextEditingController stepsController = TextEditingController();
  var dropDownItems = ["", "Easy", "Medium", "Hard"];
  String selectedDifficulty = "";

  @override
  Widget build(BuildContext context) {
    var atClientManager = AtClientManager.getInstance();
    // Metadata data = Metadata()..isPublic = false;
    // AtKey key = AtKey()
    //   ..key = "Hello Word"
    //   ..metadata = data;
    // atClientManager.atClient.put(key, "Testing");
    // print(key.toString());
    AtKey key = AtKey()..key = "Hello Word";
    // print(atClientManager.atClient.get(key));
    // print(atClientManager.atClient.getKeys());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Article'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  TextFieldWidget(
                    controller: nameController,
                    text: "Enter Article name",
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  TextFieldWidget(
                    controller: descController,
                    isTextArea: true,
                    text: "Enter Article description",
                  ),
                  Switch(
                    value: isDescPublic,
                    onChanged: (bool val) {
                      setState(() {
                        isDescPublic = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  TextFieldWidget(
                    controller: toolsController,
                    isTextArea: true,
                    text: "Enter tool nessesary (seperated by ,)",
                  ),
                  Switch(
                    value: isToolsPublic,
                    onChanged: (bool val) {
                      setState(() {
                        isToolsPublic = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  TextFieldWidget(
                    controller: stepsController,
                    isTextArea: true,
                    text: "Enter steps to complete",
                  ),
                  Switch(
                    value: isStepsPublic,
                    onChanged: (bool val) {
                      setState(() {
                        isStepsPublic = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            DropdownButton(
              value: selectedDifficulty,
              items:
                  dropDownItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? val) {
                setState(() => selectedDifficulty = val!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.text,
    this.isTextArea = false,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isTextArea;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        maxLines: isTextArea ? 5 : 1,
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
      ),
    );
  }
}
