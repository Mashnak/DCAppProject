import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'song_view.dart';
import 'common.dart';

Future<AlbumData> fetchAlbumData(id) async {
  final response = await http.get('http://192.168.99.100:8080/album?id=' + id);
  final responseJson = json.decode(response.body);

  return new AlbumData.fromJson(responseJson);
}

class AlbumData {
  AlbumData(this.id, this.name, this.totalLength, this.releaseDate, this.genres,
      this.tags, this.songs, this.artists, this.publishers, this.imagePath);

  final String id;
  final String name;
  final String totalLength;
  final DateTime releaseDate;
  final List genres;
  final List tags;
  final List songs;
  final List artists;

  final Map publishers;

  final String imagePath;

  AlbumData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        totalLength = json['totalLength'],
        releaseDate = new DateTime(2016),
        genres = json['genres'],
        tags = json['tags'],
        songs = json['songs'],
        artists = json['artists'],
        publishers = json['publisher'],
        imagePath =
            "https://images-eu.ssl-images-amazon.com/images/I/41WIm4pDLBL._SS500.jpg";
}

class AlbumView extends StatelessWidget {
  final Future<AlbumData> futureAlbumData;

  const AlbumView(this.futureAlbumData);

  Widget _buildAlbumInfoTab(viewedAlbumData) {
    return new ListView(
      children: <Widget>[
        new Image.network(
          "https://images-na.ssl-images-amazon.com/images/I/61t5JGdjXsL._SY355_.jpg",
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new InfoSection('Album Title', viewedAlbumData.name),
        new InfoSection('Total length', viewedAlbumData.totalLength),
        new InfoSection('Release Date', viewedAlbumData.releaseDate.toString()),
        new MultiInfoSection('Songs', viewedAlbumData.songs),
        new MultiInfoSection('Artists', viewedAlbumData.artists),
        new MultiInfoSection('Genres', viewedAlbumData.genres),
        new MultiInfoSection('Tags', viewedAlbumData.tags),
        new InfoSection('Publisher', viewedAlbumData.publishers["name"]),
      ],
    );
  }

  Widget _buildSongItem(BuildContext context, Map songEntry) {
    return new ListTile(
      title: new Text(songEntry["name"]),
      trailing: new Icon(Icons.play_arrow),
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) =>
                    new SongView(fetchSongData(songEntry["id"]))));
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

  Widget _buildAlbumCommentsTab() {
    return new Icon(Icons.comment);
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
                ),
                new Tab(
                  icon: new Icon(Icons.comment),
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
                    _buildAlbumCommentsTab(),
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
