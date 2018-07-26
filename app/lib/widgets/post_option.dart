// Author: Timur Bahadir

part of 'widgets.dart';

/// Creates a entry for a [SimpleDialog]. Which when pressed
/// starts a Http-Post-Request.
/// [url] is the destination of the Http-Post-Request,
/// When the Http-Post-Request is completed [onCompleteCallback]
/// is called.
Function postOptionCallback({context, String url, Function onComplete}) {
  return () {
    http.post(url).then((response) {
      onComplete(response);
    });
    Navigator.pop(context);
  };
}
