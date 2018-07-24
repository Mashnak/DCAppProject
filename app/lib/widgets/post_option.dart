import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

Function PostOptionCallback({context, String url, Function onComplete}) {
  return () {
    http.post(url).then((response) {
      onComplete(response);
    });
    Navigator.pop(context);
  };
}
