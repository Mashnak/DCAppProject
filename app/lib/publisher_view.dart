import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'common.dart';

Future<PublisherData> fetchPublisherData(id) async {
  final response = await http.get(BASE_URL + '/publisher?id=' + id);
  final responseJson = json.decode(response.body);

  return new PublisherData.fromJson(responseJson);
}

class PublisherData {
  PublisherData(this.id, this.name, this.genres, this.tags, this.songs,
      this.albums, this.artists, this.imagePath);

  final String id;
  final String name;
  final List genres;
  final List tags;
  final List songs;
  final List albums;
  final List artists;

  final String imagePath;

  PublisherData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        genres = json['genres'],
        tags = json['tags'],
        songs = json['songs'],
        albums = json['albums'],
        artists = json['artists'],
        imagePath =
            "https://images-eu.ssl-images-amazon.com/images/I/41WIm4pDLBL._SS500.jpg";
}

class PublisherView extends StatelessWidget {
  final Future<PublisherData> futurePublisherData;

  const PublisherView(this.futurePublisherData);

  Widget _buildPublisherInfoTab(PublisherData viewedPublisherData) {
    return new ListView(
      children: <Widget>[
        new Image.network(
          viewedPublisherData.imagePath,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new InfoSection('Publisher Name', viewedPublisherData.name),
        new MultiInfoSection('Artists', viewedPublisherData.artists),
        new MultiInfoSection('Albums', viewedPublisherData.albums),
        new MultiInfoSection('Songs', viewedPublisherData.songs),
        new MultiInfoSection('Genres', viewedPublisherData.genres),
        new MultiInfoSection('Tags', viewedPublisherData.tags),
      ],
    );
  }

  Widget _buildPublisherAlbumsTab(BuildContext context, PublisherData data) {
    return new Icon(Icons.info);
  }

  Widget _buildPublisherCommentsTab() {
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
          body: new FutureBuilder<PublisherData>(
            future: futurePublisherData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new TabBarView(
                  children: [
                    _buildPublisherInfoTab(snapshot.data),
                    _buildPublisherAlbumsTab(context, snapshot.data),
                    _buildPublisherCommentsTab(),
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
