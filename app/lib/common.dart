import 'package:flutter/material.dart';

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
