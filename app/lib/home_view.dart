import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'song_view.dart';

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

  Widget _buildHomeView(HomeData homeData) {
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
          child: new Image.network(
            song.imagePath,
            fit: BoxFit.cover,
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
            return _buildHomeView(snapshot.data);
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
