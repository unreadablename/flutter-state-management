class ToDo {
  final String id;
  final String title;
  final bool isCompleted;

  ToDo({
    this.id,
    this.title,
    this.isCompleted = false,
  });

  ToDo.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = json['title'],
        isCompleted = json['isCompleted'];
}