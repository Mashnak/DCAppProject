// Author: Timur Bahadir

part of 'data.dart';

/// Uses [fetchJson()] to create a [ProfileData].
Future<ProfileData> fetchProfileData(String name) async {
  final responseJson = await fetchJson("/user?name=$name");
  return new ProfileData.fromJson(responseJson);
}

/// Holds all required data for a [ProfileView].
///
/// Is constructed with the [fromJson()] method.
/// The required json can be fetched using [fetchJson()].
/// It is recommended to use the [fetchProfileData()] function above.
class ProfileData {
  final String name;
  final String password;
  final String birthdate;
  final List friends;
  final List playlists;
  final bool isAdmin;

  /// Creates an [ProfileData] from parsed Json in [responseJson].
  ProfileData.fromJson(responseJson)
      : name = responseJson["name"],
        password = responseJson["password"],
        birthdate = responseJson["birthdate"],
        friends = responseJson["friends"],
        playlists = responseJson["playlist"],
        isAdmin = responseJson["admin"];
}
