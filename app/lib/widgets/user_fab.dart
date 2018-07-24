import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserFAB extends StatelessWidget {
  final bool display;
  final List<SimpleDialogOption> children;

  UserFAB({this.display, this.children});

  @override
  Widget build(BuildContext context) {
    return display
        ? null
        : new FloatingActionButton(
            child: new Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext conteext) {
                    return new SimpleDialog(
                      title: const Text("Select action"),
                      children: <Widget>[],
                    );
                  });
            });
  }
}
