import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'common.dart';

Future<SongData> fetchSongData(name) async {
  final response =
      await http.get('http://192.168.99.100:8080/song?name=' + name);
  final responseJson = json.decode(response.body);

  return new SongData.fromJson(responseJson);
}

class SongData {
  SongData(this.name, this.length, this.releaseDate, this.lyrics, this.artists,
      this.genres, this.tags, this.links, this.album, this.imagePath);

  final String name;
  final String length;
  final DateTime releaseDate;
  final String lyrics;
  final List artists;

  final List genres;
  final List tags;
  final List links;

  final String imagePath;
  final String album;

  SongData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        length = json['length'],
        releaseDate = DateTime.parse(json['releaseDate']),
        lyrics = json['lyrics'],
        links = json['link'],
        genres = json['genre'],
        tags = json['tag'],
        artists = json['artist'],
        album = json['album'],
        imagePath = json['img'];
}

class SongView extends StatelessWidget {
  final Future<SongData> futureSongData;
  final String songName;

  const SongView(this.songName, this.futureSongData);

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
        new InfoSection('Release Date',
            "${viewedSongData.releaseDate.year.toString()}-${viewedSongData.releaseDate.month.toString().padLeft(2,'0')}-${viewedSongData.releaseDate.day.toString().padLeft(2,'0')}"),
        new InfoSection('Album Name', viewedSongData.album),
        // new MultiInfoSection('Artists', viewedSongData.artists),
        new MultiInfoSection('Genres', viewedSongData.genres),
        new MultiInfoSection("Tags", viewedSongData.tags)
      ],
    );
  }

  Widget _buildSongLinksTab(viewedSongData) {
    final _biggerFont =
        new TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

    return new Container(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: viewedSongData.links.length,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return new RaisedButton(
              child: new Text(
                viewedSongData.links[index]['name'],
                style: _biggerFont,
              ),
              onPressed: () async {
                String url = viewedSongData.links[index]['name'];
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  // throw 'Could not launch $url';
                  print('Could not launch $url');
                }
              },
            );
          },
        ));
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
        floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext conteext) {
                    return new SimpleDialog(
                      title: const Text("Select action"),
                      children: <Widget>[
                        new SimpleDialogOption(
                          onPressed: () {},
                          child: const Text("Add to Favourites"),
                        ),
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
                                            hintText: 'Please enter a tag',
                                            labelStyle: new TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                            hintStyle: new TextStyle(
                                                color: Colors.grey,
                                                fontSize: 16.0),
                                            filled: true,
                                            fillColor: Colors.white,
                                            icon: new Icon(Icons.tag_faces)),
                                        onSubmitted: (String val) {
                                          http
                                              .post(
                                                  "http://192.168.99.100:8080/tag/song?name=" +
                                                      songName +
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
            }),
      ),
    );
  }
}
