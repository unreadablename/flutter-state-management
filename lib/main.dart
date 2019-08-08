import 'package:flutter/material.dart';

import 'package:todo_app/src/pages/item.dart';

import 'package:todo_app/src/models/item.dart';

import 'package:todo_app/src/data.dart' as data;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To Do',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
//      home: MyHomePage(title: 'To Do'),
      routes: {
        '/': (context) => MyHomePage(title: 'To Do'),
        '/item': (context) => ItemPage(),
      },
    );
  }
}

//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
//
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

//  int _counter = 0;

  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: data.items.length,
        itemBuilder: (context, index) {
          final item = data.items[index];

          return Dismissible(
            // Each Dismissible must contain a Key. Keys allow Flutter to
            // uniquely identify widgets.
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
            // Provide a function that tells the app
            // what to do after an item has been swiped away.
            onDismissed: (direction) {
              print(direction);
              data.items.removeAt(index);

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
              subtitle: item.description != '' ? Text('${item.description}') : null,
              onTap: () => {
                Navigator.of(context).pushNamed('/item')
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
