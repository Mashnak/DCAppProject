import 'dart:async';
import 'dart:convert';

import 'package:app/playlist_view.dart';
import 'package:app/profile_view.dart';
import 'package:app/search_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'song_view.dart';

import 'globals.dart' as globals;

Future<HomeData> fetchHomeData() async {
  final response = await http.get('http://192.168.99.100:8080/random?count=10');
  final responseJson = json.decode(response.body);

  return new HomeData.fromJson(responseJson);
}

class HomeData {
  final List<SongData> songs;

  HomeData.fromJson(List json)
      : songs = json.map((entry) {
          return SongData.fromJson(entry);
        }).toList();
}

class HomeView extends StatelessWidget {
  final Future<HomeData> futureHomeData;

  const HomeView(this.futureHomeData);

  Widget _buildHomeView(context, HomeData homeData) {
    Paint namePaint = new Paint();
    namePaint.color = Colors.white;
    final TextStyle nameStyle = new TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, background: namePaint);
    return new GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.0,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: const EdgeInsets.all(5.0),
      children: homeData.songs.map((song) {
        return new GridTile(
          child: new InkResponse(
            enableFeedback: true,
            child: Image.network(
              song.imagePath,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) =>
                          new SongView(song.name, fetchSongData(song.name))));
            },
          ),
          footer: new Text(
            song.name,
            style: nameStyle,
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new FutureBuilder<HomeData>(
        future: futureHomeData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildHomeView(context, snapshot.data);
          } else if (snapshot.hasError) {
            return new Text("${snapshot.error}");
          }

          return new Center(
            child: new CircularProgressIndicator(),
          );
        },
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            globals.isLoggedIn
                ? new UserAccountsDrawerHeader(
                    accountEmail: new Text(""),
                    accountName: new Text("UserName"),
                    currentAccountPicture:
                        new Image.network("http://i.imgur.com/YdhUZdZ.png"),
                  )
                : new DrawerHeader(
                    child: new Text("Options"),
                  ),
            new ListTile(
              title: new Text("Search"),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new SearchView()));
              },
            ),
            new ListTile(
              title: new Text("Favourites"),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new PlaylistView(fetchPlaylistData(""))));
              },
            ),
            new ListTile(
              title: new Text("Profile"),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new ProfileView(fetchProfileData(""))));
              },
            ),
            new AboutListTile(
              aboutBoxChildren: <Widget>[
                new Text("Made with Flutter my dudes.")
              ],
              applicationIcon: new Icon(Icons.ac_unit),
              applicationLegalese: "DA Project Team A",
              applicationName: "I Wanna Die - Music Finder",
              applicationVersion: "0.4.20",
              icon: new Icon(Icons.info),
              child: new Text("About"),
            )
          ],
        ),
      ),
    );
  }
}
