import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'common.dart';
import 'song_view.dart';

Future<SongData> fetchHomeData() async {
  final response = await http.get('http://192.168.99.100:8080/random?count=10');
  final responseJson = json.decode(response.body);

  return new SongData.fromJson(responseJson[0]);
}

class HomeData {
  List<SongData> songs;

  HomeData.fromJson(Map<String, dynamic> json) : songs = json['songs'];
}

class HomeView extends StatelessWidget {
  final Future<HomeData> futureHomeData;

  const HomeView(this.futureHomeData);

  Widget _buildHomeView() {
    return Text("Hello");
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
            return _buildHomeView();
          } else if (snapshot.hasError) {
            return new Text("${snapshot.error}");
          }

          return new Center(
            child: new CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
