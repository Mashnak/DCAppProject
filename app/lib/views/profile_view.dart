// Author: Timur Bahadir

part of 'views.dart';

/// Displays the details of a profile.
///
/// Since a [ProfileView] is stateful, all behaviour
/// is implemented in the [ProfileViewState] class.
///
/// The [ProfileView] passes along the name of the profile
/// to [ProfileViewState].
class ProfileView extends StatefulWidget {
  final String profileName;

  ProfileView(this.profileName);

  @override
  State<StatefulWidget> createState() {
    return new ProfileViewState(profileName);
  }
}

/// Displays all Information of a profile.
///
/// The view is split into three tabs.
/// 1. Tab displays general information about the profile
/// 2. Tab displays the friends of that profile
/// 3. Tab displays the favorite songs of that profile
///
/// It is constructed via a [FutureBuilder]. Showing a loading
/// indicator while the data is being fetched and the error message
/// if the fetching failed.
class ProfileViewState extends State<ProfileView> {
  final Future<ProfileData> futureProfileData;
  final String profileName;

  /// Creates a new [ProfileView] by requesting the [ProfileData]
  /// of the profile with the name of [profileName].
  ProfileViewState(this.profileName)
      : futureProfileData = fetchProfileData(profileName);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new AppBar(
            title: new Text("Profile View"),
            bottom: new TabBar(
              tabs: [
                new Tab(
                  icon: new Icon(Icons.info),
                ),
                new Tab(
                  icon: new Icon(Icons.face),
                ),
                new Tab(
                  icon: new Icon(Icons.playlist_play),
                )
              ],
            ),
          ),
          body: new FutureBuilder<ProfileData>(
            future: futureProfileData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new TabBarView(
                  children: [
                    _buildProfile(context, snapshot.data),
                    _buildFriendsTab(context, snapshot.data),
                    _buildPlaylistTab(context, snapshot.data),
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
          floatingActionButton: new FloatingActionButton(
              child: new Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext conteext) {
                      return new SimpleDialog(
                        title: const Text("Select action"),
                        children: <Widget>[
                          new SimpleDialogOption(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext conteext) {
                                    return new SimpleDialog(
                                      title: const Text("Add a friend"),
                                      children: <Widget>[
                                        new TextField(
                                          style: new TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0),
                                          autofocus: true,
                                          autocorrect: false,
                                          decoration: new InputDecoration(
                                              border: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              hintText: 'Please enter a name',
                                              labelStyle: new TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0),
                                              hintStyle: new TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16.0),
                                              filled: true,
                                              fillColor: Colors.white,
                                              icon: new Icon(Icons.tag_faces)),
                                          onSubmitted: (String val) {
                                            http
                                                .post(globals.BASE_URL +
                                                    "/friend?user=" +
                                                    globals.loggedInUser.name +
                                                    "&friend=" +
                                                    val)
                                                .then((response) {
                                              print(response);
                                              setState(() {});
                                            });
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: const Text("Add a Friend"),
                          ),
                          profileName == globals.loggedInUser.name
                              ? new SimpleDialogOption(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext conteext) {
                                          return new SimpleDialog(
                                            title: const Text("View a profile"),
                                            children: <Widget>[
                                              new TextField(
                                                style: new TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                                autofocus: true,
                                                autocorrect: false,
                                                decoration: new InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(10.0),
                                                    hintText:
                                                        'Please enter a name',
                                                    labelStyle: new TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16.0),
                                                    hintStyle: new TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16.0),
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    icon: new Icon(
                                                        Icons.tag_faces)),
                                                onSubmitted: (String val) {
                                                  ViewManager.pushNamed(
                                                      context, "profile", val);
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text("View profile"),
                                )
                              : new SimpleDialogOption(
                                  onPressed: () {
                                    http
                                        .post(globals.BASE_URL +
                                            "/friend?name=" +
                                            globals.loggedInUser.name +
                                            "&friend=" +
                                            profileName)
                                        .then((response) {
                                      print(response);
                                      setState(() {});
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Add to friends"),
                                )
                        ],
                      );
                    });
              }),
        ));
  }

  /// Creates the first tab to show general profile information.
  Widget _buildProfile(context, ProfileData data) {
    return new Column(
      children: <Widget>[
        new InfoSection("Username", data.name),
        new InfoSection("Date of Birth", data.birthdate.toString()),
        data.isAdmin
            ? new Text("This user is an Admin")
            : new Container(
                width: 0.0,
                height: 0.0,
              ),
        data.name == globals.loggedInUser.name
            ? new RaisedButton(
                child: new Text("Logout"),
                onPressed: () {
                  http
                      .get(globals.BASE_URL +
                          "/logout?name=" +
                          globals.loggedInUser.name)
                      .then((response) {
                    final int statusCode = response.statusCode;

                    if (statusCode < 200 || statusCode > 400 || json == null) {
                      final responseJson = json.decode(response.body);
                      print(statusCode);
                      print(responseJson);
                      throw new Exception("Error while fetching data");
                    }

                    final responseJson = json.decode(response.body);
                    print(responseJson);
                    Navigator.pop(context);
                    globals.loggedInUser = null;
                    setState(() {
                      print(globals.loggedInUser);
                    });
                  });
                },
              )
            : new Container(width: 0.0, height: 0.0)
      ],
    );
  }

  /// Creates the second tab to show all friends of the profile
  /// in a pretty list.
  Widget _buildFriendsTab(context, ProfileData data) {
    return new Column(
      children: data.friends.map((entry) {
        return new ListTile(
          title: new Text(entry),
          trailing: new Icon(Icons.view_list),
          onTap: () {
            ViewManager.pushNamed(context, "profile", entry);
          },
        );
      }).toList(),
    );
  }

  /// Creates the third tab to show all favorite songs of the profile
  /// in a pretty list.
  Widget _buildPlaylistTab(context, ProfileData data) {
    return new Column(
      children: data.playlists.map((entry) {
        return new ListTile(
          title: new Text(entry),
          trailing: new Icon(Icons.view_list),
          onTap: () {
            ViewManager.pushNamed(context, "song", entry);
          },
        );
      }).toList(),
    );
  }
}
