

import 'package:flutter/material.dart';
import 'widget/my_app_bar.dart';
import 'widget/my_text.dart';



import 'lib02/pickers.dart';


import 'lib02/style/picker_style.dart';


class StylePickerPage extends StatefulWidget {
  @override
  _StylePickerPageState createState() => _StylePickerPageState();
}

class _StylePickerPageState extends State<StylePickerPage> {
  final divider = Divider(height: 1, indent: 20, color: Colors.grey[600]);
  final rightIcon = Icon(Icons.keyboard_arrow_right);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: '内置样式'),
      body: ListView(children: [
              _item('自定义样式', customizeStyle()),
      ]),
    );
  }

  Widget _item(title, pickerStyle) {
    return ListTile(
        title: Text(title),
        onTap: () => _onClickItem(pickerStyle),
        trailing: rightIcon);
  }

  void _onClickItem(pickerStyle) {
    Pickers.showSinglePicker(context,
        data: List.generate(200, (index) => (50 + index).toString()),
        pickerStyle: pickerStyle,
        onConfirm: (p, __) => print('返回数据：$p'),
        onChanged: (p, __) => print('数据发生改变：$p'));
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
}
