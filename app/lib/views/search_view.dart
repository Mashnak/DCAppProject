// Author: Timur Bahadir

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:app/data/search_data.dart';
import 'package:app/views/view_manager.dart';

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
            ViewManager.pushNamed(context, "song", entry["name"]);
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
            ViewManager.pushNamed(context, "album", entry["name"]);
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
            ViewManager.pushNamed(context, "artist", entry["name"]);
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
                    futureSearchData = fetchSearchData(val);
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
}
