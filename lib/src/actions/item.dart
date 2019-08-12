import 'package:todo_app/src/models/todo.dart';

class FetchItem {
  final String id;

  FetchItem(this.id);

  @override
  String toString() {
    return 'FetchItem{id: $id}';
  }
}

class FetchItemSuccess {
  final ToDo item;

  FetchItemSuccess(this.item);

  @override
  String toString() {
    return 'FetchItemSuccess{item: $item}';
  }
}

class FetchItemFailure {
  final Error error;

  FetchItemFailure(this.error);

  @override
  String toString() {
    return 'FetchItemFailure{error: $error}';
  }
}

class RemoveItem {
  final String id;

  RemoveItem(this.id);

  @override
  String toString() {
    return 'RemoveItem{id: $id}';
  }
}

class ResolveItem {
  final String id;

  ResolveItem(this.id);

  @override
  String toString() {
    return 'ResolveItem{id: $id}';
  }
}
