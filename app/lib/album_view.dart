import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'song_view.dart';
import 'common.dart';
import 'globals.dart' as globals;

Future<AlbumData> fetchAlbumData(String name) async {
  final response = await http.get(BASE_URL + '/album?name=' + name);

  final int statusCode = response.statusCode;

  if (statusCode < 200 || statusCode > 400 || json == null) {
    throw new Exception("Error while fetching data");
  }

  final responseJson = json.decode(response.body);

  return new AlbumData.fromJson(responseJson);
}

class AlbumData {
  AlbumData(this.name, this.releaseDate, this.genres, this.tags, this.songs,
      this.artists, this.imagePath);

  final String name;
  final DateTime releaseDate;
  final List genres;
  final List tags;
  final List songs;
  final List artists;
  final String imagePath;

  AlbumData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        releaseDate = new DateTime(2016), //DateTime.parse(json['releaseDate']),
        genres = json['genre'],
        tags = json['tag'],
        songs = json['songs'],
        artists = json['artists'],
        imagePath = json['img'];
}

class AlbumView extends StatelessWidget {
  final Future<AlbumData> futureAlbumData;
  final String albumName;

  const AlbumView(this.albumName, this.futureAlbumData);

  Widget _buildAlbumInfoTab(viewedAlbumData) {
    return new ListView(
      children: <Widget>[
        new Image.network(
          viewedAlbumData.imagePath == null
              ? "https://i.imgur.com/dmnwaaf.jpg?1"
              : viewedAlbumData.imagePath,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new InfoSection('Album Title', viewedAlbumData.name),
        new InfoSection('Release Date',
            "${viewedAlbumData.releaseDate.year.toString()}-${viewedAlbumData.releaseDate.month.toString().padLeft(2,'0')}-${viewedAlbumData.releaseDate.day.toString().padLeft(2,'0')}"),
        new MultiInfoSection.restful(
            'Artists', viewedAlbumData.artists, "artist"),
        new MultiInfoSection('Genres', viewedAlbumData.genres),
        new MultiInfoSection('Tags', viewedAlbumData.tags)
      ],
    );
  }

  Widget _buildSongItem(BuildContext context, String songEntry) {
    return new ListTile(
      title: new Text(songEntry),
      trailing: new Icon(Icons.play_arrow),
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    new SongView(songEntry, fetchSongData(songEntry))));
      },
    );
  }

  Widget _buildAlbumContentTab(
      BuildContext context, AlbumData viewedAlbumData) {
    final songs = viewedAlbumData.songs.map((entry) {
      return _buildSongItem(context, entry);
    });

    final dividedSongs =
        ListTile.divideTiles(context: context, tiles: songs).toList();

    return new ListView(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      children: dividedSongs, //<Widget>[].map(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Album View"),
            bottom: new TabBar(
              tabs: <Widget>[
                new Tab(
                  icon: new Icon(Icons.info),
                ),
                new Tab(
                  icon: new Icon(Icons.view_list),
                )
              ],
            ),
          ),
          body: new FutureBuilder<AlbumData>(
            future: futureAlbumData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new TabBarView(
                  children: [
                    _buildAlbumInfoTab(snapshot.data),
                    _buildAlbumContentTab(context, snapshot.data),
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
          floatingActionButton: globals.loggedInUser == null
              ? null
              : new FloatingActionButton(
                  child: new Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext conteext) {
                          return new SimpleDialog(
                            title: const Text("Select action"),
                            children: <Widget>[
                              new SimpleDialogOption(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext conteext) {
                                        return new SimpleDialog(
                                          title: const Text("Add a tag"),
                                          children: <Widget>[
                                            new TextField(
                                              style: new TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0),
                                              autofocus: true,
                                              autocorrect: false,
                                              decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.all(10.0),
                                                  hintText:
                                                      'Please enter a tag',
                                                  labelStyle: new TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0),
                                                  hintStyle: new TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16.0),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  icon: new Icon(
                                                      Icons.tag_faces)),
                                              onSubmitted: (String val) {
                                                http
                                                    .post(BASE_URL +
                                                        "/tag/album?name=" +
                                                        albumName +
                                                        "&tag=" +
                                                        val)
                                                    .then((response) {
                                                  print(response);
                                                });
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: const Text("Add Tag"),
                              ),
                            ],
                          );
                        });
                  })),
    );
  }
}
