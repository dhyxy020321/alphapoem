// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_common_templates/login//loginPage.dart';

class Welcome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WelcomeWidget();
    ;
  }
}

class WelcomeWidget extends State<Welcome> {
//  int second_index=5;
  int changeIndex = 0;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 50), (sd) {
      setState(() {
        changeIndex += 1;
//          if(changeIndex%20==0){
//            second_index-=1;
//          }
      });
      if (changeIndex >= 100) {
        _openMain(); //跳转页面
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "images/welcome.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              alignment: Alignment.bottomRight, //设置内容的显示对其方式为 靠右下角显示
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
//                color: Colors.green,//设置背景色，为了看清控件位置设置，在界面完成之后屏蔽此代码
                  borderRadius: BorderRadius.all(Radius.circular(30)), //设置圆角
                ),
                alignment: Alignment.center, //居中显示
                margin: EdgeInsets.all(25), //设置外边距
                child: GestureDetector(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          value: changeIndex / 100,
                          strokeWidth: 1,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text("跳过"),
                      ),
                    ],
                  ),
                  onTap: () {
                    _openMain();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openMain() {
    //跳转页面组件
    timer?.cancel();
    timer = null;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AbizApp()),
        (Route route) => route == null);
  }
}
