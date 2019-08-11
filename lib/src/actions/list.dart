import 'package:todo_app/src/models/todo.dart';

class FetchItems {
  FetchItems();

  @override
  String toString() {
    return 'FetchItems{}';
  }
}

class FetchItemsSuccess {
  final List<ToDo> items;

  FetchItemsSuccess(this.items);

  @override
  String toString() {
    return 'FetchItemsSuccess{items: ${items.length}}';
  }
}

class FetchItemsFailure {
  final Error error;

  FetchItemsFailure(this.error);

  @override
  String toString() {
    return 'FetchItemsFailure{error: $error}';
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
