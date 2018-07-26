// Author: Timur Bahadir

part of 'data.dart';

/// Sends a HTTP-Request to [globals.BASE_URL] and decodes
/// the response into Json.
///
/// Appends [arg] to [globals.BASE_URL] and sends a HTTP-Request
/// to that url. It checks the return code and throws [Exception]
/// if anything went wrong
///
/// The returning dynamic is already in parsed form.
dynamic fetchJson(String arg) async {
  final String requestURL = globals.BASE_URL + arg;
  final response = await http.get(requestURL);

  final int statusCode = response.statusCode;

  if (statusCode < 200 || statusCode > 400 || json == null) {
    debugPrint("Server returned ErrorCode: $statusCode");
    debugPrint(response.body);
    throw new Exception("Error while fetching data from: $requestURL");
  }

  final responseJson = json.decode(response.body);

  return responseJson;
}
