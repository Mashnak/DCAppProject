import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

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

  Widget _buildSongInfoTab(SongData songData) {
    return new ListView(
      children: <Widget>[
        new Image.asset(
          songData.imagePath,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        _buildInfoSection('Song Title', songData.name),
        _buildInfoSection('Album Name', songData.album),
        _buildInfoSection('Artist Name', songData.artist),
        _buildInfoSection('Label', songData.publisher),
        _buildInfoSection('Release Date', songData.releaseDate.toString()),
      ],
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
              _buildSongInfoTab(new SongData(
                  'Legend Has It',
                  'Run The Jewels 3',
                  'Run The Jewels',
                  'Run The Jewels, Inc.',
                  new DateTime(2016),
                  'images/lake.jpg')),
              new Icon(Icons.music_note),
              new Icon(Icons.comment)
            ],
          ),
        ),
      ),
    );
  }
}
