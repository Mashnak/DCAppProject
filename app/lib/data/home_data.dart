// Author: Timur Bahadir

part of 'data.dart';

/// Uses [fetchJson()] to create a [HomeData].
Future<HomeData> fetchHomeData() async {
  final responseJson = await fetchJson("/random?count=10");
  return new HomeData.fromJson(responseJson);
}

/// Holds all required data for a [HomeView].
///
/// Is constructed with the [fromJson()] method.
/// The required json can be fetched using [fetchJson()].
/// It is recommended to use the [fetchHomeData()] function above.
class HomeData {
  final List<SongData> songs;

  /// Creates an [HomeData] from parsed Json in [json].
  HomeData.fromJson(List json)
      : songs = json.map((entry) {
          SongData data = SongData.fromJson(entry);
          return data;
        }).toList();
}
