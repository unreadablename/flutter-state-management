import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todo_app/src/actions/list.dart';
import 'package:todo_app/src/pages/item.dart';

import 'package:todo_app/src/store.dart';
import 'package:todo_app/src/models/todo.dart';

class ListPage extends StatelessWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      onInit: (store) => store.dispatch(FetchItems()),
      // onWillChange: (vm1) => print(vm1),
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
          appBar: AppBar(
            // title: Text(title),
          ),
          body: vm.isFetching ?
            Center(
              child: CircularProgressIndicator(),
            ) :
          ListView.builder(
            itemCount: vm.items.length,
            itemBuilder: (context, index) {
              final item = vm.items[index];

              return Dismissible(
                key: Key(item.id),
                background: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                      Text(
                        'Done',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Remove',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    // Show a snackbar. This snackbar could also contain "Undo" actions.
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text("$item removed")));
                  } else if (direction == DismissDirection.startToEnd) {
                    // Show a snackbar. This snackbar could also contain "Undo" actions.
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text("$item done")));
                  }
                },
                child: ListTile(
                  title: Text('${item.title}'),
                  onTap: () => {
                    Navigator.of(context).pushNamed('/item', arguments: ItemPageArguments(item.id))
                  },
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final List<ToDo> items;
  final bool isFetching;
  final Function(String) onRemove;

  _ViewModel({
    @required this.items,
    @required this.isFetching,
    @required this.onRemove,
  });

  // @override
  // String toString() {
  //   return '_ViewModel{items: ${items.length}, isFetching: $isFetching }';
  // }

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      items: store.state.list.items,
      isFetching: store.state.list.isFetching ?? false,
      onRemove: (String id) {
        store.dispatch(RemoveItem(id));
      },
    );
  }
}
