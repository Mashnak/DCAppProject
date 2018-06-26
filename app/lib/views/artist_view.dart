import 'dart:async';

import 'package:app/widgets/info_section.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app/common.dart';
import 'package:app/globals.dart' as globals;
import 'package:app/data/album_data.dart';
import 'package:app/data/artist_data.dart';
import 'package:app/views/album_view.dart';

class ArtistView extends StatelessWidget {
  final Future<ArtistData> futureArtistData;
  final String artistName;

  const ArtistView(this.artistName, this.futureArtistData);

  Widget _buildArtistInfoTab(ArtistData viewedArtistData) {
    return new ListView(
      children: <Widget>[
        new Image.network(
          viewedArtistData.imagePath == null
              ? "https://i.imgur.com/dmnwaaf.jpg?1"
              : viewedArtistData.imagePath,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new InfoSection('Artist Name', viewedArtistData.name),
        new MultiInfoSection('Genres', viewedArtistData.genres),
        new MultiInfoSection('Tags', viewedArtistData.tags),
      ],
    );
  }

  Widget _buildAlbumItem(BuildContext context, String entry) {
    return new ListTile(
      title: new Text(entry),
      trailing: new Icon(Icons.play_arrow),
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    new AlbumView(entry, fetchAlbumData(entry))));
      },
    );
  }

  Widget _buildArtistAlbumsTab(BuildContext context, ArtistData data) {
    final albums = data.albums.map((entry) {
      return _buildAlbumItem(context, entry);
    });

    final dividedSongs =
        ListTile.divideTiles(context: context, tiles: albums).toList();

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
            bottom: new TabBar(
              tabs: [
                new Tab(
                  icon: new Icon(Icons.info),
                ),
                new Tab(
                  icon: new Icon(Icons.music_note),
                )
              ],
            ),
            // title: new Text(viewedSongData.name),
          ),
          body: new FutureBuilder<ArtistData>(
            future: futureArtistData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new TabBarView(
                  children: [
                    _buildArtistInfoTab(snapshot.data),
                    _buildArtistAlbumsTab(context, snapshot.data),
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
                                                    .post(globals.BASE_URL +
                                                        "/tag/artist?name=" +
                                                        artistName +
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
