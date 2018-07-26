// Author: Timur Bahadir

part of 'data.dart';

/// Uses [fetchJson()] to create a [AlbumData].
Future<AlbumData> fetchAlbumData(String name) async {
  final responseJson = await fetchJson("/album?name=$name");
  return new AlbumData.fromJson(responseJson);
}

/// Holds all required data for a [AlbumView].
///
/// Is constructed with the [fromJson()] method.
/// The required json can be fetched using [fetchJson()].
/// It is recommended to use the [fetchAlbumData()] function above.
class AlbumData {
  final String name;
  final DateTime releaseDate;
  final List genres;
  final List tags;
  final List songs;
  final List artists;
  final String imagePath;

  /// Creates an [AlbumData] from parsed Json in [json].
  AlbumData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        releaseDate = DateTime.parse(json['releaseDate']),
        genres = json['genre'],
        tags = json['tag'],
        songs = json['songs'],
        artists = json['artists'],
        imagePath = json['img'];
}
