// @dart=2.9
//打包 flutter build apk --no-sound-null-safety
import 'package:flutter/material.dart';

import 'home/welcome.dart';

void main() => runApp(MaterialApp(
  title: '导航演示1',
  home: Welcome(),
  //home: MyApp(), ///////////测试
));
