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

  return [
    TypedMiddleware<AppState, FetchItems>(fetchItems),
  ];
}

Middleware<AppState> _createFetchItemsMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    next(action);
    try {
      String url = 'https://jsonplaceholder.typicode.com/todos';
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
    // next(action);
  };
}
