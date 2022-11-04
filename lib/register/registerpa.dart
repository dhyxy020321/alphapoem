// @dart=2.9
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
//import 'package:http/http.dart' as http;
import 'package:flutter_common_templates/login/loginPage.dart';

//import 'register.dart';

class AbApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          //AppFuncBrowse(),
          RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() {
    // TODO: implement createState
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _pwdEditController = new TextEditingController();
  TextEditingController _userNameEditController = new TextEditingController();
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
            _buildBackWidget(),
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

//照片
  _buildBackWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        "images/1c.jpg",
        fit: BoxFit.fill,
      ),
    );
  }

  _buildAccountLoginTip() {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Text(
        "Alphapoem注册界面",
        maxLines: 1,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }

//两个输入端
  _buildEditWidget() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
      ),
      child: Column(
        children: <Widget>[
          _buildphonenumTextField(),
          Divider(height: 1.0),
          _buildPwdTextField(),
        ],
      ),
    );
  }

//手机窗
  _buildphonenumTextField() {
    return TextField(
      controller: _userNameEditController,
      focusNode: _userNameFocusNode,
      decoration: InputDecoration(
        hintText: "邮箱/手机",
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

//密码窗
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
        ));
  }

//确认密码窗口
  _buildrePwdTextField() {
    return TextField(
        controller: _pwdEditController,
        focusNode: _pwdFocusNode,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "确认密码",
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
        ));
  }

// //昵称
//   _buildnameTextField() {
//     return TextField(
//         controller: _pwdEditController,
//         focusNode: _pwdFocusNode,
//         obscureText: true,
//         decoration: InputDecoration(
//           hintText: "昵称",
//           border: InputBorder.none,
//           enabledBorder: OutlineInputBorder(
//             /*边角*/
//             borderRadius: BorderRadius.all(
//               Radius.circular(20), //边角为5
//             ),
//             borderSide: BorderSide(
//               color: Colors.black, //边线颜色为白色
//               width: 1, //边线宽度为2
//             ),
//           ),
//           // prefixIcon: Image.asset(
//           //   "assets/login/password.png",
//           //   fit: BoxFit.none,
//           // ),
//         ));
//   }

//注册按钮
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
              border: Border.all(width: 1.0, color: Colors.green),
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
                      getdata();
                    }
                  });
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

  _buildReturnButton() {
    return Padding(
        padding: EdgeInsets.all(15),
        child:
            Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
          Expanded(
              child: FloatingActionButton(
                  shape: CircleBorder(side: BorderSide(color: Colors.blue)),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AbizApp()));
                  },
                  child: Text(
                    "返回",
                    style: TextStyle(color: Colors.green),
                  )))
        ]));
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  Future getdata() async {
    //   print("点击了注册");
    //   String apiPhon = _userNameEditController.text;
    //   String apiPswd = _pwdEditController.text;
    //   String apiName = _userNameEditController.text;
    //   var url = 'http://47.98.201.222:8181/user/register/userRegister';
    //   print(apiPswd);
    //   var _user = new Register(apiName, apiPswd, apiPhon);
    //   String json = jsonEncode(_user.toJson());
    //   print('用户名称${_user.toJson()}');
    //   print(json);
    //   var response = await http.put(Uri.parse(url),
    //       headers: {
    //         'Content-type': 'application/json',
    //         "Accept": 'application/json'
    //       },
    //       body: json);
    //   print(response.statusCode);
    //   print(response.body);
    //   if (response.body == 'This username already exists') {
    //     showToast("昵称已存在");
    //   }
    //   if (response.body == '"This phone number has been registered') {
    //     showToast("手机号已注册");
    //   }
    //   if (response.body == 'success') {
    //     showToast("注册成功");
    //     Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => AbizApp()));
    //   }
  }
}

class Register {
  String username;
  String password;
  String phone;

  Register(this.username, this.password, this.phone);

  Register.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        phone = json['phone'];

  Map<String, dynamic> toJson() =>
      {'username': username, 'password': password, 'phone': phone};
}
