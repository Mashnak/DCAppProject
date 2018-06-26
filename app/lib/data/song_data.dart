import 'dart:async';

import 'package:app/data/data_network_util.dart';

Future<SongData> fetchSongData(name) async {
  final responseJson = await fetchJson("/song?name=$name");
  return new SongData.fromJson(responseJson);
}

class SongData {
  final String name;
  final String length;
  final DateTime releaseDate;
  final String lyrics;
  final List artists;

  final List genres;
  final List tags;
  final List links;

  final String imagePath;
  final String album;

  SongData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        length = json['length'],
        releaseDate = DateTime.parse(json['releaseDate']),
        lyrics = json['lyrics'],
        links = json['link'],
        genres = json['genre'],
        tags = json['tag'],
        artists = json['artists'],
        album = json['album'],
        imagePath = json['img'];
}
