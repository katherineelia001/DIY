// ignore_for_file: constant_identifier_names

class Article {
  late String? name;
  late String? description;
  DateTime? datePosted = DateTime.now();
  late String? diff;
  late List<String>? tools;
  late List<String>? steps;
  late Map<String, bool>? publicFields;

  Article(
      {required this.name,
      this.description,
      this.datePosted,
      this.diff,
      this.tools,
      this.steps,
      required this.publicFields});

  Map toJson() {
    return {'name': name};
  }

  Article fromJson(Map<String, dynamic> map) {
    return Article(name: map['name'], publicFields: publicFields);
  }
}
