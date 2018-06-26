import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final String sectionName;
  final String sectionValue;
  final Function onTapCallback;

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
                    onTap: onTapCallback,
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
