import 'dart:async';

import 'package:app/data/data_network_util.dart';

Future<SearchData> fetchSearchData(String term) async {
  final responseJson = await fetchJson('/search?term=$term');
  return new SearchData.fromJson(responseJson);
}

class SearchData {
  final List songs;
  final List albums;
  final List artists;

  SearchData.fromJson(responseJson)
      : songs = responseJson[0]['songs'],
        albums = responseJson[1]['albums'],
        artists = responseJson[2]['artists'];
}
