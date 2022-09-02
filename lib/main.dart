// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icards/filesview.dart';
import 'package:icards/model.dart';
import 'package:icards/utils.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  final model = MyModel();
  model.loadAll();
  runApp(ScopedModel<MyModel>(model: model, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "iCards",
      theme: ThemeData(primarySwatch: Colors.green),
      home: ScopedModelDescendant<MyModel>(builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(title: const Text("Tommy's iCards")),
          body: GestureDetector(
            onTap: () {
              if (model.token.item1.isNotEmpty) {
                Fluttertoast.showToast(msg: model.token.item1, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.grey);
              }
              model.nextToken();
            },
            child: Center(
              child: Text(
                model.token.item2.isNotEmpty ? model.token.item2 : "Press ☰ and choose file...",
                style: Theme.of(context).textTheme.headline5
              ),
            ),
          ),
          drawer: Drawer(
            child: Column(children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.lightGreen),
                  child: Text("Files", style: Theme.of(context).textTheme.headline4)
                ),
              ),
              FilesLeftDrawer(),
            ]),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: "Show hint",
            child: const Icon(Icons.help_rounded),
            onPressed: () {
              if (model.token.item1.isNotEmpty) Utils.showMessage(context, model.token.item2, model.token.item1);
            },
          ),
        );
      }),
    );
  }
}
