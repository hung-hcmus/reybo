import 'package:authentification/bookInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageTest extends StatefulWidget {
  const ImageTest({Key? key}) : super(key: key);

  @override
  _ImageTestState createState() => _ImageTestState();
}

class _ImageTestState extends State<ImageTest> {
  late BookBase bookBase;
  @override
  List books = [];
  void initState() {
    // TODO: implement initState
    super.initState();
    bookBase = BookBase();
    bookBase.initialize();
    bookBase.read().then((value) => {
          setState(() {
            books = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: books.length,
          itemBuilder: (BuildContext conntext, int index) {
            return Container(
              color: Colors.white,
              padding: EdgeInsets.all(15),
              child: Container(
                color: Colors.lightBlue,
                child: Column(
                  children: <Widget>[
                    Text(books[index]['Author']),
                    Container(
                        height: 80,
                        width: 60,
                        child: Image(
                            image: NetworkImage(books[index]['Image_url']))),
                    // Text(books[index]['Language']),
                    //Text(books[index]['Rate']),
                    //Text(books[index]['Review_count']),
                    Text(books[index]['Title']),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
