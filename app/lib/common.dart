import 'package:app/views/album_view.dart';
import 'package:app/views/artist_view.dart';
import 'package:app/views/song_view.dart';
import 'package:flutter/material.dart';
import 'package:lorem/lorem.dart';

class InfoSection extends StatelessWidget {
  final String sectionName;
  final String sectionValue;
  final String requestType;

  InfoSection(this.sectionName, this.sectionValue) : requestType = null;
  InfoSection.restful(this.sectionName, this.sectionValue, this.requestType);

  @override
  Widget build(BuildContext context) {
    if (sectionValue == null || sectionValue == "") {
      return new Container(
        width: 0.0,
        height: 0.0,
      );
    }
    if (requestType != null) {
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
                      onTap: () {
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) {
                          switch (requestType) {
                            case "song":
                              return new SongView(
                                  sectionValue, fetchSongData(sectionValue));
                              break;
                            case "artist":
                              return new ArtistView(
                                  sectionValue, fetchArtistData(sectionValue));
                              break;
                            case "album":
                              return new AlbumView(
                                  sectionValue, fetchAlbumData(sectionValue));
                              break;
                            default:
                          }
                        }));
                      },
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

  final String requestType;

  MultiInfoSection(this.sectionName, this.sectionValues) : requestType = null;

  MultiInfoSection.restful(
      this.sectionName, this.sectionValues, this.requestType);

  @override
  Widget build(BuildContext context) {
    if (sectionValues == null || sectionValues.length == 0) {
      return new Container(
        width: 0.0,
        height: 0.0,
      );
    }

    if (requestType != null) {
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
                  onTap: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) {
                      switch (requestType) {
                        case "song":
                          return new SongView(val, fetchSongData(val));
                          break;
                        case "artist":
                          return new ArtistView(val, fetchArtistData(val));
                          break;
                        case "album":
                          return new AlbumView(val, fetchAlbumData(val));
                          break;
                        default:
                      }
                    }));
                  },
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
              return new Text(val,
                  style: new TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.bold));
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
