// Author: Timur Bahadir

part of 'app.dart';

/// Entry point of the app.
void main() => runApp(new MyApp());

/// Root of the app.
///
/// Starts a new MaterialApp with a primary color of blue and the
/// [DebugView] as a starting point.
/// For a release [DebugView] should be changed to a [HomeView].
/// It also names the app "Song Finder".
///
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Song Finder',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new DebugView());
  }
}
