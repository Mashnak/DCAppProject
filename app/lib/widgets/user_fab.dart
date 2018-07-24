// Author: Timur Bahadir

import 'package:flutter/material.dart';

class UserFAB extends StatelessWidget {
  final bool display;
  final List<SimpleDialogOption> children;

  UserFAB({this.display, this.children});

  @override
  Widget build(BuildContext context) {
    return display
        ? new FloatingActionButton(
            child: new Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext conteext) {
                    return new SimpleDialog(
                      title: const Text("Select action"),
                      children: children,
                    );
                  });
            })
        : new Container(width: 0.0, height: 0.0);
  }
}
