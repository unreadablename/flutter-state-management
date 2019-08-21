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
  final doneItem = _createDoneItemMiddleware();
  final success = _createSuccessMiddleware();

  return [
    TypedMiddleware<AppState, FetchItems>(fetchItems),
    TypedMiddleware<AppState, RemoveItem>(removeItem),
    TypedMiddleware<AppState, DoneItem>(doneItem),
    TypedMiddleware<AppState, RemoveItemSuccess>(success),
    TypedMiddleware<AppState, DoneItemSuccess>(success),
  ];
}

Middleware<AppState> _createFetchItemsMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    next(action);
    try {
      String url =
          'https://us-central1-experiments-1dbbd.cloudfunctions.net/todos';
      http.Response response = await http.get(url);

      int statusCode = response.statusCode;
      Map<String, String> headers = response.headers;
      String contentType = headers['content-type'];

      final parsed = json.jsonDecode(response.body);

      final List<ToDo> items =
          List<ToDo>.from(parsed.map((i) => ToDo.fromJson(i)));

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
      String url =
          'https://us-central1-experiments-1dbbd.cloudfunctions.net/todos/${action.id}';
      await http.delete(url);

      store.dispatch(RemoveItemSuccess());
    } catch (error) {
      store.dispatch(RemoveItemFailure(error));
    }
  };
}

Middleware<AppState> _createDoneItemMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    next(action);
    try {
      String url =
          'https://us-central1-experiments-1dbbd.cloudfunctions.net/todos/${action.id}';
      Map<String, String> headers = {"Content-type": "application/json"};
      http.Response response = await http.patch(
        url,
        headers: headers,
        body: json.jsonEncode({'isDone': action.isDone}),
      );

      store.dispatch(DoneItemSuccess());
    } catch (error) {
      store.dispatch(DoneItemFailure(error));
    }
  };
}

Middleware<AppState> _createSuccessMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    next(action);

    store.dispatch(FetchItems());
  };
}
