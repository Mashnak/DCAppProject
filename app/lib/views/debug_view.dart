// Author: Timur Bahadir

part of 'views.dart';

/// This view serves debug purposes.
///
/// From This view every other type of view can be created
/// using hard coded names.
class DebugView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Debug View'),
      ),
      body: new Center(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
                child: new Text('Song View'),
                onPressed: () {
                  ViewManager.pushNamed(
                      context, "song", "My Side of the Fence");
                }),
            new RaisedButton(
                child: new Text('Album View'),
                onPressed: () {
                  ViewManager.pushNamed(
                      context, "album", "Pray For The Wicked");
                }),
            new RaisedButton(
                child: new Text('Artist View'),
                onPressed: () {
                  ViewManager.pushNamed(context, "artist", "Paul McCartney");
                }),
            new RaisedButton(
                child: new Text('Search View'),
                onPressed: () {
                  ViewManager.pushNamed(context, "search");
                }),
            new RaisedButton(
                child: new Text('Profile View'),
                onPressed: () {
                  ViewManager.pushNamed(context, "profile", "");
                }),
            new RaisedButton(
                child: new Text('Playlist View'),
                onPressed: () {
                  ViewManager.pushNamed(context, "playlist");
                }),
            new RaisedButton(
                child: new Text('Home View'),
                onPressed: () {
                  ViewManager.pushNamed(context, "home");
                }),
            new RaisedButton(
                child: new Text('Register View'),
                onPressed: () {
                  ViewManager.pushNamed(context, "register");
                }),
          ],
        ),
      ),
    );
  }
}
