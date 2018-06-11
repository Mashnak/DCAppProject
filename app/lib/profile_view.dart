import 'dart:async';
import 'dart:convert';

import 'package:app/common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<ProfileData> fetchProfileData(String id) async {
  final response =
      await http.get('http://192.168.99.100:8080/profile?id=' + id);
  final responseJson = json.decode(response.body);

  return new ProfileData.fromJson(responseJson);
}

class ProfileData {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final DateTime birthdate;
  final String gender;
  final String country;
  final String isAdmin;
  final String imagePath;

  ProfileData.fromJson(responseJson)
      : id = responseJson["id"],
        username = responseJson["username"],
        firstName = responseJson["firstName"],
        lastName = responseJson["lastName"],
        birthdate = new DateTime(2016),
        gender = responseJson["gender"],
        country = responseJson["country"],
        isAdmin = responseJson["isAdmin"],
        imagePath = "http://i.imgur.com/YdhUZdZ.png";
}

class ProfileView extends StatelessWidget {
  final Future<ProfileData> futureProfileData;

  ProfileView(this.futureProfileData);

  Widget _buildProfile(ProfileData data) {
    return new Column(
      children: <Widget>[
        Image.network(data.imagePath, height: 240.0, fit: BoxFit.cover),
        new InfoSection("Username", data.username),
        new InfoSection("First name", data.firstName),
        new InfoSection("Last name", data.lastName),
        new InfoSection("Gender", data.gender),
        new InfoSection("Country", data.country),
        new InfoSection("Date of Birth", data.birthdate.toString())
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
