// ignore_for_file: constant_identifier_names

class Article {
  late String name;
  late String description;
  late DateTime date;
  late Difficulty diff;
  late List<String> tools;
  late List<String> steps;

  Article(
      {required this.name,
      required this.description,
      required this.date,
      required this.diff,
      required this.tools,
      required this.steps});
}

enum Difficulty {
  Easy,
  Medium,
  Hard,
}
