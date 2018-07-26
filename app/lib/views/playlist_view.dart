// Author: Timur Bahadir

part of 'views.dart';

/// Shows a list of songs.
///
/// Currently unused.
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
                ViewManager.pushNamed(context, "song", entry);
              },
            );
          }).toList(),
        ));
  }
}
