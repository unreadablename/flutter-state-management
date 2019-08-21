// Vendor
import 'package:redux/redux.dart';

// Application
import 'package:todo_app/src/states/list.dart';
import 'package:todo_app/src/actions/list.dart';

final listReducer = combineReducers<ListReduxState>([
  TypedReducer<ListReduxState, FetchItems>(_fetchItems),
  TypedReducer<ListReduxState, FetchItemsFailure>(_fetchItemsFailure),
  TypedReducer<ListReduxState, FetchItemsSuccess>(_fetchItemsSuccess),
  TypedReducer<ListReduxState, RemoveItem>(_removeItem),
]);

ListReduxState _fetchItems(ListReduxState state, FetchItems action) {
  return state.copyWith(
    isFetching: true,
    items: [],
  ).nullFetchingError();
}

ListReduxState _fetchItemsFailure(ListReduxState state, FetchItemsFailure action) {
  return state.copyWith(
    isFetching: false,
    items: [],
    fetchingError: action.error,
  );
}

ListReduxState _fetchItemsSuccess(ListReduxState state, FetchItemsSuccess action) {
  return state.copyWith(
    isFetching: false,
    items: action.items,
  );
}

ListReduxState _removeItem(ListReduxState state, RemoveItem action) {
  return state.copyWith(
    // items: state.items.where((i) => i.id != action.id),
    isFetching: true,
  );
}
