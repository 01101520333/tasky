class AppTaskModel {
  AppTaskModel({
    this.title,
    this.id,
    this.description,
    this.priority,
    this.date,
    this.isDone,
  });

  AppTaskModel.fromJeson(Map<String, dynamic> json)
    : this(
        title: json['title'],
        id: json['id'],
        description: json['description'],
        priority: json['priority'],
        date: DateTime.fromMillisecondsSinceEpoch(json['date']),
        isDone: json['isDone'],
      );

  String? title;
  String? id;
  String? description;
  int? priority;
  DateTime? date;
  bool? isDone;

  // to json

  Map<String, dynamic> toJson() {
    final normalDate = DateTime(date!.year, date!.month, date!.day);
    return {
      "title": title,
      "id": id,
      "description": description,
      "priority": priority,
      "date": normalDate.millisecondsSinceEpoch,
      "isDone": false,
    };
  }
}
