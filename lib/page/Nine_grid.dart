// @dart=2.9

import 'dart:convert';
// import 'dart:html';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_common_templates/home/tower.dart';
import 'package:http/http.dart' as http;

// import 'package:http/http.dart';
import 'package:file_picker/file_picker.dart';

class Nine_grid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '九宫格挑战',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var uname = new TextEditingController();
  String yixuan = '';
  String jieguo = '';
  String yuanju = '窗前明月光';
  String inputText = '窗前明月光意识八级';
  FocusNode _currentFocus = FocusNode();
  bool _visibleCursor = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/background/e.jpg",
              ),
              fit: BoxFit.fill
          )
      ),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 40,
            leading: IconButton(

              icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>MyApp()));
              },
            ),

          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Container(
                child: const Image(image: AssetImage('assets/title/jiugongge.png'),),
              ),
              Expanded(child: Stack(
                children: <Widget>[

                  GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(40.0),
                    crossAxisSpacing: 30.0,
                    crossAxisCount: 3,
                    children: <Widget>[

                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("images/welcome.jpg"),
                                fit: BoxFit.fill),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              print('点击');
                              setState(() {
                                if (yixuan.length < 9) {
                                  yixuan = yixuan + inputText[0];
                                }
                                if (yixuan == yuanju) {
                                  jieguo = "恭喜";
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(72)),
                            color: Colors.transparent,
                            child: Text(
                              inputText[0],
                              style: TextStyle(color: Colors.black,fontSize: 40,),
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("images/welcome.jpg"),
                                fit: BoxFit.fill),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              print('点击');
                              setState(() {
                                if (yixuan.length < 9) {
                                  yixuan = yixuan + inputText[1];
                                }
                                if (yixuan == yuanju) {
                                  jieguo = "恭喜";
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(72)),
                            color: Colors.transparent,
                            child: Text(
                              inputText[1],
                              style: TextStyle(color: Colors.black,fontSize: 40,),
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("images/welcome.jpg"),
                                fit: BoxFit.fill),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              print('点击');
                              setState(() {
                                if (yixuan.length < 9) {
                                  yixuan = yixuan + inputText[2];
                                }
                                if (yixuan == yuanju) {
                                  jieguo = "恭喜";
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(72)),
                            color: Colors.transparent,
                            child: Text(
                              inputText[2],
                              style: TextStyle(color: Colors.black,fontSize: 40,),
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("images/welcome.jpg"),
                                fit: BoxFit.fill),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              print('点击');
                              setState(() {
                                if (yixuan.length < 9) {
                                  yixuan = yixuan + inputText[3];
                                }
                                if (yixuan == yuanju) {
                                  jieguo = "恭喜";
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(72)),
                            color: Colors.transparent,
                            child: Text(
                              inputText[3],
                              style: TextStyle(color: Colors.black,fontSize: 40,),
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("images/welcome.jpg"),
                                fit: BoxFit.fill),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              print('点击');
                              setState(() {
                                if (yixuan.length < 9) {
                                  yixuan = yixuan + inputText[4];
                                }
                                if (yixuan == yuanju) {
                                  jieguo = "恭喜";
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(72)),
                            color: Colors.transparent,
                            child: Text(
                              inputText[4],
                              style: TextStyle(color: Colors.black,fontSize: 40,),
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("images/welcome.jpg"),
                                fit: BoxFit.fill),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              print('点击');
                              setState(() {
                                if (yixuan.length < 9) {
                                  yixuan = yixuan + inputText[5];
                                }
                                if (yixuan == yuanju) {
                                  jieguo = "恭喜";
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(72)),
                            color: Colors.transparent,
                            child: Text(
                              inputText[5],
                              style: TextStyle(color: Colors.black,fontSize: 40,),
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("images/welcome.jpg"),
                                fit: BoxFit.fill),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              print('点击');
                              setState(() {
                                if (yixuan.length < 9) {
                                  yixuan = yixuan + inputText[6];
                                }
                                if (yixuan == yuanju) {
                                  jieguo = "恭喜";
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(72)),
                            color: Colors.transparent,
                            child: Text(
                              inputText[6],
                              style: TextStyle(color: Colors.black,fontSize: 40,),
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("images/welcome.jpg"),
                                fit: BoxFit.fill),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              print('点击');
                              setState(() {
                                if (yixuan.length < 9) {
                                  yixuan = yixuan + inputText[7];
                                }
                                if (yixuan == yuanju) {
                                  jieguo = "恭喜";
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(72)),
                            color: Colors.transparent,
                            child: Text(
                              inputText[7],
                              style: TextStyle(color: Colors.black,fontSize: 40,),
                            ),
                          )),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            image: DecorationImage(
                                image: AssetImage("images/welcome.jpg"),
                                fit: BoxFit.fill),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              print('点击');
                              setState(() {
                                if (yixuan.length < 9) {
                                  yixuan = yixuan + inputText[8];
                                }
                                if (yixuan == yuanju) {
                                  jieguo = "恭喜";
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(72)),
                            color: Colors.transparent,
                            child: Text(
                              inputText[8],
                              style: TextStyle(color: Colors.black,fontSize: 40,),
                            ),
                          )),
                    ],
                  ),
                  // new GridView.count(
                  //   primary: false,
                  //   padding: const EdgeInsets.all(40.0),
                  //   crossAxisSpacing: 30.0,
                  //   crossAxisCount: 3,
                  //   // children: getTextListWidget()
                  // ),
                  //已选的显示
                  Positioned(
                      right: 100.0,
                      bottom: 150,
                      child: Container(
                        height: 44,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        // color: Colors.blue[50],
                        child: FlatButton(
                          child: Text(
                            yixuan,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )),

                  //删减字符串
                  Positioned(
                      right: 30.0,
                      bottom: 150,
                      child: Container(
                        color: Colors.transparent,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_sharp),
                          onPressed: () {
                            print('删减字段');
                            setState(() {
                              yixuan = yixuan.substring(1);
                            });
                          },
                        ),
                      )),

                  //结果显示
                  Positioned(
                      right: 150.0,
                      bottom: 110,
                      child: Container(
                        // color: Colors.blue[50],
                        child: FlatButton(
                          child: Text(
                            jieguo,
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        ),
                      )),

                  //下一句
                  Positioned(
                      right: 150.0,
                      bottom: 50,
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            print('按钮点击下一句');
                            _uploadFile();
                            // getTextListWidget();
                            setState(() {
                              // inputText = '举头望明月低头思故';
                              getdata();
                              yixuan = '';
                            });
                          },
                          child: Text(
                            "下一句",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )),
                ],
              ))
            ],
          )),
    );
  }

  getdata() async {
    var res =
        await http.get(Uri.parse('http://101.43.253.189:22000/nine_palaces'));
    setState(() {
      var datas = jsonDecode(res.body);
      print('调用成功');
      inputText = datas['jiuzi'];
      yuanju = datas['yuanju'];
    });
  }

  _uploadFile() async {
    var formData = FormData.fromMap({
      // 'name': 'wendux',
      // 'age': 25,
      'file': await MultipartFile.fromFile('/Android/data/alpha/yoh.dat',
          filename: 'yoh.dat')
    });
    var response =
        await Dio().post('http://101.43.253.189:22000/getmp3', data: formData);
  }
}
