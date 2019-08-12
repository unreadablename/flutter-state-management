// Vendor
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

// Application
import 'package:todo_app/src/store.dart';
import 'package:todo_app/src/pages/list.dart';
import 'package:todo_app/src/pages/item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = createStore();

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        title: 'Flutter To Do',
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => ListPage(),
          '/item':  (BuildContext context) => ItemPage(),
        },
      ),
    );
  }
}
