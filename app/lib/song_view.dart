import 'package:flutter/material.dart';

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

  SongView(this.viewedSongData);

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

  Widget _buildSongInfoTab() {
    return new ListView(
      children: <Widget>[
        new Image.asset(
          viewedSongData.imagePath,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        _buildInfoSection('Song Title', viewedSongData.name),
        _buildInfoSection('Album Name', viewedSongData.album),
        _buildInfoSection('Artist Name', viewedSongData.artist),
        _buildInfoSection('Label', viewedSongData.publisher),
        _buildInfoSection(
            'Release Date', viewedSongData.releaseDate.toString()),
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
    return new Icon(Icons.comment);
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
          title: new Text('Legend Has It - Run the Jewels'),
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
