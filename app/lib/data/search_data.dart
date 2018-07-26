// Author: Timur Bahadir

part of 'data.dart';

/// Uses [fetchJson()] to create a [SearchData].
Future<SearchData> fetchSearchData(String term) async {
  final responseJson = await fetchJson('/search?term=$term');
  return new SearchData.fromJson(responseJson);
}

/// Holds all required data for a search result.
///
/// Is constructed with the [fromJson()] method.
/// The required json can be fetched using [fetchJson()].
/// It is recommended to use the [fetchSearchData(String term)] function above.
class SearchData {
  final List songs;
  final List albums;
  final List artists;

  /// Creates an [SearchData] from parsed Json in [responseJson].
  SearchData.fromJson(responseJson)
      : songs = responseJson[0]['songs'],
        albums = responseJson[1]['albums'],
        artists = responseJson[2]['artists'];
}
