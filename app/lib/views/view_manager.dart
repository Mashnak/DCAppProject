// Author: Timur Bahadir

part of 'views.dart';

/// To remove dependencies between views, the [ViewManager]
/// takes care of switching views.
class ViewManager {
  /// Enters a new View on the stack of a [Navigator].
  /// The [Navigator] is found via the [context].
  /// The view to add is choosen by the [viewName].
  /// Some Views require more data to be passed along, that
  /// can be achieved via the optional [value] param.
  static pushNamed(context, String viewName, [value]) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      switch (viewName) {
        case "song":
          return new SongView(value);
        case "album":
          return new AlbumView(value);
        case "artist":
          return new ArtistView(value);
        case "home":
          return new HomeView();
        case "search":
          return new SearchView();
        case "profile":
          return new ProfileView(value);
        case "register":
          if (value != null) {
            debugPrint("Tried to pass a value to a register View");
          }
          return new RegisterView();
        default:
          throw new Exception("No view associated with $viewName");
      }
    }));
  }
}
