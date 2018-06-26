import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:app/globals.dart' as globals;
import 'package:app/data/song_data.dart';
import 'package:app/data/profile_data.dart';
import 'package:app/views/song_view.dart';
import 'package:app/widgets/info_section.dart';

class ProfileView extends StatefulWidget {
  final Future<ProfileData> futureProfileData;
  final String profileName;

  ProfileView(this.profileName, this.futureProfileData);

  @override
  State<StatefulWidget> createState() {
    return new ProfileViewState(profileName, futureProfileData);
  }
}

class ProfileViewState extends State<ProfileView> {
  final Future<ProfileData> futureProfileData;
  final String profileName;

  ProfileViewState(this.profileName, this.futureProfileData);

  Widget _buildProfile(context, ProfileData data) {
    return new Column(
      children: <Widget>[
        new InfoSection("Username", data.name),
        new InfoSection("Date of Birth", data.birthdate.toString()),
        data.isAdmin
            ? new Text("This user is an Admin")
            : new Container(
                width: 0.0,
                height: 0.0,
              ),
        data.name == globals.loggedInUser.name
            ? new RaisedButton(
                child: new Text("Logout"),
                onPressed: () {
                  http
                      .get(globals.BASE_URL +
                          "/logout?name=" +
                          globals.loggedInUser.name)
                      .then((response) {
                    final int statusCode = response.statusCode;

                    if (statusCode < 200 || statusCode > 400 || json == null) {
                      final responseJson = json.decode(response.body);
                      print(statusCode);
                      print(responseJson);
                      throw new Exception("Error while fetching data");
                    }

                    final responseJson = json.decode(response.body);
                    print(responseJson);
                    Navigator.pop(context);
                    globals.loggedInUser = null;
                    setState(() {
                      print(globals.loggedInUser);
                    });
                  });
                },
              )
            : new Container(width: 0.0, height: 0.0)
      ],
    );
  }

  Widget _buildFriendsTab(context, ProfileData data) {
    return new Column(
      children: data.friends.map((entry) {
        return new ListTile(
          title: new Text(entry),
          trailing: new Icon(Icons.view_list),
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new ProfileView(entry, fetchProfileData(entry))));
          },
        );
      }).toList(),
    );
  }

  Widget _buildPlaylistTab(context, ProfileData data) {
    return new Column(
      children: data.playlists.map((entry) {
        return new ListTile(
          title: new Text(entry),
          trailing: new Icon(Icons.view_list),
          onTap: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new SongView(entry, fetchSongData(entry))));
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Profile View"),
            bottom: new TabBar(
              tabs: [
                new Tab(
                  icon: new Icon(Icons.info),
                ),
                new Tab(
                  icon: new Icon(Icons.face),
                ),
                new Tab(
                  icon: new Icon(Icons.playlist_play),
                )
              ],
            ),
          ),
          body: new FutureBuilder<ProfileData>(
            future: futureProfileData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new TabBarView(
                  children: [
                    _buildProfile(context, snapshot.data),
                    _buildFriendsTab(context, snapshot.data),
                    _buildPlaylistTab(context, snapshot.data),
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
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext conteext) {
                                    return new SimpleDialog(
                                      title: const Text("Add a friend"),
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
                                              hintText: 'Please enter a name',
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
                                                .post(globals.BASE_URL +
                                                    "/friend?user=" +
                                                    globals.loggedInUser.name +
                                                    "&friend=" +
                                                    val)
                                                .then((response) {
                                              print(response);
                                              setState(() {});
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Text("Add a Friend"),
                          ),
                          profileName == globals.loggedInUser.name
                              ? new SimpleDialogOption(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext conteext) {
                                          return new SimpleDialog(
                                            title: const Text("View a profile"),
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
                                                        'Please enter a name',
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
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                          builder: (context) =>
                                                              new ProfileView(
                                                                  val,
                                                                  fetchProfileData(
                                                                      val))));
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text("View profile"),
                                )
                              : new SimpleDialogOption(
                                  onPressed: () {
                                    http
                                        .post(globals.BASE_URL +
                                            "/friend?name=" +
                                            globals.loggedInUser.name +
                                            "&friend=" +
                                            profileName)
                                        .then((response) {
                                      print(response);
                                      setState(() {});
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Add to friends"),
                                )
                        ],
                      );
                    });
              }),
        ));
  }
}
