import 'dart:async';

import 'package:app/data/data_network_util.dart';

Future<ProfileData> fetchProfileData(String name) async {
  final responseJson = await fetchJson("/user?name=$name");
  return new ProfileData.fromJson(responseJson);
}

class ProfileData {
  final String name;
  final String password;
  final String birthdate;
  final List friends;
  final List playlists;
  final bool isAdmin;

  ProfileData.fromJson(responseJson)
      : name = responseJson["name"],
        password = responseJson["password"],
        birthdate = responseJson["birthdate"],
        friends = responseJson["friends"],
        playlists = responseJson["playlist"],
        isAdmin = responseJson["admin"];
}
