// Author: Timur Bahadir

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:app/globals.dart' as globals;
import 'package:app/data/album_data.dart';
import 'package:app/views/view_manager.dart';
import 'package:app/widgets/info_section.dart';
import 'package:app/widgets/dialog_post_option.dart';
import 'package:app/widgets/multi_info_section.dart';
import 'package:app/widgets/user_fab.dart';

class AlbumView extends StatelessWidget {
  final Future<AlbumData> futureAlbumData;
  final String albumName;

  AlbumView(this.albumName) : futureAlbumData = fetchAlbumData(albumName);

  Widget _buildAlbumInfoTab(context, AlbumData viewedAlbumData) {
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
        new MultiInfoSection('Artists', viewedAlbumData.artists, (value) {
          ViewManager.pushNamed(context, "artist", value);
        }),
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
        ViewManager.pushNamed(context, "song", songEntry);
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
      children: dividedSongs,
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
                    _buildAlbumInfoTab(context, snapshot.data),
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
          floatingActionButton: new UserFAB(
            display: globals.loggedInUser != null,
            children: [
              new SimpleDialogOption(
                onPressed: DialogPostOptionCallback(
                    context: context,
                    title: "Add a Tag",
                    hint: "Please enter a Tag",
                    url: globals.BASE_URL +
                        "/tag/album?name=" +
                        albumName +
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
