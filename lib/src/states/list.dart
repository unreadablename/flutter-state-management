import 'package:meta/meta.dart';

import 'package:todo_app/src/models/todo.dart';

@immutable
class ListReduxState {
  final List<ToDo> items;
  final bool isFetching;
  final Error fetchingError;

  const ListReduxState({
    this.items = const [],
    this.isFetching = false,
    this.fetchingError,
  });

  ListReduxState copyWith({
    List<ToDo> items,
    bool isFetching,
    Error fetchingError,
  }) {
    return ListReduxState(
      items: items ?? this.items,
      isFetching: isFetching ?? this.isFetching,
      fetchingError: fetchingError ?? this.fetchingError,
    );
  }

  ListReduxState nullFetchingError() {
    return ListReduxState(
      items: this.items,
      isFetching: this.isFetching,
      fetchingError: null,
    );
  }

  @override
  String toString() {
    return 'ListReduxState{items: ${items.length}, isFetching: $isFetching, fetchingError: $fetchingError }';
  }
}
