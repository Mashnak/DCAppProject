// Author: Timur Bahadir

part of 'widgets.dart';

/// Creates a generic and reusable Component to display information.
///
/// It displays the [sectionName] above the [sectionValue].
/// Optionally a callback can be added, which will be called
/// when the InfoSection is tapped with
/// the [sectionValue] as a parameter.
class InfoSection extends StatelessWidget {
  /// Name above the information.
  final String sectionName;

  /// Value of the information.
  final String sectionValue;

  /// Optionally given and called when pressed.
  final Function onTapCallback;

  /// Creates the [InfoSection] using [sectionName] as the name above
  /// the value of [sectionValue]. The optional callback [onTapCallback]
  /// is called when te [InfoSection] is tapped.
  InfoSection(this.sectionName, this.sectionValue, [this.onTapCallback]);

  @override
  Widget build(BuildContext context) {
    if (sectionValue == null || sectionValue == "") {
      return new Container(
        width: 0.0,
        height: 0.0,
      );
    }
    return new Container(
      padding: const EdgeInsets.all(12.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    sectionName,
                    style: new TextStyle(color: Colors.grey),
                  ),
                ),
                new InkResponse(
                    onTap: () {
                      if (onTapCallback != null) {
                        onTapCallback(sectionValue);
                      }
                    },
                    child: new Text(
                      sectionValue,
                      style: new TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
