import 'package:flutter/material.dart';

import 'song_view.dart';
import 'album_view.dart';

class DebugView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Debug View'),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Song View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SongView(new SongData(
                            'Legend Has It',
                            'Run The Jewels 3',
                            'Run The Jewels',
                            'Run The Jewels, Inc.',
                            new DateTime(2016),
                            'images/lake.jpg'))));
              },
            ),
            new RaisedButton(
              child: new Text('Album View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new AlbumView()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
