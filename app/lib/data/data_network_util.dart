import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

import 'package:app/globals.dart' as globals;

dynamic fetchJson(String arg) async {
  final String requestURL = globals.BASE_URL + arg;
  final response = await http.get(requestURL);

  final int statusCode = response.statusCode;

  if (statusCode < 200 || statusCode > 400 || json == null) {
    debugPrint("Server returned ErrorCode: $statusCode");
    debugPrint(response.body);
    throw new Exception("Error while fetching data from: $requestURL");
  }

  String responseValue;
  try {
    responseValue = json.decode(response.body);
  } catch (e) {
    print("Failed to parse json.");
    print(e.toString());
  }

  return responseValue;
}
