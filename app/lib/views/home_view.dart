// Author: Timur Bahadir

part of 'views.dart';

/// Default starting view of the app.
///
/// The [HomeView] displays a random collection
/// of songs which can all be pressed to show a
/// [SongView] with the details of that song.
class HomeView extends StatelessWidget {
  final Future<HomeData> futureHomeData;

  /// Creates the HomeView using [fetchHomeData()].
  HomeView() : futureHomeData = fetchHomeData();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new FutureBuilder<HomeData>(
        future: futureHomeData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildHomeView(context, snapshot.data);
          } else if (snapshot.hasError) {
            return new Text("${snapshot.error}");
          }

          return new Center(
            child: new CircularProgressIndicator(),
          );
        },
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            globals.loggedInUser != null
                ? new UserAccountsDrawerHeader(
                    accountEmail: new Container(
                      width: 0.0,
                      height: 0.0,
                    ),
                    accountName: new Text(globals.loggedInUser.name),
                  )
                : new DrawerHeader(
                    child: new Text("Options"),
                  ),
            new ListTile(
              title: new Text("Search"),
              onTap: () {
                ViewManager.pushNamed(context, "search");
              },
            ),
            new ListTile(
                title: new Text("Profile"),
                onTap: () {
                  ViewManager.pushNamed(
                      context,
                      globals.loggedInUser != null ? "profile" : "register",
                      globals.loggedInUser != null
                          ? globals.loggedInUser.name
                          : "");
                }),
            new AboutListTile(
              aboutBoxChildren: <Widget>[
                new Text("Made with Flutter my dudes.")
              ],
              applicationIcon: new Icon(Icons.ac_unit),
              applicationLegalese: "DA Project Team A",
              applicationName: "I Wanna Die - Music Finder",
              applicationVersion: "0.4.20",
              icon: new Icon(Icons.info),
              child: new Text("About"),
            )
          ],
        ),
      ),
    );
  }

  /// Creates the [GridView] displaying the random
  /// List of songs in pretty way.
  Widget _buildHomeView(context, HomeData homeData) {
    Paint namePaint = new Paint();
    namePaint.color = Colors.white;
    final TextStyle nameStyle = new TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.bold, background: namePaint);
    return new GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.0,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      padding: const EdgeInsets.all(5.0),
      children: homeData.songs.map((song) {
        return new GridTile(
          child: new InkResponse(
            enableFeedback: true,
            child: Image.network(
              song.imagePath,
              fit: BoxFit.cover,
            ),
            onTap: () {
              ViewManager.pushNamed(context, "song", song.name);
            },
          ),
          footer: new Text(
            song.name,
            style: nameStyle,
          ),
        );
      }).toList(),
    );
  }
}
