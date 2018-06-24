import 'package:app/home_view.dart';
import 'package:flutter/material.dart';

import 'playlist_view.dart';
import 'profile_view.dart';
import 'search_view.dart';
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
              child: new Text('Publisher View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new PublisherView(fetchPublisherData(""))));
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
                            new ProfileView(fetchProfileData(""))));
              },
            ),
            new RaisedButton(
              child: new Text('Playlist View'),
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new PlaylistView(fetchPlaylistData(""))));
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
          ],
        ),
      ),
    );
  }
}
