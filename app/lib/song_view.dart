import 'package:flutter/material.dart';

import 'common.dart';

class SongData {
  SongData(this.name, this.album, this.artist, this.publisher, this.releaseDate,
      this.imagePath);

  String name;
  String album;
  String artist;
  String publisher;
  DateTime releaseDate;

  String imagePath;
}

class SongView extends StatelessWidget {
  final SongData viewedSongData;

  const SongView(this.viewedSongData);

  Widget _buildSongInfoTab() {
    return new ListView(
      children: <Widget>[
        new Image.asset(
          viewedSongData.imagePath,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new InfoSection('Song Title', viewedSongData.name),
        new InfoSection('Album Name', viewedSongData.album),
        new InfoSection('Artist Name', viewedSongData.artist),
        new InfoSection('Label', viewedSongData.publisher),
        new InfoSection('Release Date', viewedSongData.releaseDate.toString()),
      ],
    );
  }

  Widget _buildSongLinksTab() {
    final _biggerFont =
        new TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

    return new Container(
      padding: EdgeInsets.all(16.0),
      child: GridView.count(
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
        crossAxisCount: 2,
        children: <Widget>[
          new RaisedButton(
            child: Text(
              'SoundCloud',
              style: _biggerFont,
            ),
            onPressed: () {},
          ),
          new RaisedButton(
            child: Text(
              'Spotify',
              style: _biggerFont,
            ),
            onPressed: () {},
          ),
          new RaisedButton(
            child: Text(
              'Youtube',
              style: _biggerFont,
            ),
            onPressed: () {},
          ),
          new RaisedButton(
            child: Text(
              'Napster',
              style: _biggerFont,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSongCommentsTab() {
    return new Text("data");
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
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
          title: new Text(viewedSongData.name),
        ),
        body: new TabBarView(
          children: [
            _buildSongInfoTab(),
            _buildSongLinksTab(),
            _buildSongCommentsTab(),
          ],
        ),
      ),
    );
  }
}
