import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'common.dart';

Future<SongData> fetchSongData(id) async {
  print("Sending Request with " + id);

  final response = await http.get('http://10.0.2.2:8080/song?id=' + id);
  final responseJson = json.decode(response.body);

  // print("Artist Name: " + responseJson['artists']['name']);

  print(responseJson[0]["name"]);

  return new SongData.fromJson(responseJson[0]);
}

class SongData {
  SongData(
      this.id,
      this.name,
      this.length,
      this.releaseDate,
      this.lyrics,
      this.urls,
      this.genres,
      this.tags,
      this.artists,
      this.album,
      this.publisher,
      this.imagePath);

  final String id;
  final String name;
  final String length;
  final DateTime releaseDate;
  final String lyrics;

  final List urls;
  final List genres;
  final List tags;

  final List artists;
  final Map album;
  final Map publisher;

  final String imagePath;

  SongData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        length = json['length'],
        releaseDate = new DateTime(2016),
        lyrics = json['lyrics'],
        urls = json['urls'],
        genres = json['genres'],
        tags = json['tags'],
        artists = json['artists'],
        album = json['album'],
        publisher = json['publisher'],
        imagePath =
            "https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg";

  Map<String, dynamic> toJson() => {
        'name': name,
        'album': album,
        // 'artist': artist,
        'publisher': publisher,
        'releaseData': releaseDate,
        'imagePath': imagePath,
      };
}

class SongView extends StatelessWidget {
  final Future<SongData> futureSongData;

  const SongView(this.futureSongData);

  Widget _buildSongInfoTab(viewedSongData) {
    return new ListView(
      children: <Widget>[
        new Image.network(
          viewedSongData.imagePath,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new InfoSection('Song Title', viewedSongData.name),
        new InfoSection('Title Length', viewedSongData.length),
        new InfoSection('Release Date', viewedSongData.releaseDate.toString()),
        // genres
        // tags
        new InfoSection('Album Name', viewedSongData.album['name']),
        // artists
        new InfoSection('Artist Name', viewedSongData.artists[0]['name']),
        new InfoSection('Label', viewedSongData.publisher['name']),
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
