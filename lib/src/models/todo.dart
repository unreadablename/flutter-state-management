class ToDo {
  ToDo({
    this.id,
    this.title,
    this.description = '',
    this.isResolved = false,
  });

  final String id;
  final String title;
  final String description;
  final bool isResolved;
}