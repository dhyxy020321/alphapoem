//import 'bottom/page1.dart';

import 'package:flutter_common_templates/bottom//pageo.dart';
import 'package:flutter_common_templates/bottom//page2.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Tabs(),
      theme: ThemeData(),
    );
  }
}

class Tabs extends StatefulWidget {
  Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  List _pageLiat = [page0(), page2()]; //引入两个个界面就不演示了  使用list
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: this._pageLiat[this._currentIndex], //切换界面
        bottomNavigationBar: BottomNavigationBar(
          fixedColor: Color.fromARGB(255, 171, 130, 255),
          currentIndex: this._currentIndex,
          onTap: (int index) {
            setState(() {
              this._currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed, //容易被挤下来，这个可以设置多个按钮
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.category), title: Text("分类")),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), title: Text("我的"))
          ],
        ),
      ),
    );
  }
}
