import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'common.dart';

Future<SongData> fetchSongData(id) async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/users/1');
  final responseJson = json.decode(response.body);

  return new SongData.fromJson(responseJson);
}

class SongData {
  SongData(this.name, this.album, this.artist, this.publisher, this.releaseDate,
      this.imagePath);

  String name;
  String album;
  String artist;
  String publisher;
  DateTime releaseDate;

  String imagePath;

  SongData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        album = json['username'],
        artist = json['email'],
        publisher = json['phone'],
        releaseDate = new DateTime(2016) {
    imagePath = "images/lake.jpg";
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'album': album,
        'artist': artist,
        'publisher': publisher,
        'releaseData': releaseDate,
      };
}

class SongView extends StatelessWidget {
  final Future<SongData> futureSongData;

  const SongView(this.futureSongData);

  Widget _buildSongInfoTab(viewedSongData) {
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

  Widget _buildSongLinksTab(viewedSongData) {
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
    return new NestedComment();
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
          // title: new Text(viewedSongData.name),
        ),
        body: new FutureBuilder<SongData>(
          future: futureSongData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new TabBarView(
                children: [
                  _buildSongInfoTab(snapshot.data),
                  _buildSongLinksTab(snapshot.data),
                  _buildSongCommentsTab(),
                ],
              );
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }

            return new Center(
              child: new CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
