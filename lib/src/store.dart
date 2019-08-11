// Vendor
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

// Application
import 'package:todo_app/src/reducers/list.dart';
import 'package:todo_app/src/states/list.dart';
import 'package:todo_app/src/middlewares/list.dart';

class AppState {
  final bool isLoading;
  final ListReduxState list;

  AppState({
    this.isLoading = false,
    this.list = const ListReduxState(),
  });

  AppState copyWith({
    bool isLoading,
  }) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, list: $list}';
  }
}


AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: false,
    list: listReducer(state.list, action),
  );
}

Store<AppState> createStore () {
  return Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: []
      ..addAll(createListMiddleware())
      ..add(new LoggingMiddleware.printer()),
  );
}