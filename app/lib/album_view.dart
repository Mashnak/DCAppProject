import 'package:flutter/material.dart';

class AlbumView extends StatelessWidget {
  Widget _buildAlbumInfoTab() {
    return new Icon(Icons.info);
  }

  Widget _buildAlbumContentTab() {
    return new Icon(Icons.list);
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
            _buildAlbumContentTab(),
            _buildAlbumCommentsTab(),
          ],
        ),
      ),
    );
  }
}
