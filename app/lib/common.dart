import 'package:flutter/material.dart';
import 'package:lorem/lorem.dart';

class InfoSection extends StatelessWidget {
  final String sectionName;
  final String sectionValue;

  InfoSection(this.sectionName, this.sectionValue);

  @override
  Widget build(BuildContext context) {
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
                new Text(sectionValue,
                    style: new TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MultiInfoSection extends StatelessWidget {
  final String sectionName;
  final List sectionValues;

  MultiInfoSection(this.sectionName, this.sectionValues);

  List<Widget> _buildSection() {
    List<Widget> ret = [];
    ret.add(new Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: new Text(
        sectionName,
        style: new TextStyle(color: Colors.grey),
      ),
    ));
    ret.addAll(sectionValues.map((val) {
      return new Text(val["name"],
          style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold));
    }));
    return ret;
  }

  @override
  Widget build(BuildContext context) {
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
          new GridView.extent(children: sectionValues.map((val) {
            return new Text(val["name"],
                style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold));
          }).toList(),
          shrinkWrap: true, maxCrossAxisExtent: 200.0, childAspectRatio: 6.0,
          )
        ],
      ),
    );
  }
}

class NestedComment extends StatelessWidget {
  final debugComment = new Lorem();
  final debugDate = new DateTime.now();
  final _infobarTextStyle = new TextStyle(fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
        child: Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(bottom: 4.0),
              child: new Row(children: <Widget>[
                new Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: new Text(
                      "MelonHead",
                      style: _infobarTextStyle,
                    )),
                new Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: new Text(
                      debugDate.toString(),
                      style: _infobarTextStyle,
                    ))
              ]),
            ),
            new Text(debugComment.createParagraph(numSentences: 5))
          ],
        ));
  }
}
