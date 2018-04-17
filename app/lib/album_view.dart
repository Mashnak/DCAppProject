import 'package:flutter/material.dart';

import 'song_view.dart';
import 'common.dart';

class AlbumData {
  AlbumData(this.name, this.artist, this.publisher, this.releaseDate,
      this.imagePath, this.songs);

  String name;
  String artist;
  String publisher;
  DateTime releaseDate;

  String imagePath;

  List<SongData> songs;
}

class AlbumView extends StatelessWidget {
  final AlbumData viewedAlbumData;

  AlbumView(this.viewedAlbumData);

  Widget _buildSongItem(BuildContext context, SongData songData) {
    return new ListTile(
      title: new Text(songData.name),
      trailing: new Icon(Icons.play_arrow),
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => new SongView(songData)));
      },
    );
  }

  Widget _buildAlbumInfoTab() {
    return new ListView(
      children: <Widget>[
        new Image.asset(
          viewedAlbumData.imagePath,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        new InfoSection('Album Title', viewedAlbumData.name),
        new InfoSection('Artist Name', viewedAlbumData.artist),
        new InfoSection('Label', viewedAlbumData.publisher),
        new InfoSection('Release Date', viewedAlbumData.releaseDate.toString()),
      ],
    );
  }

  Widget _buildAlbumContentTab(BuildContext context) {
    return new ListView(
      padding: const EdgeInsets.all(16.0),
      children: viewedAlbumData.songs.map((SongData songData) {
        return _buildSongItem(context, songData);
      }).toList(), //<Widget>[].map(),
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
