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
  final doneItem = _createDoneItemMiddleware();
  final success = _createSuccessMiddleware();

  return [
    TypedMiddleware<AppState, FetchItem>(fetchItem),
    TypedMiddleware<AppState, DoneItem>(doneItem),
    TypedMiddleware<AppState, DoneItemSuccess>(success),
  ];
}

Middleware<AppState> _createFetchItemMiddleware() {
  return (Store store, dynamic action, NextDispatcher next) async {
    next(action);
    try {
      String url =
          'https://us-central1-experiments-1dbbd.cloudfunctions.net/todos/${action.id}';
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
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    next(action);

    store.dispatch(FetchItem(store.state.item.item.id));
  };
}

