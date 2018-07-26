// Author: Timur Bahadir

part of 'views.dart';

/// Displays all Information of a album.
///
/// The view is split into two tabs.
/// 1. Tab displays general information about the album
/// 2. Tab displays the idividual songs in a pretty list
///
/// It is constructed via a [FutureBuilder]. Showing a loading
/// indicator while the data is being fetched and the error message
/// if the fetching failed.
class AlbumView extends StatelessWidget {
  final Future<AlbumData> futureAlbumData;
  final String albumName;

  /// Creates a new [AlbumView] by requesting the [AlbumData]
  /// of the album with the name of [albumName].
  AlbumView(this.albumName) : futureAlbumData = fetchAlbumData(albumName);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Album View"),
            bottom: new TabBar(
              tabs: <Widget>[
                new Tab(
                  icon: new Icon(Icons.info),
                ),
                new Tab(
                  icon: new Icon(Icons.view_list),
                )
              ],
            ),
          ),
          body: new FutureBuilder<AlbumData>(
            future: futureAlbumData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new TabBarView(
                  children: [
                    _buildAlbumInfoTab(context, snapshot.data),
                    _buildAlbumContentTab(context, snapshot.data),
                  ],
                );
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }

              return new Center(
                child: new CircularProgressIndicator(),
              );
            },
          ),
          floatingActionButton: new UserFAB(
            display: globals.loggedInUser != null,
            children: [
              new SimpleDialogOption(
                onPressed: dialogPostOptionCallback(
                    context: context,
                    title: "Add a Tag",
                    hint: "Please enter a Tag",
                    url: globals.BASE_URL +
                        "/tag/album?name=" +
                        albumName +
                        "&tag=",
                    onCompleteCallback: (response) {
                      debugPrint(response);
                    }),
                child: new Text("Add a Tag"),
              )
            ],
          )),
    );
  }

  /// Creates the first tab to show general album information.
  Widget _buildAlbumInfoTab(context, AlbumData viewedAlbumData) {
    return new ListView(
      children: <Widget>[
        new Image.network(
          viewedAlbumData.imagePath == null
              ? "https://i.imgur.com/dmnwaaf.jpg?1"
              : viewedAlbumData.imagePath,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new InfoSection('Album Title', viewedAlbumData.name),
        new InfoSection('Release Date',
            "${viewedAlbumData.releaseDate.year.toString()}-${viewedAlbumData.releaseDate.month.toString().padLeft(2,'0')}-${viewedAlbumData.releaseDate.day.toString().padLeft(2,'0')}"),
        new MultiInfoSection('Artists', viewedAlbumData.artists, (value) {
          ViewManager.pushNamed(context, "artist", value);
        }),
        new MultiInfoSection('Genres', viewedAlbumData.genres),
        new MultiInfoSection('Tags', viewedAlbumData.tags)
      ],
    );
  }

  /// Creates the second tab to show all songs in the album
  /// in a pretty list. Each displayed song is created using
  /// the [_buildSongItem()] method.
  Widget _buildAlbumContentTab(
      BuildContext context, AlbumData viewedAlbumData) {
    final songs = viewedAlbumData.songs.map((entry) {
      return _buildSongItem(context, entry);
    });

    final dividedSongs =
        ListTile.divideTiles(context: context, tiles: songs).toList();

    return new ListView(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      children: dividedSongs,
    );
  }

  /// Creates a song in the list created by [_buildAlbumContentTab()].
  /// If a song item is pressed a [SongView] is opened, displaying
  /// the Song with the name of [songEntry].
  Widget _buildSongItem(BuildContext context, String songEntry) {
    return new ListTile(
      title: new Text(songEntry),
      trailing: new Icon(Icons.play_arrow),
      onTap: () {
        ViewManager.pushNamed(context, "song", songEntry);
      },
    );
  }
}
