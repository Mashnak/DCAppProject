import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

Function DialogPostOptionCallback(
    {context,
    String title,
    String hint,
    String url,
    Function onCompleteCallback}) {
  return () {
    showDialog(
        context: context,
        builder: (BuildContext conteext) {
          return new SimpleDialog(
            title: new Text(title),
            children: <Widget>[
              new TextField(
                style: new TextStyle(color: Colors.black, fontSize: 16.0),
                autofocus: true,
                autocorrect: false,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                    hintText: hint,
                    labelStyle:
                        new TextStyle(color: Colors.black, fontSize: 16.0),
                    hintStyle:
                        new TextStyle(color: Colors.grey, fontSize: 16.0),
                    filled: true,
                    fillColor: Colors.white,
                    icon: new Icon(Icons.tag_faces)),
                onSubmitted: (String val) {
                  http.post(url + val).then((response) {
                    onCompleteCallback(response);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  };
}
