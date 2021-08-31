import 'dart:ffi';
import 'dart:io';
import 'dart:math';
//import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Edit_Infor extends StatefulWidget {
  @override
  _Edit_InforState createState() => _Edit_InforState();
}

class infor_card {
  late String name;
  late String nickname;
  late DateTime birth;

  infor_card(this.name, this.nickname, this.birth);
}

class _Edit_InforState extends State<Edit_Infor> {
  late PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool key = false;
  var _name = TextEditingController();
  var _nickname = TextEditingController();
  var _birth = TextEditingController();
  var Infor = infor_card("Phước", "Đẹp trai", DateTime.parse("2001-07-17"));
  DateTime _dateTime = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _date = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(3000));
    if (_date != null && _date != _selectDate)
      setState(() {
        _dateTime = _date;
      });
  }

  @override
  void initState() {
    _imageFile = PickedFile("");
    _name.text = Infor.name;
    _nickname.text = Infor.nickname;
    _birth.text = Infor.birth.day.toString() +
        "-" +
        Infor.birth.month.toString() +
        "-" +
        Infor.birth.year.toString();
    super.initState();
  }

  void takePhoto(ImageSource source) async {
    final picked = await _picker.getImage(source: source);
    setState(() {
      if (_imageFile != null) {
        _imageFile = picked!;
        key = true;
      }
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Text(
            "Choose photo",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text("camera")),
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.photo),
                  label: Text("gallery")),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final url =
        'https://thelifetank.com/wp-content/uploads/2018/08/avatar-default-icon.png';
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              "Edit Information",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
              )
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Center(
                        child: Stack(children: [
                      CircleAvatar(
                          radius: 80,
                          backgroundImage: key == false
                              ? NetworkImage(url) as ImageProvider
                              : FileImage(File(_imageFile.path))),
                      Positioned(
                          bottom: 20,
                          right: 20,
                          child: InkWell(
                            child: Icon(
                              Icons.camera_alt,
                              size: 28,
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()),
                              );
                            },
                          )),
                      // ElevatedButton(
                      //   child: Icon(Icons.camera),
                      //   onPressed: (){},
                      // ),
                    ]));
                  },
                  childCount: 1,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(children: [
                          TextFormField(
                            controller: _nickname,
                            keyboardType: TextInputType.text,

                            //This will obscure text dynamically
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(30)
                              // ),
                              labelText: ' Your nickname',
                              hintText: Infor.nickname,
                            ),
                          ),
                        ]),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextFormField(
                          controller: _name,
                          keyboardType: TextInputType.text,
                          //This will obscure text dynamically
                          decoration: InputDecoration(
                            // border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(30)
                            // ),
                            labelText: 'Your name',
                            hintText: Infor.name,
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Your birth:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11))
                              ],
                            ),
                            Row(
                              children: [
                                Text(_dateTime.day.toString() +
                                    "-" +
                                    _dateTime.month.toString() +
                                    "-" +
                                    _dateTime.year.toString()),
                                IconButton(
                                  icon: Icon(Icons.date_range),
                                  onPressed: () {
                                    setState(() {
                                      _selectDate(context);
                                      Infor.birth = _dateTime;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ],
          )),
    );
  }
}
