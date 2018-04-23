import 'package:flutter/material.dart';

import 'song_view.dart';
import 'album_view.dart';

class DebugView extends StatelessWidget {
  final debugSongData = new SongData(
      'Legend Has It',
      'Run The Jewels 3',
      'Run The Jewels',
      'Run The Jewels, Inc.',
      new DateTime(2016),
      'images/lake.jpg');

  final debugAlbumData = new AlbumData(
      "Run The Jewels 3",
      "Run The Jewels",
      "Run The Jewels, Inc.",
      new DateTime(2016),
      "51:27",
      "images/lake.jpg",
      new List<SongData>.from(<SongData>[
        new SongData('Legend Has It', 'Run The Jewels 3', 'Run The Jewels',
            'Run The Jewels, Inc.', new DateTime(2016), 'images/lake.jpg'),
        new SongData('Down (feat. Joi)', 'Run The Jewels 3', 'Run The Jewels',
            'Run The Jewels, Inc.', new DateTime(2016), 'images/lake.jpg'),
        new SongData('Talk to Me', 'Run The Jewels 3', 'Run The Jewels',
            'Run The Jewels, Inc.', new DateTime(2016), 'images/lake.jpg'),
        new SongData('Call Ticketron', 'Run The Jewels 3', 'Run The Jewels',
            'Run The Jewels, Inc.', new DateTime(2016), 'images/lake.jpg'),
        new SongData(
            'Hey Kids (Bumaye) (featuring Danny Brown)',
            'Run The Jewels 3',
            'Run The Jewels',
            'Run The Jewels, Inc.',
            new DateTime(2016),
            'images/lake.jpg'),
        new SongData('Stay Gold', 'Run The Jewels 3', 'Run The Jewels',
            'Run The Jewels, Inc.', new DateTime(2016), 'images/lake.jpg'),
        new SongData(
            'Don\'t Get Captured',
            'Run The Jewels 3',
            'Run The Jewels',
            'Run The Jewels, Inc.',
            new DateTime(2016),
            'images/lake.jpg'),
        new SongData(
            'Thieves! (Screamed the Ghost) (featuring Tunde Adebimpe)',
            'Run The Jewels 3',
            'Run The Jewels',
            'Run The Jewels, Inc.',
            new DateTime(2016),
            'images/lake.jpg'),
        new SongData(
            '2100 (featuring Boots)',
            'Run The Jewels 3',
            'Run The Jewels',
            'Run The Jewels, Inc.',
            new DateTime(2016),
            'images/lake.jpg'),
        new SongData(
            'Panther Like a Panther (Miracle Mix) (featuring Trina)',
            'Run The Jewels 3',
            'Run The Jewels',
            'Run The Jewels, Inc.',
            new DateTime(2016),
            'images/lake.jpg'),
        new SongData(
            'Everybody Stay Calm',
            'Run The Jewels 3',
            'Run The Jewels',
            'Run The Jewels, Inc.',
            new DateTime(2016),
            'images/lake.jpg'),
        new SongData('Oh Mama', 'Run The Jewels 3', 'Run The Jewels',
            'Run The Jewels, Inc.', new DateTime(2016), 'images/lake.jpg'),
        new SongData(
            'Thursday in the Danger Room (featuring Kamasi Washington)',
            'Run The Jewels 3',
            'Run The Jewels',
            'Run The Jewels, Inc.',
            new DateTime(2016),
            'images/lake.jpg'),
        new SongData(
            'A Report to the Shareholders / Kill Your Masters',
            'Run The Jewels 3',
            'Run The Jewels',
            'Run The Jewels, Inc.',
            new DateTime(2016),
            'images/lake.jpg'),
      ]));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Debug View'),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            // new RaisedButton(
            //   child: new Text('Song View'),
            //   onPressed: () {
            //     Navigator.push(
            //         context,
            //         new MaterialPageRoute(
            //             builder: (context) => new SongView(debugSongData)));
            //   },
            // ),
            new RaisedButton(
              child: new Text('Album View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new AlbumView(debugAlbumData)));
              },
            ),
            new RaisedButton(
              child: new Text('REST Song View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new SongView(fetchSongData("id"))));
              },
            ),
          ],
        ),
      ),
    );
  }
}
