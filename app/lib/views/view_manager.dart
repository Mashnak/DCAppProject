import 'package:flutter/material.dart';

import 'package:app/views/album_view.dart';
import 'package:app/views/artist_view.dart';
import 'package:app/views/profile_view.dart';
import 'package:app/views/register_view.dart';
import 'package:app/views/search_view.dart';
import 'package:app/views/song_view.dart';

class ViewManager {
  static pushNamed(context, String viewName, [value]) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      switch (viewName) {
        case "song":
          return new SongView(value);
        case "album":
          return new AlbumView(value);
        case "artist":
          return new ArtistView(value);
        case "search":
          return new SearchView();
        case "profile":
          return new ProfileView(value);
        case "register":
          if (value != null) {
            debugPrint("Tried to pass a value to a register View");
          }
          return new RegisterView();
        default:
          throw new Exception("No view associated with $viewName");
      }
    }));
  }
}
