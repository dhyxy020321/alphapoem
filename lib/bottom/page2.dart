import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_common_templates/bottom/widget/my_text.dart';

//import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';

import 'lib02/pickers.dart';
import 'lib02/style/picker_style.dart';

class page2 extends StatefulWidget {
  page2({Key? key}) : super(key: key);

  @override
  _page2State createState() => _page2State();
}

class _page2State extends State<page2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: '呵呵',
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
  late File _imagePath; //存储图片
  var response;
  String url = ' ';
  String age = ' ';
  get pickerStyle => null;
  // Future _takePhoto() async {
  //   //maxWidth和maxHeight是像素，改变图片大小
  //   final image = await ImagePicker.pickImage(
  //       source: ImageSource.camera, maxWidth: 800, maxHeight: 800);
  //   if (image != null) {
  //     _imagePath = image as File;
  //     print("拍摄食材成功！");
  //   } else {
  //     print("拍摄食材失败！");
  //   }
  // }

  // Future _openGallery() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (image != null) {
  //       _imagePath = image as File;
  //       print("从相册获取食材图片成功！");
  //       print("裁剪前的图片路径: ${_imagePath}"); //打印获取的图片，得到的是图片的路径
  //       //裁剪图片
  //     } else {
  //       print("从相册获取食材图片失败！");
  //     }
  //   });
  // }

  void _onClickItem(pickerStyle) {
    Pickers.showSinglePicker(
      context,
      data: [
        '10岁以下',
        '10岁~19岁',
        '20岁~29岁',
        '30岁~39岁',
        '40岁~49岁',
        '50岁~59岁',
        '60岁及以上'
      ],
      pickerStyle: pickerStyle,
      onConfirm: (p, __) => setState(() {
        age = p;
      }),
      onChanged: (p, __) => setState(() {
        age = p;
      }),
    );
  }

  PickerStyle customizeStyle() {
    double menuHeight = 46.0;
    Widget _headMenuView = Container(
        color: Colors.deepPurple[400],
        height: menuHeight,
        child: Center(child: MyText('净身高', color: Colors.white)));

    Widget _cancelButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      margin: const EdgeInsets.only(left: 22),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.amberAccent, width: 1),
          borderRadius: BorderRadius.circular(4)),
      child: MyText('close', color: Colors.amberAccent, size: 14),
    );

    Widget _commitButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      margin: const EdgeInsets.only(right: 22),
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(4)),
      child: MyText('confirm', color: Colors.white, size: 14),
    );

    // 头部样式
    Decoration headDecoration = BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)));

    Widget title =
        Center(child: MyText('身高选择器', color: Colors.cyanAccent, size: 14));

    /// item 覆盖样式
    Widget itemOverlay = Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.deepOrangeAccent, width: 0.7)),
      ),
    );

    return PickerStyle(
      menu: _headMenuView,
      menuHeight: menuHeight,
      pickerHeight: 320,
      pickerTitleHeight: 60,
      pickerItemHeight: 50,
      cancelButton: _cancelButton,
      commitButton: _commitButton,
      headDecoration: headDecoration,
      title: title,
      textColor: Colors.amberAccent,
      backgroundColor: Colors.deepPurple,
      itemOverlay: itemOverlay,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人界面"),
      ),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.all(1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '头像',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                  height: 80,
                ),
                Expanded(
                  child: Text(''), // 中间用Expanded控件
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(40),
                    image: DecorationImage(
                        image:
                            new AssetImage('lib/assets/login/backgeound.jpg'),
                        fit: BoxFit.cover),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          //底部弹框  IOS风格
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Container(
                              color: Colors.white,
                              height: 150,
                              //操作按钮：相机、相册、取消
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Text("相机"),
                                    onTap: () {
                                      Navigator.pop(context); //撤回弹框
                                      //_takePhoto();
                                      //Navigator.pushNamed(context, "/PhotoPages");
                                    },
                                  ),
                                  ListTile(
                                      onTap: () {
                                        Navigator.pop(context); //撤回弹框
                                        //_openGallery();
                                        //Navigator.pushNamed(context, "/PhotoPages");
                                        print("点击了从相册选择图片！");
                                      },
                                      title: Text("从相册选择图片")),
                                ],
                              ),
                            );
                          });
                    });
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(1),
            child: Row(
              children: [
                Text(
                  '昵称',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                  height: 80,
                ),
                Expanded(
                  child: Text(''), // 中间用Expanded控件
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(1),
            child: Row(
              children: [
                Text(
                  "个性签名",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                  height: 80,
                ),
                Expanded(
                  child: Text(''), // 中间用Expanded控件
                ),
                IconButton(
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(1),
            child: Row(
              children: [
                Text(
                  '性别',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                  height: 80,
                ),
                Expanded(
                  child: Text(''), // 中间用Expanded控件
                ),
                Text(
                  url,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  ListTile(
                                    title: Text('男'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        url = '男';
                                      });
                                    },
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                  ListTile(
                                    title: Text('女'),
                                    onTap: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        url = '女';
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          });
                    });
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.all(1),
            child: Row(
              children: [
                Text(
                  '年龄',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                  height: 80,
                ),
                Expanded(
                  child: Text(''), // 中间用Expanded控件
                ),
                Text(
                  age,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                IconButton(
                  onPressed: () => _onClickItem(pickerStyle),
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_alertDialog(context) async {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (context) {
        return Container(
          height: 150,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('拍照'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                title: Text('从相册选择'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      });
}
