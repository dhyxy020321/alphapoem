import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:url_strategy/url_strategy.dart';


class yanzheng extends StatelessWidget {
  const yanzheng({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: '坚果',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _imageUrl =
      'https://luckly007.oss-cn-beijing.aliyuncs.com/image/image-20211124085239175.png';
  double _fontSize = 20;
  String _title = "坚果公众号";
  // 4 text editing controllers that associate with the 4 input fields
  //TextEditingController textEditingController = TextEditingController();
  String currentText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30),
            child: PinCodeTextField(
              keyboardType: TextInputType.text,
              length: 3,
              obscureText: false,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                fieldHeight: 50,
                fieldWidth: 40,
                activeColor: Colors.transparent,
                inactiveColor: Colors.transparent,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.white,
                selectedFillColor: Colors.blue
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              //controller: textEditingController,
              onCompleted: (v) {
                debugPrint("Completed");
              },
              onChanged: (value) {
                debugPrint(value);
                setState(() {
                  currentText = value;
                });
              },
              beforeTextPaste: (text) {
                return true;
              },
              appContext: context,
            ),
          ),
          MaterialButton(
              child: const Text("测试"),
              color: Colors.blue,
              onPressed:() {
            print(currentText);
          })
        ],
      )
    );
  }
}