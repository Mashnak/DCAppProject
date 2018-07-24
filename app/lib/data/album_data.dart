import 'dart:async';

import 'package:app/data/data_network_util.dart';

Future<AlbumData> fetchAlbumData(String name) async {
  final responseJson = await fetchJson("/album?name=$name");
  return new AlbumData.fromJson(responseJson);
}

class AlbumData {
  final String name;
  final DateTime releaseDate;
  final List genres;
  final List tags;
  final List songs;
  final List artists;
  final String imagePath;

  AlbumData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        releaseDate = DateTime.parse(json['releaseDate']),
        genres = json['genre'],
        tags = json['tag'],
        songs = json['songs'],
        artists = json['artists'],
        imagePath = json['img'];
}
