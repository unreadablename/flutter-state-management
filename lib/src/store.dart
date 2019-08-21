// Vendor
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

// Application
import 'package:todo_app/src/reducers/list.dart';
import 'package:todo_app/src/reducers/item.dart';

import 'package:todo_app/src/states/list.dart';
import 'package:todo_app/src/states/item.dart';

import 'package:todo_app/src/middlewares/list.dart';
import 'package:todo_app/src/middlewares/item.dart';

class AppState {
  final ListReduxState list;
  final ItemReduxState item;

  AppState({
    this.list = const ListReduxState(),
    this.item = const ItemReduxState(),
  });

  @override
  String toString() {
    return 'AppState{list: $list, item: $item}';
  }
}


AppState appReducer(AppState state, action) {
  return AppState(
    list: listReducer(state.list, action),
    item: itemReducer(state.item, action),
  );
}

Store<AppState> createStore () {
  return Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: []
      ..addAll(createListMiddleware())
      ..addAll(createItemMiddleware())
      ..add(LoggingMiddleware.printer()),
  );
}