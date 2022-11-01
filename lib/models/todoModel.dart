class Todo {
  Todo({required this.title, required this.date});

  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        date = json['date'];

  String? title;
  String? date;

  Map<String, dynamic> toJson() {
    return {
      'title': title ?? '',
      'date': date ?? '',
    };
  }
}
