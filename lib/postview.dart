import 'package:authentification/database.dart';
import 'package:authentification/main.dart';
import 'package:authentification/post.dart';
import 'package:authentification/reybo_app_icons.dart';
import 'package:authentification/screens/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ViewPostScreen extends StatefulWidget {
  final String code;
  const ViewPostScreen({Key? key, required this.code}) : super(key: key);
  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  @override
  Widget build(BuildContext context) {
    int index = Database.PostList.indexWhere(
        (element) => element.post_code == widget.code);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            Database.PostList[index].owner_name,
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          alignment: Alignment.topCenter,
          child: Container(
            padding: EdgeInsets.all(15),
            height: 500,
            color: HexColor("BFE8E8"),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: CircleAvatar(
                          child: CircleAvatar(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Database.PostList[index].owner_name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: <Widget>[
                                Text(DateTime.now()
                                        .difference(
                                            Database.PostList[index].date)
                                        .inMinutes
                                        .toString() +
                                    " m"),
                                Icon(Icons.timer)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 50),
                  child: Expanded(
                    child: Text(
                      Database.PostList[index].content,
                      style: TextStyle(fontFamily: 'Rasa', fontSize: 18),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                        child: Text(
                            Database.PostList[index].like_count.toString() +
                                " likes")),
                    Container(
                        child: Text(
                            Database.PostList[index].comment_count.toString() +
                                " comments"))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
