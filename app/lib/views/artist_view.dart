// Author: Timur Bahadir

part of 'views.dart';

/// Displays all Information of a artist.
///
/// The view is split into two tabs.
/// 1. Tab displays general information about the artist
/// 2. Tab displays the idividual albums in pretty list
///
/// It is constructed via a [FutureBuilder]. Showing a loading
/// indicator while the data is being fetched and the error message
/// if the fetching failed.
class ArtistView extends StatelessWidget {
  final Future<ArtistData> futureArtistData;
  final String artistName;

  /// Creates a new [ArtistView] by requesting the [ArtistData]
  /// of the artist with the name of [artistName].
  ArtistView(this.artistName) : futureArtistData = fetchArtistData(artistName);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 3,
      child: new Scaffold(
          appBar: new AppBar(
            bottom: new TabBar(
              tabs: [
                new Tab(
                  icon: new Icon(Icons.info),
                ),
                new Tab(
                  icon: new Icon(Icons.music_note),
                )
              ],
            ),
          ),
          body: new FutureBuilder<ArtistData>(
            future: futureArtistData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new TabBarView(
                  children: [
                    _buildArtistInfoTab(snapshot.data),
                    _buildArtistAlbumsTab(context, snapshot.data),
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
                        "/tag/artist?name=" +
                        artistName +
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

  /// Creates the first tab to show general artist information.
  Widget _buildArtistInfoTab(ArtistData viewedArtistData) {
    return new ListView(
      children: <Widget>[
        new Image.network(
          viewedArtistData.imagePath == null
              ? "https://i.imgur.com/dmnwaaf.jpg?1"
              : viewedArtistData.imagePath,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new InfoSection('Artist Name', viewedArtistData.name),
        new MultiInfoSection('Genres', viewedArtistData.genres),
        new MultiInfoSection('Tags', viewedArtistData.tags),
      ],
    );
  }

  /// Creates the second tab to show all albums of the artist
  /// in a pretty list. Each displayed album is created using
  /// the [_buildAlbumItem()] method.
  Widget _buildArtistAlbumsTab(BuildContext context, ArtistData data) {
    final albums = data.albums.map((entry) {
      return _buildAlbumItem(context, entry);
    });

    final dividedSongs =
        ListTile.divideTiles(context: context, tiles: albums).toList();

    return new ListView(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      children: dividedSongs, //<Widget>[].map(),
    );
  }

  /// Creates a album in the list created by [_buildArtistAlbumsTab()].
  /// If a song item is pressed a [SongView] is opened, displaying
  /// the Song with the name of [songEntry].
  Widget _buildAlbumItem(BuildContext context, String entry) {
    return new ListTile(
      title: new Text(entry),
      trailing: new Icon(Icons.play_arrow),
      onTap: () {
        ViewManager.pushNamed(context, "album", entry);
      },
    );
  }
}
