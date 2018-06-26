import 'dart:async';

import 'package:flutter/material.dart';

import 'package:app/globals.dart' as globals;
import 'package:app/data/home_data.dart';
import 'package:app/data/song_data.dart';
import 'package:app/profile_view.dart';
import 'package:app/register_view.dart';
import 'package:app/search_view.dart';
import 'package:app/views/song_view.dart';

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
            globals.loggedInUser != null
                ? new UserAccountsDrawerHeader(
                    accountEmail: new Container(
                      width: 0.0,
                      height: 0.0,
                    ),
                    accountName: new Text(globals.loggedInUser.name),
                    // currentAccountPicture:
                    //     new Image.network("http://i.imgur.com/YdhUZdZ.png"),
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
              title: new Text("Profile"),
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  if (globals.loggedInUser != null) {
                    return new ProfileView(globals.loggedInUser.name,
                        fetchProfileData(globals.loggedInUser.name));
                  } else {
                    return new RegisterView();
                  }
                }));
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
