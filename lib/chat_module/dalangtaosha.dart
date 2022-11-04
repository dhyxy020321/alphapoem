import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class spray extends StatefulWidget {
  const spray({Key? key}) : super(key: key);

  @override
  _sprayState createState() => _sprayState();
}
class _sprayState extends State<spray> {
  Map datas={};
  String ce='';
  String ce1='';
  final String host='http://101.43.253.189:22000/fly_flower';

  getdata()async{
    var response=await register('200', '日');
    setState(() {
      Utf8Decoder decode = new Utf8Decoder();
      datas=json.decode(response?.data);
      print('jiema');
      ce=datas['msg'];
      ce1=datas['yuanju'];
    });
  }
  static Future<Response?> register(String username,String password) async{
    try{
      return await Dio().post("http://101.43.253.189:22000/fly_flower",data:
      {'msg':username,'word':password});//Map or String
    }catch(e){
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(
      child: Text("返回"),
      onPressed: (){
        Navigator.of(context).pop();
      },
    ),
      appBar: AppBar(
        title: Text("第一个"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(onPressed: getdata,
          ),
          ListTile(title: Text(ce),subtitle: Text(ce1)),
        ],
      )
    );
  }
}
