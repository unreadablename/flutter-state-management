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

class RemoveItemSuccess {
  @override
  String toString() {
    return 'RemoveItemSuccess{}';
  }
}

class RemoveItemFailure {
  final Error error;

  RemoveItemFailure(this.error);

  @override
  String toString() {
    return 'RemoveItemFailure{error: $error}';
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

class ResolveItemSuccess {
  @override
  String toString() {
    return 'ResolveItemSuccess{}';
  }
}

class ResolveItemFailure {
  final Error error;

  ResolveItemFailure(this.error);

  @override
  String toString() {
    return 'ResolveItemFailure{error: $error}';
  }
}