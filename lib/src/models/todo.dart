class ToDo {
  final String id;
  final String title;
  final bool isResolved;

  ToDo({
    this.id,
    this.title,
    this.isResolved = false,
  });

  ToDo.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        title = json['title'],
        isResolved = json['completed'];
}