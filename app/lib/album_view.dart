import 'package:flutter/material.dart';

import 'song_view.dart';
import 'common.dart';

class AlbumData {
  AlbumData(this.name, this.artist, this.publisher, this.releaseDate,
      this.length, this.imagePath, this.songs);

  String name;
  String artist;
  String publisher;
  DateTime releaseDate;
  String length;

  String imagePath;

  List<SongData> songs;
}

class AlbumView extends StatelessWidget {
  final AlbumData viewedAlbumData;

  AlbumView(this.viewedAlbumData);

  Widget _buildAlbumInfoTab() {
    return new ListView(
      children: <Widget>[
        new Image.network(
          "https://images-na.ssl-images-amazon.com/images/I/61t5JGdjXsL._SY355_.jpg",
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new InfoSection('Album Title', viewedAlbumData.name),
        new InfoSection('Artist Name', viewedAlbumData.artist),
        new InfoSection('Total length', viewedAlbumData.length),
        new InfoSection('Label', viewedAlbumData.publisher),
        new InfoSection('Release Date', viewedAlbumData.releaseDate.toString()),
      ],
    );
  }

  Widget _buildSongItem(BuildContext context, SongData songData) {
    return new ListTile(
      title: new Text(songData.name),
      trailing: new Icon(Icons.play_arrow),
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new SongView(fetchSongData(songData.id))));
      },
    );
  }

  Widget _buildAlbumContentTab(BuildContext context) {
    final songs = viewedAlbumData.songs.map((SongData songData) {
      return _buildSongItem(context, songData);
    });

    final dividedSongs =
        ListTile.divideTiles(context: context, tiles: songs).toList();

    return new ListView(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      children: dividedSongs, //<Widget>[].map(),
    );
  }

  Widget _buildAlbumCommentsTab() {
    return new Icon(Icons.comment);
  }

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
                icon: new Icon(Icons.music_note),
              ),
              new Tab(
                icon: new Icon(Icons.comment),
              )
            ],
          ),
        ),
        body: new TabBarView(
          children: <Widget>[
            _buildAlbumInfoTab(),
            _buildAlbumContentTab(context),
            _buildAlbumCommentsTab(),
          ],
        ),
      ),
    );
  }
}
