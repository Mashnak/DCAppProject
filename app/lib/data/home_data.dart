// Author: Timur Bahadir

import 'dart:async';

import 'package:app/data/data_network_util.dart';
import 'package:app/data/song_data.dart';

Future<HomeData> fetchHomeData() async {
  final responseJson = await fetchJson("/random?count=10");
  return new HomeData.fromJson(responseJson);
}

class HomeData {
  final List<SongData> songs;

  HomeData.fromJson(List json)
      : songs = json.map((entry) {
          SongData data = SongData.fromJson(entry);
          return data;
        }).toList();
}
