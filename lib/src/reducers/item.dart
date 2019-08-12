// Vendor
import 'package:redux/redux.dart';

// Application
import 'package:todo_app/src/states/item.dart';
import 'package:todo_app/src/actions/item.dart';

final itemReducer = combineReducers<ItemReduxState>([
  TypedReducer<ItemReduxState, FetchItem>(_fetchItem),
  TypedReducer<ItemReduxState, FetchItemFailure>(_fetchItemFailure),
  TypedReducer<ItemReduxState, FetchItemSuccess>(_fetchItemSuccess),
  // TypedReducer<ItemReduxState, RemoveItem>(_removeItem),
]);

ItemReduxState _fetchItem(ItemReduxState state, FetchItem action) {
  return state
      .copyWith(
        isFetching: true,
      )
      .clearItem()
      .clearFetchingError();
}

ItemReduxState _fetchItemFailure(
    ItemReduxState state, FetchItemFailure action) {
  return state.copyWith(
    isFetching: false,
  
    fetchingError: action.error,
  );
}

ItemReduxState _fetchItemSuccess(
    ItemReduxState state, FetchItemSuccess action) {
  return state.copyWith(
    isFetching: false,
    item: action.item,
  );
}

// ItemReduxState _removeItem(ItemReduxState state, RemoveItem action) {
//   return state.copyWith(
//     items: state.items.where((i) => i.id != action.id),
//   );
// }
