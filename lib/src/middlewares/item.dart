import 'dart:convert' as json;

// Vendor
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;

// Application
import 'package:todo_app/src/store.dart';
import 'package:todo_app/src/models/todo.dart';

import 'package:todo_app/src/actions/item.dart';

List<Middleware<AppState>> createItemMiddleware() {
  final fetchItem = _createFetchItemMiddleware();

  return [
    TypedMiddleware<AppState, FetchItem>(fetchItem),
  ];
}

Middleware<AppState> _createFetchItemMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    next(action);
    try {
      String url = 'https://jsonplaceholder.typicode.com/todos/${action.id}';
      http.Response response = await http.get(url);

      int statusCode = response.statusCode;
      Map<String, String> headers = response.headers;
      String contentType = headers['content-type'];

      final parsed = json.jsonDecode(response.body);

      final ToDo item = ToDo.fromJson(parsed);

      store.dispatch(FetchItemSuccess(item));
    } catch (error) {
      store.dispatch(FetchItemFailure(error));
    }
    // next(action);
  };
}
