// Author: Timur Bahadir

part of 'data.dart';

/// Uses [fetchJson()] to create a [SearchData].
Future<SongData> fetchSongData(name) async {
  final responseJson = await fetchJson("/song?name=$name");
  return new SongData.fromJson(responseJson);
}

/// Holds all required data for a [SongView].
///
/// Is constructed with the [fromJson()] method.
/// The required json can be fetched using [fetchJson()].
/// It is recommended to use the [fetchSearchData(String term)] function above.
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

  /// Creates an [SongData] from parsed Json in [json].
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
