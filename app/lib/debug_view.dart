import 'package:flutter/material.dart';

import 'song_view.dart';
import 'album_view.dart';

class DebugView extends StatelessWidget {
  final debugAlbumData = new AlbumData(
      "Run The Jewels 3",
      "Run The Jewels",
      "Run The Jewels, Inc.",
      new DateTime(2016),
      "51:27",
      "images/lake.jpg",
      new List<SongData>.from(<SongData>[
        new SongData(
            "",
            'Down',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "",
            'Talk to Me',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "507f191e810c19729de860ea",
            'Legend Has It',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "",
            'Call Ticketron',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "",
            'Hey Kids (Bumaye)',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "",
            'Stay Gold',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "",
            'Don\'t Get Captured',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "",
            'Thieves! (Screamed the Ghost)',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "",
            '2100',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "",
            'Panther Like a Panther (Miracle Mix)',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "",
            'Everybody Stay Calm',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "",
            'Oh Mama',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "",
            'Thursday in the Danger Room',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
        new SongData(
            "",
            'A Report to the Shareholders / Kill Your Masters',
            "",
            new DateTime(2016),
            "",
            [],
            [],
            [],
            [
              {"name": "Run The Jewels"}
            ],
            {"name": "Run The Jewels 3"},
            {"name": 'Run The Jewels, Inc.'},
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg"),
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
                        builder: (context) => new SongView(
                            fetchSongData("507f191e810c19729de860ea"))));
              },
            ),
          ],
        ),
      ),
    );
  }
}
