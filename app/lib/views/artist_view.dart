// Author: Timur Bahadir

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:app/globals.dart' as globals;
import 'package:app/data/artist_data.dart';
import 'package:app/views/view_manager.dart';
import 'package:app/widgets/dialog_post_option.dart';
import 'package:app/widgets/user_fab.dart';
import 'package:app/widgets/info_section.dart';
import 'package:app/widgets/multi_info_section.dart';

class ArtistView extends StatelessWidget {
  final Future<ArtistData> futureArtistData;
  final String artistName;

  ArtistView(this.artistName) : futureArtistData = fetchArtistData(artistName);

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
        ViewManager.pushNamed(context, "album", entry);
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
          floatingActionButton: new UserFAB(
            display: globals.loggedInUser != null,
            children: [
              new SimpleDialogOption(
                onPressed: DialogPostOptionCallback(
                    context: context,
                    title: "Add a Tag",
                    hint: "Please enter a Tag",
                    url: globals.BASE_URL +
                        "/tag/artist?name=" +
                        artistName +
                        "&tag=",
                    onCompleteCallback: (response) {
                      debugPrint(response);
                    }),
                child: new Text("Add a Tag"),
              )
            ],
          )),
    );
  }
}
