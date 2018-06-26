import 'package:app/data/song_data.dart';
import 'package:app/views/song_view.dart';
import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class PlaylistView extends StatelessWidget {
  PlaylistView();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Favorites"),
        ),
        body: new Column(
          children: globals.loggedInUser.playlists.map((entry) {
            return new ListTile(
              title: new Text(entry),
              trailing: new Icon(Icons.view_list),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            new SongView(entry, fetchSongData(entry))));
              },
            );
          }).toList(),
        ));
  }
}
