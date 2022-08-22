// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:icards/model.dart';
import 'package:icards/utils.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  final model = MyModel();
  model.loadAll();
  model.currentFile = "spanish.txt";
  runApp(ScopedModel<MyModel>(model: model, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "iCards",
      theme: ThemeData(primarySwatch: Colors.green),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int n = 0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Tommy's iCards"),
        ),
        body: GestureDetector(
          onTap: nextWord,
          child: Center(
            child: Text(model.tokens.isNotEmpty ? model.tokens[n].item2 : "Loading...", style: Theme.of(context).textTheme.headline5),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Utils.showMessage(context, model.tokens[n].item2, model.tokens[n].item1),
          tooltip: "Show hint",
          child: const Icon(Icons.help_rounded)
        ),
      );
    });
  }

  void nextWord() {
    setState(() {
      n++;
    });
  }
}
