import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchData {
  List songs;
  List albums;
  List artists;

  SearchData.fromJson(responseJson)
      : songs = responseJson["songs"],
        albums = responseJson["albums"],
        artists = responseJson["artists"];
}

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() {
    return new _SearchViewState();
  }
}

class _SearchViewState extends State<SearchView> {
  Future<SearchData> futureSearchData;

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
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return new ListView(
              children: <Widget>[
                new Text("Songs"),
                new ListTile(
                  title: new Text("Search Result"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new ListTile(
                  title: new Text("Search Result"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new ListTile(
                  title: new Text("Search Result"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new Divider(),
                new Text("Albums"),
                new ListTile(
                  title: new Text("Search Result"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new ListTile(
                  title: new Text("Search Result"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new ListTile(
                  title: new Text("Search Result"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new Divider(),
                new Text("Artists"),
                new ListTile(
                  title: new Text("Search Result"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new ListTile(
                  title: new Text("Search Result"),
                  leading: new Icon(Icons.note),
                  trailing: new Icon(Icons.play_arrow),
                ),
                new ListTile(
                  title: new Text("Search Result"),
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

  Future<SearchData> performSearch(String val) async {
    final response =
        await http.get('http://192.168.99.100:8080/search?term=' + val);
    final responseJson = json.decode(response.body);

    return new SearchData.fromJson(responseJson);
  }
}
