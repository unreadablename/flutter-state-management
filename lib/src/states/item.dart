import 'package:meta/meta.dart';

import 'package:todo_app/src/models/todo.dart';

@immutable
class ItemReduxState {
  final ToDo item;
  final bool isFetching;
  final Error fetchingError;

  const ItemReduxState({
    this.item,
    this.isFetching = false,
    this.fetchingError,
  });

  ItemReduxState copyWith({
    ToDo item,
    bool isFetching,
    Error fetchingError,
  }) {
    return ItemReduxState(
      item: item ?? this.item,
      isFetching: isFetching ?? this.isFetching,
      fetchingError: fetchingError ?? this.fetchingError,
    );
  }

  ItemReduxState clearItem() {
    return ItemReduxState(
      item: null,
      isFetching: this.isFetching,
      fetchingError: this.fetchingError,
    );
  }

  ItemReduxState clearFetchingError() {
    return ItemReduxState(
      item: this.item,
      isFetching: this.isFetching,
      fetchingError: null,
    );
  }

  @override
  String toString() {
    return 'ListReduxState{item: $item, isFetching: $isFetching, fetchingError: $fetchingError }';
  }
}
