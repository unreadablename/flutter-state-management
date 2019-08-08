import 'package:todo_app/src/models/item.dart';

final items = List<Item>.generate(
    20,
    (i) => Item(
          id: '$i',
          title: "Item ${i + 1}",
        ));
