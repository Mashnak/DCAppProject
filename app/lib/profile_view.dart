import 'dart:async';
import 'dart:convert';

import 'package:app/common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'globals.dart' as globals;

Future<ProfileData> fetchProfileData(String name) async {
  final response =
      await http.get("http://192.168.99.100:8080/user?name=" + name);
  final int statusCode = response.statusCode;
  if (statusCode < 200 || statusCode > 400 || json == null) {
    final responseJson = json.decode(response.body);
    print(statusCode);
    print(responseJson);
    throw new Exception("Error while fetching data");
  }

  final responseJson = json.decode(response.body);

  return new ProfileData.fromJson(responseJson);
}

class ProfileData {
  final String name;
  final String password;
  final String birthdate;
  final List friends;
  final List playlists;
  final bool isAdmin;

  ProfileData.fromJson(responseJson)
      : name = responseJson["name"],
        password = responseJson["password"],
        birthdate = responseJson["birthdate"],
        friends = responseJson["friends"],
        playlists = responseJson["playlist"],
        isAdmin = responseJson["admin"];
}

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
        new MultiInfoSection("Friends", data.friends),
        new MultiInfoSection("Playlists", data.playlists),
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
                      .get("http://192.168.99.100:8080/logout?name=" +
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Profile View"),
      ),
      body: new FutureBuilder<ProfileData>(
        future: futureProfileData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildProfile(context, snapshot.data);
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
                                          color: Colors.black, fontSize: 16.0),
                                      autofocus: true,
                                      autocorrect: false,
                                      decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.all(10.0),
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
                                            .post(
                                                "http://192.168.99.100:8080/friend?name=" +
                                                    globals.loggedInUser.name +
                                                    "&friend=" +
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
                                                hintText: 'Please enter a name',
                                                labelStyle: new TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                                hintStyle: new TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 16.0),
                                                filled: true,
                                                fillColor: Colors.white,
                                                icon:
                                                    new Icon(Icons.tag_faces)),
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
                                    .post(
                                        "http://192.168.99.100:8080/friend?name=" +
                                            globals.loggedInUser.name +
                                            "&friend=" +
                                            profileName)
                                    .then((response) {
                                  print(response);
                                });
                                Navigator.pop(context);
                              },
                              child: const Text("Add to friends"),
                            )
                    ],
                  );
                });
          }),
    );
  }
}
