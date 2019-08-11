import 'dart:async';

// Vendor
import 'package:redux/redux.dart';

// Application
import 'package:todo_app/src/store.dart';
import 'package:todo_app/src/models/todo.dart';

import 'package:todo_app/src/actions/list.dart';

List<Middleware<AppState>> createListMiddleware() {
  final fetchItems = _createFetchItemsMiddleware();

  return [
    TypedMiddleware<AppState, FetchItems>(fetchItems),
  ];
}

Middleware<AppState> _createFetchItemsMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    next(action);
    try {
      // wait for loading simulation
      await Future.delayed(const Duration(seconds: 2), () => "1");

      final items = List<ToDo>.generate(
          20,
          (i) => ToDo(
                id: '$i',
                title: "Item ${i + 1}",
              ));

      store.dispatch(FetchItemsSuccess(items));
    } catch (error) {
      store.dispatch(FetchItemsFailure(error));
    }
  };
}
