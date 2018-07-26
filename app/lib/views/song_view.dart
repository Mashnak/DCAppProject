// Author: Timur Bahadir

part of 'views.dart';

/// Displays all Information of a song.
///
/// The view is split into three tabs.
/// 1. Tab displays general information about the song
/// 2. Tab displays the links to listen to the song
/// 3. Tab displays the lyrics of that song
///
/// It is constructed via a [FutureBuilder]. Showing a loading
/// indicator while the data is being fetched and the error message
/// if the fetching failed.
class SongView extends StatelessWidget {
  final Future<SongData> futureSongData;
  final String songName;

  /// Creates a new [SongView] by requesting the [SongData]
  /// of the album with the name of [songName].
  SongView(this.songName) : futureSongData = fetchSongData(songName);

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
                ),
                new Tab(
                  icon: new Icon(Icons.text_fields),
                )
              ],
            ),
          ),
          body: new FutureBuilder<SongData>(
            future: futureSongData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new TabBarView(
                  children: [
                    _buildSongInfoTab(context, snapshot.data),
                    _buildSongLinksTab(snapshot.data),
                    _buildLyricsTab(snapshot.data),
                  ],
                );
              } else if (snapshot.hasError) {
                return new Center(child: Text("${snapshot.error}"));
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
                onPressed: postOptionCallback(
                    context: context,
                    url: globals.BASE_URL +
                        "/favorite?user=" +
                        ((globals.loggedInUser == null)
                            ? ""
                            : globals.loggedInUser.name) +
                        "&song=" +
                        songName,
                    onComplete: (response) {
                      debugPrint(response);
                    }),
                child: new Text("Add to Favorites"),
              ),
              new SimpleDialogOption(
                onPressed: dialogPostOptionCallback(
                    context: context,
                    title: "Add a Tag",
                    hint: "Please enter a Tag",
                    url: globals.BASE_URL +
                        "/tag/song?name=" +
                        songName +
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

  /// Creates the first tab to show general song information.
  Widget _buildSongInfoTab(context, SongData viewedSongData) {
    return new ListView(
      children: <Widget>[
        new Image.network(
          viewedSongData.imagePath,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new InfoSection('Song Title', viewedSongData.name),
        new InfoSection('Title Length', viewedSongData.length),
        new InfoSection('Release Date',
            "${viewedSongData.releaseDate.year.toString()}-${viewedSongData.releaseDate.month.toString().padLeft(2,'0')}-${viewedSongData.releaseDate.day.toString().padLeft(2,'0')}"),
        new InfoSection('Album Name', viewedSongData.album, (value) {
          ViewManager.pushNamed(context, "album", value);
        }),
        new MultiInfoSection('Artists', viewedSongData.artists, (value) {
          ViewManager.pushNamed(context, "artist", value);
        }),
        new MultiInfoSection('Genres', viewedSongData.genres),
        new MultiInfoSection("Tags", viewedSongData.tags)
      ],
    );
  }

  /// Creates the second tab to show all buttons which link
  /// to other sources, where the song can be listened to.
  /// The color of the Button is controlled via the [_defineButtonColor()]
  /// method.
  Widget _buildSongLinksTab(viewedSongData) {
    final _biggerFont =
        new TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

    return new Container(
        padding: EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: viewedSongData.links.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 20.0, crossAxisSpacing: 20.0),
          itemBuilder: (BuildContext context, int index) {
            return new RaisedButton(
              shape: new StadiumBorder(),
              elevation: 10.0,
              color: _defineButtonColor(viewedSongData.links[index]['name']),
              child: new Text(
                viewedSongData.links[index]['name'],
                style: _biggerFont,
              ),
              onPressed: () async {
                String url = viewedSongData.links[index]['url'];
                print(url);
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  print('Could not launch $url');
                }
              },
            );
          },
        ));
  }

  /// Defines the color of a link button depending on [linkname].
  /// - Youtube is assigned red.
  /// - Spotify is assigned green.
  /// - Soundcloud is assigned orange
  Color _defineButtonColor(String linkName) {
    switch (linkName) {
      case "Spotify":
        return Colors.lightGreen;
      case "YouTube":
        return Colors.redAccent;
      case "Soundcloud":
        return Colors.deepOrange;
    }
    return Colors.white;
  }

  /// Creates the third tab to display the lyrics of the song.
  Widget _buildLyricsTab(viewedSongData) {
    TextStyle textStyle = new TextStyle(fontSize: 22.0);

    if (viewedSongData.lyrics.length == 0) {
      return new Center(
        child: new Text(
            "No lyrics available for this song.\n                       Sorry :("),
      );
    }

    return new ListView(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(16.0),
            child: new Text(
              viewedSongData.lyrics,
              style: textStyle,
            ))
      ],
    );
  }
}
