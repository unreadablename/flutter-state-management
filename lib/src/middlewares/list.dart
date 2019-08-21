import 'dart:convert' as json;

// Vendor
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

// Application
import 'package:todo_app/src/store.dart';
import 'package:todo_app/src/models/todo.dart';

import 'package:todo_app/src/actions/list.dart';

List<Middleware<AppState>> createListMiddleware() {
  final fetchItems = _createFetchItemsMiddleware();
  final removeItem = _createRemoveItemMiddleware();
  final completeItem = _createCompleteItemMiddleware();
  final success = _createSuccessMiddleware();

  return [
    TypedMiddleware<AppState, FetchItems>(fetchItems),
    TypedMiddleware<AppState, RemoveItem>(removeItem),
    TypedMiddleware<AppState, CompleteItem>(completeItem),
    TypedMiddleware<AppState, RemoveItemSuccess>(success),
    TypedMiddleware<AppState, CompleteItemSuccess>(success),
  ];
}

Middleware<AppState> _createFetchItemsMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    next(action);
    try {
      String url = 'https://us-central1-experiments-1dbbd.cloudfunctions.net/todos';
      http.Response response = await http.get(url);

      int statusCode = response.statusCode;
      Map<String, String> headers = response.headers;
      String contentType = headers['content-type'];

      final parsed = json.jsonDecode(response.body);

      final List<ToDo> items = List<ToDo>.from(parsed.map((i) => ToDo.fromJson(i)));

      store.dispatch(FetchItemsSuccess(items));
    } catch (error) {
      store.dispatch(FetchItemsFailure(error));
    }
  };
}

Middleware<AppState> _createRemoveItemMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    next(action);
    try {
      String url = 'https://us-central1-experiments-1dbbd.cloudfunctions.net/todos/${action.id}';
      http.Response response = await http.delete(url);

      // int statusCode = response.statusCode;

      print(response.statusCode);
      print(response.body);
      // Map<String, String> headers = response.headers;
      // String contentType = headers['content-type'];

      store.dispatch(RemoveItemSuccess());
    } catch (error) {
      store.dispatch(RemoveItemFailure(error));
    }
  };
}

Middleware<AppState> _createCompleteItemMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    next(action);
    try {
      String url = 'https://us-central1-experiments-1dbbd.cloudfunctions.net/todos/${action.id}';
      http.Response response = await http.patch(url, body: { 'completed': true });
      print(response.body);

      store.dispatch(CompleteItemSuccess());
    } catch (error) {
      store.dispatch(CompleteItemFailure(error));
    }
  };
}

Middleware<AppState> _createSuccessMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    next(action);

    store.dispatch(FetchItems());
  };
}