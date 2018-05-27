import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app/album_view.dart';
import 'common.dart';

Future<ArtistData> fetchArtistData(id) async {
  final response = await http.get('http://192.168.99.100:8080/artist?id=' + id);
  final responseJson = json.decode(response.body);

  return new ArtistData.fromJson(responseJson);
}

class ArtistData {
  ArtistData(this.id, this.name, this.genres, this.tags, this.songs,
      this.albums, this.publishers, this.imagePath);

  final String id;
  final String name;
  final List genres;
  final List tags;
  final List songs;
  final List albums;
  final List publishers;

  final String imagePath;

  ArtistData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        genres = json['genres'],
        tags = json['tags'],
        songs = json['songs'],
        albums = json['albums'],
        publishers = json['publishers'],
        imagePath =
            "https://images-eu.ssl-images-amazon.com/images/I/41WIm4pDLBL._SS500.jpg";
}

class ArtistView extends StatelessWidget {
  final Future<ArtistData> futureArtistData;

  const ArtistView(this.futureArtistData);

  Widget _buildArtistInfoTab(ArtistData viewedArtistData) {
    return new ListView(
      children: <Widget>[
        new Image.network(
          viewedArtistData.imagePath,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new InfoSection('Artist Name', viewedArtistData.name),
        new MultiInfoSection('Albums', viewedArtistData.albums),
        new MultiInfoSection('Songs', viewedArtistData.songs),
        new MultiInfoSection('Genres', viewedArtistData.genres),
        new MultiInfoSection('Tags', viewedArtistData.tags),
        new MultiInfoSection('Publishers', viewedArtistData.publishers),
      ],
    );
  }

  Widget _buildAlbumItem(BuildContext context, Map entry) {
    return new ListTile(
      title: new Text(entry["name"]),
      trailing: new Icon(Icons.play_arrow),
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    new AlbumView(fetchAlbumData(entry["id"]))));
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

  Widget _buildArtistCommentsTab() {
    return new Icon(Icons.comment);
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
          body: new FutureBuilder<ArtistData>(
            future: futureArtistData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new TabBarView(
                  children: [
                    _buildArtistInfoTab(snapshot.data),
                    _buildArtistAlbumsTab(context, snapshot.data),
                    _buildArtistCommentsTab(),
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
                            child: const Text("Add Tag"),
                          ),
                          new SimpleDialogOption(
                            onPressed: () {},
                            child: const Text("Add Comment"),
                          ),
                        ],
                      );
                    });
              })),
    );
  }
}
