// Author: Timur Bahadir

part of 'data.dart';

/// Uses [fetchJson()] to create a [ArtistData].
Future<ArtistData> fetchArtistData(String name) async {
  final responseJson = await fetchJson("/artist?name=$name");
  return new ArtistData.fromJson(responseJson);
}

/// Holds all required data for a [ArtistView].
///
/// Is constructed with the [fromJson()] method.
/// The required json can be fetched using [fetchJson()].
/// It is recommended to use the [fetchArtistData()] function above.
class ArtistData {
  final String name;
  final List genres;
  final List tags;
  final List albums;
  final String imagePath;

  /// Creates an [ArtistData] from parsed Json in [json].
  ArtistData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        genres = json['genre'],
        tags = json['tag'],
        albums = json['albums'],
        imagePath = json['img'];
}
