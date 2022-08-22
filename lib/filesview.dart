// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:icards/model.dart';
import 'package:scoped_model/scoped_model.dart';

class FilesLeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModel>(builder: (context, child, model) {
      return Expanded(
        child: ListView.builder(
          itemCount: model.files.length,
          itemBuilder: (context, i) {
            final item = model.files[i];
            return ListTile(
              title: Text(item),
              onTap: () {
                model.currentFile = item;
                Navigator.pop(context);
              },
            );
          },
        )
      );
    });
  }
}
