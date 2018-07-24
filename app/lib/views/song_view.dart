import 'dart:async';

import 'package:app/widgets/dialog_post_option.dart';
import 'package:app/widgets/post_option.dart';
import 'package:app/widgets/user_fab.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import 'package:app/globals.dart' as globals;
import 'package:app/data/song_data.dart';
import 'package:app/views/view_manager.dart';
import 'package:app/widgets/info_section.dart';
import 'package:app/widgets/multi_info_section.dart';

class SongView extends StatelessWidget {
  final Future<SongData> futureSongData;
  final String songName;

  SongView(this.songName) : futureSongData = fetchSongData(songName);

  Widget _buildSongInfoTab(context, SongData viewedSongData) {
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
        new InfoSection('Album Name', viewedSongData.album, (value) {
          ViewManager.pushNamed(context, "album", value);
        }),
        new MultiInfoSection('Artists', viewedSongData.artists, (value) {
          ViewManager.pushNamed(context, "artist", value);
        }),
        new MultiInfoSection('Genres', viewedSongData.genres),
        new MultiInfoSection("Tags", viewedSongData.tags)
      ],
    );
  }

  Color _defineButtonColor(String linkName) {
    switch (linkName) {
      case "Spotify":
        return Colors.lightGreen;
      case "YouTube":
        return Colors.redAccent;
      case "Soundcloud":
        return Colors.deepOrange;
    }
    return Colors.white;
  }

  Widget _buildSongLinksTab(viewedSongData) {
    final _biggerFont =
        new TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

    return new Container(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: viewedSongData.links.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20.0, crossAxisSpacing: 20.0),
          itemBuilder: (BuildContext context, int index) {
            return new RaisedButton(
              shape: new StadiumBorder(),
              elevation: 10.0,
              color: _defineButtonColor(viewedSongData.links[index]['name']),
              child: new Text(
                viewedSongData.links[index]['name'],
                style: _biggerFont,
              ),
              onPressed: () async {
                String url = viewedSongData.links[index]['url'];
                print(url);
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  print('Could not launch $url');
                }
              },
            );
          },
        ));
  }

  Widget _buildLyricsTab(viewedSongData) {
    TextStyle textStyle = new TextStyle(fontSize: 22.0);

    if (viewedSongData.lyrics.length == 0) {
      return new Center(
        child: new Text(
            "No lyrics available for this song.\n                       Sorry :("),
      );
    }

    return new ListView(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(16.0),
            child: new Text(
              viewedSongData.lyrics,
              style: textStyle,
            ))
      ],
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
                ),
                new Tab(
                  icon: new Icon(Icons.text_fields),
                )
              ],
            ),
          ),
          body: new FutureBuilder<SongData>(
            future: futureSongData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new TabBarView(
                  children: [
                    _buildSongInfoTab(context, snapshot.data),
                    _buildSongLinksTab(snapshot.data),
                    _buildLyricsTab(snapshot.data),
                  ],
                );
              } else if (snapshot.hasError) {
                return new Center(child: Text("${snapshot.error}"));
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
                onPressed: PostOptionCallback(
                    context: context,
                    url: globals.BASE_URL +
                        "/favorite?user=" +
                        globals.loggedInUser.name +
                        "&song=" +
                        songName,
                    onComplete: (response) {
                      debugPrint(response);
                    }),
                child: new Text("Add to Favorites"),
              ),
              new SimpleDialogOption(
                onPressed: DialogPostOptionCallback(
                    context: context,
                    title: "Add a Tag",
                    hint: "Please enter a Tag",
                    url: globals.BASE_URL +
                        "/tag/song?name=" +
                        songName +
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
