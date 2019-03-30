import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
//  HomePage({Key key, this.albumlist});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future albumlist;

  Future getAlbum() async {
    var res = await http.get(
        Uri.encodeFull('https://jsonplaceholder.typicode.com/albums/1/photos'),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    print(resBody);
    return resBody;
  }
  Widget showCard(albums) {
    return InkWell(
      onTap: () {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(albums['id'])));
      },
      child: Container(
          margin: EdgeInsets.only(),
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Card(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: new Container(
                  child: CachedNetworkImage(
                    placeholder: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                    imageUrl: albums['thumbnailUrl'],
                    width: 100.0,
                    height: 100.0,
                  ),
                ),
              ),
              Expanded(
                child: new Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(albums['title']),
                ),
              )
            ],
          ))),
    );
  }

  @override
  initState() {
    super.initState();
    albumlist = getAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Albums'),
        ),
        body: new FutureBuilder(
            future: albumlist,
            builder: (_, snapshot) {
              if (snapshot.data == null) {
                return Text('No album');
              }
              if (snapshot.hasData) {
                var thealbum = snapshot.data;
                return GridView.count(
                  crossAxisCount: 3,
                  primary: true,
                  childAspectRatio: 0.80,
                  children: List.generate(thealbum.length, (index) {
                    var singlealbum = thealbum[index];
                    return Container(
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: showCard(singlealbum));
                  }),
                );
              }
            }));
  }
}
