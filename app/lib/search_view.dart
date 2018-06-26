import 'dart:async';
import 'dart:convert';

import 'package:app/views/album_view.dart';
import 'package:app/views/artist_view.dart';
import 'package:app/views/song_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as globals;

class SearchData {
  final List songs;
  final List albums;
  final List artists;

  SearchData.fromJson(responseJson)
      : songs = responseJson[0]['songs'],
        albums = responseJson[1]['albums'],
        artists = responseJson[2]['artists'];
}

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() {
    return new _SearchViewState();
  }
}

class _SearchViewState extends State<SearchView> {
  Future<SearchData> futureSearchData;

  Widget _buildSongList(List searchSongs) {
    return new Column(
      children: searchSongs.map((entry) {
        return new ListTile(
          title: new Text(entry["name"]),
          trailing: new Icon(Icons.music_note),
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new SongView(
                        entry["name"], fetchSongData(entry["name"]))));
          },
        );
      }).toList(),
    );
  }

  Widget _buildAlbumList(List searchAlbums) {
    return new Column(
      children: searchAlbums.map((entry) {
        return new ListTile(
          title: new Text(entry["name"]),
          trailing: new Icon(Icons.view_list),
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new AlbumView(
                        entry["name"], fetchAlbumData(entry["name"]))));
          },
        );
      }).toList(),
    );
  }

  Widget _buildArtistList(List searchArtists) {
    return new Column(
      children: searchArtists.map((entry) {
        return new ListTile(
          title: new Text(entry["name"]),
          trailing: new Icon(Icons.accessibility),
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new ArtistView(
                        entry["name"], fetchArtistData(entry["name"]))));
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Search"),
          bottom: new PreferredSize(
            child: new Container(
              padding: EdgeInsets.all(4.0),
              child: new TextField(
                style: new TextStyle(color: Colors.black, fontSize: 16.0),
                autofocus: true,
                autocorrect: false,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: 'Please enter a search term',
                    labelStyle:
                        new TextStyle(color: Colors.black, fontSize: 16.0),
                    hintStyle:
                        new TextStyle(color: Colors.grey, fontSize: 16.0),
                    filled: true,
                    fillColor: Colors.white,
                    icon: new Icon(Icons.search)),
                onSubmitted: (String val) {
                  setState(() {
                    futureSearchData = performSearch(val);
                  });
                },
              ),
            ),
            preferredSize: new Size.fromHeight(40.0),
          )),
      body: new FutureBuilder<SearchData>(
        future: futureSearchData,
        builder: (context, snapshot) {
          final TextStyle headingStyle =
              new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
          if (snapshot.hasData) {
            return new ListView(
              children: <Widget>[
                new Text(
                  "Songs",
                  style: headingStyle,
                ),
                _buildSongList(snapshot.data.songs),
                new Divider(),
                new Text(
                  "Albums",
                  style: headingStyle,
                ),
                _buildAlbumList(snapshot.data.albums),
                new Divider(),
                new Text(
                  "Artists",
                  style: headingStyle,
                ),
                _buildArtistList(snapshot.data.artists),
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

  Future<SearchData> performSearch(String val) async {
    final response = await http.get(globals.BASE_URL + '/search?term=' + val);
    final responseJson = json.decode(response.body);

    return new SearchData.fromJson(responseJson);
  }
}
