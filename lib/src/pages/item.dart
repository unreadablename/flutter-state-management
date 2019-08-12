import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:todo_app/src/store.dart';
import 'package:todo_app/src/models/todo.dart';
import 'package:todo_app/src/actions/item.dart';

class ItemPageArguments {
  final String id;

  ItemPageArguments(this.id);
}

class ItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ItemPageArguments args = ModalRoute.of(context).settings.arguments;

    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      onInit: (store) => store.dispatch(FetchItem(args.id)),
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text(args.id),
          ),
          body: vm.isFetching ?
            Center(
              child: CircularProgressIndicator(),
            ) :
            Container(
              child: Text(vm.item?.title ?? ''),
            ),
        );
      },
    );
  }
}

class _ViewModel {
  final ToDo item;
  final bool isFetching;
  final Function(String) onRemove;

  _ViewModel({
    @required this.item,
    @required this.isFetching,
    @required this.onRemove,
  });

  // @override
  // String toString() {
  //   return '_ViewModel{items: ${items.length}, isFetching: $isFetching }';
  // }

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      item: store.state.item.item,
      isFetching: store.state.item.isFetching ?? false,
      onRemove: (String id) {
        store.dispatch(RemoveItem(id));
      },
    );
  }
}