import 'package:flutter/material.dart';

import 'song_view.dart';
import 'album_view.dart';
import 'artist_view.dart';
import 'publisher_view.dart';

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
                        builder: (context) => new SongView(
                            fetchSongData("507f191e810c19729de860ea"))));
              },
            ),
            new RaisedButton(
              child: new Text('Album View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                        new AlbumView(fetchAlbumData(""))));
              },
            ),
            new RaisedButton(
              child: new Text('Artist View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new ArtistView(fetchArtistData(""))));
              },
            ),
            new RaisedButton(
              child: new Text('Publisher View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new PublisherView(fetchPublisherData(""))));
              },
            ),
          ],
        ),
      ),
    );
  }
}
