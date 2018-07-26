// Author: Timur Bahadir

part of 'widgets.dart';

/// Creates a entry for a [SimpleDialog] to create a new
/// [SimpleDialog] on press with a text Input.
/// [title] will be the title of the [SimpleDialog],
/// [hint] will be the input text hint,
/// [url] is the destination of the Http-Post-Request,
/// The input of the dialog will be appended to the [url].
/// When the Http-Post-Request is completed [onCompleteCallback]
/// is called.
Function dialogPostOptionCallback(
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
