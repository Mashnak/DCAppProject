import 'dart:async';
import 'dart:convert';

import 'package:app/common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<ProfileData> fetchProfileData(String id) async {
  final response =
      await http.get('http://192.168.99.100:8080/profile?id=' + id);
  final int statusCode = response.statusCode;
  if (statusCode < 200 || statusCode > 400 || json == null) {
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
        playlists = responseJson["playlists"],
        isAdmin = responseJson["isAdmin"];
}

class ProfileView extends StatelessWidget {
  final Future<ProfileData> futureProfileData;

  ProfileView(this.futureProfileData);

  Widget _buildProfile(ProfileData data) {
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
              )
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
            return _buildProfile(snapshot.data);
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
                        child: const Text("Add to Friends"),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
