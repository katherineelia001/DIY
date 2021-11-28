// ignore_for_file: constant_identifier_names

class Article {
  String name;
  String? description;
  DateTime? datePosted = DateTime.now();
  String? diff;
  List<String>? tools;
  List<String>? steps;
  bool isPrivate = false;
  Map<String, bool> privateFields;

  Article(
      {required this.name,
      this.description,
      this.datePosted,
      this.diff,
      this.tools,
      this.steps,
      required this.isPrivate,
      required this.privateFields});

  Map toJson() {
    return {
      'name': name,
      'description': description,
      "datePosted": datePosted,
      "difficulty": diff,
      'tools': tools,
      'steps': steps,
      'isPrivate': isPrivate,
      'privateFields': privateFields
    };
  }

  Article fromJson(Map<String, dynamic> map) {
    return Article(
        name: map['name'],
        description: map['description'],
        datePosted: map['datePosted'],
        diff: map['difficulty'],
        tools: map['tools'],
        steps: map['steps'],
        isPrivate: map['isPrivate'],
        privateFields: map['privateFields']);
  }
}
