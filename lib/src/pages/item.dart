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
            // title: Text(args.id),
            actions: <Widget>[
              IconButton(
                icon: Icon((vm.item?.isDone ?? false) ? Icons.undo : Icons.done),
                onPressed: () => vm.onDone(vm.item.id, !vm.item.isDone),
              ),
            ],
          ),
          body: vm.isFetching ?
            Center(
              child: CircularProgressIndicator(),
            ) :
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(vm.item?.title ?? 'hello'),
                  SizedBox(height: 16.0),
                  Text(vm.item?.description ?? 'hello'),
                ],
              )
            ),
        );
      },
    );
  }
}

class _ViewModel {
  final ToDo item;
  final bool isFetching;
  final Function(String, bool) onDone;

  _ViewModel({
    @required this.item,
    @required this.isFetching,
    @required this.onDone,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      item: store.state.item.item,
      isFetching: store.state.item.isFetching ?? false,
      onDone: (String id, bool isDone) => store.dispatch(DoneItem(id, isDone: isDone)),
    );
  }
}