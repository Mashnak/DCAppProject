// Author: Timur Bahadir

import 'package:flutter/material.dart';

import 'package:app/views/debug_view.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Song Finder',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new DebugView());
  }
}
