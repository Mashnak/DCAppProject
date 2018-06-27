import 'package:flutter/material.dart';

class MultiInfoSection extends StatelessWidget {
  final String sectionName;
  final List sectionValues;
  final Function onTapCallback;

  MultiInfoSection(this.sectionName, this.sectionValues, [this.onTapCallback]);

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
                onTap: onTapCallback(val),
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
