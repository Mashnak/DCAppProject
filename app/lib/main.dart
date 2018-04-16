import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  Widget _buildInfoSection(String sectionName, String sectionValue) {
    return new Container(
      padding: const EdgeInsets.all(12.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    sectionName,
                    style: new TextStyle(color: Colors.grey),
                  ),
                ),
                new Text(sectionValue,
                    style: new TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Song Finder',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            bottom: new TabBar(
              tabs: [
                new Tab(
                  icon: new Icon(Icons.info),
                ),
                new Tab(
                  icon: new Icon(Icons.music_note),
                ),
                new Tab(
                  icon: new Icon(Icons.comment),
                )
              ],
            ),
            title: new Text('Legend Has It - Run the Jewels'),
          ),
          body: new TabBarView(
            children: [
              new ListView(
                children: <Widget>[
                  new Image.asset(
                    'images/lake.jpg',
                    height: 240.0,
                    fit: BoxFit.cover,
                  ),
                  _buildInfoSection('Song Title', 'Legend Has It'),
                  _buildInfoSection('Album Name', 'Run The Jewels 3'),
                  _buildInfoSection('Artist Name', 'Run The Jewels'),
                  _buildInfoSection('Label', 'Run The Jewels, Inc.'),
                  _buildInfoSection('Release Date', '2016'),
                ],
              ),
              new Icon(Icons.music_note),
              new Icon(Icons.comment)
            ],
          ),
        ),
      ),
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
*/
