// ignore_for_file: constant_identifier_names

class Article {
  String name;
  String? description;
  DateTime? datePosted;
  String? difficulty;
  List<String>? tools;
  List<String>? steps;
  // List<String>? tags;
  bool isPrivate = false;
  Map<String, bool>? privateFields;

  Article(
      {required this.name,
      this.description,
      this.datePosted,
      this.difficulty,
      this.tools,
      this.steps,
      // this.tags,
      required this.isPrivate,
      required this.privateFields});

  Map toJson() {
    return {
      'name': name,
      'description': privateFields!['description'] == null ||
              privateFields!['description'] == true
          ? null
          : description,
      "datePosted": privateFields!['datePosted'] == null ||
              privateFields!['datePosted'] == true
          ? null
          : datePosted,
      "difficulty": difficulty,
      'tools':
          privateFields!['tools'] == null || privateFields!['tools'] == true
              ? null
              : tools,
      'steps':
          privateFields!['steps'] == null || privateFields!['steps'] == true
              ? null
              : steps,
      // 'tags': privateFields!['tags'] == null || privateFields!['tags'] == true
      //     ? null
      //     : tags,
      'isPrivate': isPrivate,
      'privateFields': privateFields
    };
  }

  Article fromJson(Map<String, dynamic> map) {
    return Article(
        name: map['name'],
        description: map['description'],
        datePosted: map['datePosted'],
        difficulty: map['difficulty'],
        tools: map['tools'],
        steps: map['steps'],
        // tags: map['tags'] ,
        isPrivate: map['isPrivate'],
        privateFields: map['privateFields']);
  }
}
