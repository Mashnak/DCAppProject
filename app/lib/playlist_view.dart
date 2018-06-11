import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<PlaylistData> fetchPlaylistData(String id) async {
  final response =
      await http.get('http://192.168.99.100:8080/playlist?id=' + id);
  final responseJson = json.decode(response.body);

  return new PlaylistData.fromJson(responseJson);
}

class PlaylistData {
  List songs;

  PlaylistData.fromJson(responseJson) : songs = responseJson["songs"];
}

class PlaylistView extends StatelessWidget {
  final Future<PlaylistData> futurePlaylistData;

  PlaylistView(this.futurePlaylistData);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Playlist"),
      ),
      body: new FutureBuilder<PlaylistData>(
        future: futurePlaylistData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return new ListView(
              children: <Widget>[
                new ListTile(
                  title: new Text("Song 1"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new ListTile(
                  title: new Text("Song 2"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new ListTile(
                  title: new Text("Song 3"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new ListTile(
                  title: new Text("Song 4"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new ListTile(
                  title: new Text("Song 5"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new ListTile(
                  title: new Text("Song 6"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return new Center(
              child: new Text(
                "Search failed!",
                style: new TextStyle(color: Colors.black),
              ),
            );
          }

          return new Center(
            child: new Text(
              "It's a good day!",
              style: new TextStyle(color: Colors.grey),
            ),
          );
        },
      ),
    );
  }

  Future<PlaylistData> performSearch(String val) async {
    final response =
        await http.get('http://192.168.99.100:8080/search?term=' + val);
    final responseJson = json.decode(response.body);

    return new PlaylistData.fromJson(responseJson);
  }
}
