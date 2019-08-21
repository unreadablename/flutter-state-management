class ToDo {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  ToDo({
    this.id,
    this.title,
    this.isDone = false,
    this.description = '',
  });

  ToDo.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = json['title'],
        isDone = json['isDone'] ?? false,
        description = json['description'] ?? '';
}