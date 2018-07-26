// Author: Timur Bahadir

part of 'widgets.dart';

/// Creates a generic and reuseable Component to display multiple
/// Informations under the same name.
///
/// It displays [sectionName] above all values of [sectionValues].
/// A optional callback can be given, which will be calles
/// whenever a member of the [sectionValues] is tapped, with
/// the content of the tapped sectionValue as a parameter.
class MultiInfoSection extends StatelessWidget {
  final String sectionName;
  final Set sectionValues;
  final Function onTapCallback;

  /// Creates the [MultiInfoSection] using [sectionName] as the name above
  /// the values of [sectionValues]. The optional callback [onTapCallback]
  /// is called when te [InfoSection] is tapped, the tapped value of [sectionValues]
  /// is given as the parameter to [onTapCallback].
  MultiInfoSection(this.sectionName, List vals, [this.onTapCallback])
      : sectionValues = Set.from(vals);

  @override
  Widget build(BuildContext context) {
    if (sectionValues == null || sectionValues.length == 0) {
      return new Container(
        width: 0.0,
        height: 0.0,
      );
    }

    return new Container(
      padding: const EdgeInsets.all(12.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: new Text(
              sectionName,
              style: new TextStyle(color: Colors.grey),
            ),
          ),
          new GridView.extent(
            children: sectionValues.map((val) {
              return new InkResponse(
                onTap: () {
                  if (onTapCallback != null) {
                    onTapCallback(val);
                  }
                },
                child: Text(val,
                    style: new TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold)),
              );
            }).toList(),
            shrinkWrap: true,
            maxCrossAxisExtent: 200.0,
            childAspectRatio: 6.0,
          )
        ],
      ),
    );
  }
}
