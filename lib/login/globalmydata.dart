import 'dart:io';

class globalmydata {
  static String _username = "点击登录";
  static String set_username(String i) {
    _username = i;
    return _username;
  }

  static String get_username() {
    return _username;
  }

  static String _userid = "未登录"; //电话
  static String set_userid(String i) {
    _userid = i;
    return _userid;
  }

  static String get_userid() {
    return _userid;
  }

  static String _useremail = "绑定邮箱";
  static String set_useremail(String i) {
    _useremail = i;
    return _useremail;
  }

  static String get_useremail() {
    return _useremail;
  }

  static String _usertrueemail = "绑定邮箱";
  static String set_usertrueemail(String i) {
    _usertrueemail = i;
    return _usertrueemail;
  }

  static String get_usertrueemail() {
    return _usertrueemail;
  }
}
