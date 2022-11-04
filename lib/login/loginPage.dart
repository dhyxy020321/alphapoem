// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_common_templates/register/registerpa.dart';

import 'package:http/http.dart' as http;
import 'globalmydata.dart';
import 'package:flutter_common_templates/home/tower.dart';
import 'package:toast/toast.dart';

class AbizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          //AppFuncBrowse(),
          LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  var _login;
  var _statusCode;

  TextEditingController _userNameEditController =
      new TextEditingController(); //登录账号
  TextEditingController _pwdEditController = new TextEditingController(); //密码

  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _pwdEditController = TextEditingController();
    _userNameEditController = TextEditingController();
    _pwdEditController.addListener(() => setState(() => {}));
    _userNameEditController.addListener(() => setState(() => {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildTopBannerWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildAccountLoginTip(),
                _buildEditWidget(),
                _buildLoginRegisterButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

//图片
  _buildTopBannerWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        "images/1a.jpg",
        fit: BoxFit.fill,
      ),
    );
  }

//alphapoem
  _buildAccountLoginTip() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Text(
        "Alphapoem",
        maxLines: 1,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 30, color: Colors.black54),
      ),
    );
  }

//邮箱用户名两行
  _buildEditWidget() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
      ),
      child: Column(
        children: <Widget>[
          _buildLoginNameTextField(),
          Divider(height: 1.0),
          _buildPwdTextField(),
        ],
      ),
    );
  }

//邮箱组件
  _buildLoginNameTextField() {
    return TextField(
      controller: _userNameEditController,
      focusNode: _userNameFocusNode,
      decoration: InputDecoration(
        hintText: "登录名/邮箱/手机",
        border: InputBorder.none,

        enabledBorder: OutlineInputBorder(
          /*边角*/
          borderRadius: BorderRadius.all(
            Radius.circular(20), //边角为5
          ),
          borderSide: BorderSide(
            color: Colors.black, //边线颜色为白色
            width: 1, //边线宽度为2
          ),
        ),
        // prefixIcon: Image.asset(
        //   "assets/login/user_name.png",
        //   fit: BoxFit.none,
        // ),
      ),
    );
  }

//密码组件
  _buildPwdTextField() {
    return TextField(
        controller: _pwdEditController,
        focusNode: _pwdFocusNode,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "密码",
          border: InputBorder.none,

          enabledBorder: OutlineInputBorder(
            /*边角*/
            borderRadius: BorderRadius.all(
              Radius.circular(20), //边角为5
            ),
            borderSide: BorderSide(
              color: Colors.black, //边线颜色为白色
              width: 1, //边线宽度为2
            ),
          ),
          // prefixIcon: Image.asset(
          //   "assets/login/password.png",
          //   fit: BoxFit.none,
          // ),
          suffixIcon: (_pwdEditController.text ?? "").isEmpty
              ? FlatButton(
                  child: Text("忘记密码"),
                  onPressed: () {
                    _pwdFocusNode.unfocus();
                    _userNameFocusNode.unfocus();
                  })
              : IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _pwdEditController.clear();
                    _pwdFocusNode.unfocus();
                    setState(() {});
                  }),
        ));
  }

//登录以及立即注册按钮
  _buildLoginRegisterButton() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey.withOpacity(0.3),
              ),
              child: FlatButton(
                  onPressed: () {
                    _userNameFocusNode.unfocus();
                    _pwdFocusNode.unfocus();
                    setState(() {
                      if ((_userNameEditController.text == "") ||
                          (_pwdEditController == "")) {
                        showToast("邮箱，密码不能为空", duration: Toast.LENGTH_LONG);
                      } else {
                        // getdata();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      }
                    });
                  },
                  child: Text(
                    "登录",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ),
          SizedBox(width: 15.0),
          Expanded(
              child: Container(
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(width: 1.0, color: Colors.green),
            ),
            child: FlatButton(
                onPressed: () {
                  //跳转注册
                  Navigator.of(context) //.push(AbApp())
                      .push(MaterialPageRoute(builder: (context) => AbApp()));
                },
                child: Text(
                  "立即注册",
                  style: TextStyle(color: Colors.green),
                )),
          ))
        ],
      ),
    );
  }

// _userNameEditController
// _pwdEditController

// _userNameFocusNode
// _pwdFocusNode

  Future getdata() async {
    print("点击登录了");
    var apiPhon = _userNameEditController.text;
    var apiPswd = _pwdEditController.text;
    print('用户名$apiPhon');
    print('密码$apiPswd');
    //
    var url = 'http://192.168.182.1:4523/mock/931607/usr/login/' +
        apiPhon +
        '/' +
        apiPswd;
    http.get(Uri.parse(url)).then((response) {
      print("状态:${response.statusCode}");
      print("正文:${response.body}");
      var jsonData = json.decode(response.body);
      print(jsonData['data']);
      globalmydata.set_username(jsonData['data']['username']);
      globalmydata.set_userid(jsonData['data']['phone']);
      //globalmydata.set_usertrueemail(jsonData['data']['email']);
      _login = jsonData['msg'];
      _statusCode = response.statusCode;

      //print("11这到底是个什么$_login");
    });
    //_statusCode = 200; ////////////测试
    if (_statusCode == 200) {
      _login = '登录成功'; ////////////测试
      if (_login == '登录成功') {
        showToast("登录成功");
        setState(() {
          //global.set_username(apiPhon);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp()));
        });
      } else if (_login == "This phone number does not exist.") {
        print("错了错了");
        showToast("账号不存在");
      } else {
        showToast("密码错误");
      }
    } else {
      showToast("网络链接错误");
    }
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}
