// Author: Timur Bahadir

part of 'widgets.dart';

/// Creates a [FloatingActionButton] which hides itself
/// when no user is logged in.
class UserFAB extends StatelessWidget {
  final bool display;
  final List<SimpleDialogOption> children;

  /// When [display] is false the [UserFAB] hides itself.
  /// All members of [children] will be added as children
  /// of the created [FloatingActionButton].
  UserFAB({this.display, this.children});

  @override
  Widget build(BuildContext context) {
    return display
        ? new FloatingActionButton(
            child: new Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext conteext) {
                    return new SimpleDialog(
                      title: const Text("Select action"),
                      children: children,
                    );
                  });
            })
        : new Container(width: 0.0, height: 0.0);
  }
}
