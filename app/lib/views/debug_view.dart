import 'package:app/data/profile_data.dart';
import 'package:app/views/register_view.dart';
import 'package:app/views/search_view.dart';
import 'package:flutter/material.dart';

import 'package:app/data/song_data.dart';
import 'package:app/data/album_data.dart';
import 'package:app/data/artist_data.dart';
import 'package:app/data/home_data.dart';
import 'package:app/views/song_view.dart';
import 'package:app/views/album_view.dart';
import 'package:app/views/artist_view.dart';
import 'package:app/views/home_view.dart';
import 'package:app/views/profile_view.dart';
import 'package:app/views/playlist_view.dart';

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
                            "My Side of the Fence",
                            fetchSongData("My Side of the Fence"))));
              },
            ),
            new RaisedButton(
              child: new Text('Album View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new AlbumView(
                            "Pray For The Wicked",
                            fetchAlbumData("Pray For The Wicked"))));
              },
            ),
            new RaisedButton(
              child: new Text('Artist View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new ArtistView("Paul McCartney",
                            fetchArtistData("Paul McCartney"))));
              },
            ),
            new RaisedButton(
              child: new Text('Search View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SearchView()));
              },
            ),
            new RaisedButton(
              child: new Text('Profile View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new ProfileView("", fetchProfileData(""))));
              },
            ),
            new RaisedButton(
              child: new Text('Playlist View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new PlaylistView()));
              },
            ),
            new RaisedButton(
              child: new Text('Home View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new HomeView(fetchHomeData())));
              },
            ),
            new RaisedButton(
              child: new Text('Register View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new RegisterView()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
