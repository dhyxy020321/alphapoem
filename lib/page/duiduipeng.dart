
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/cupertino.dart';

class Colliding extends StatefulWidget {
  const Colliding({Key? key}) : super(key: key);

  @override
  _CollidingState createState() => _CollidingState();
}
class _CollidingState extends State<Colliding> {
  List meslist = ['da', 'fs'];
  String currentText = "";
  String currentText1 = "";
  Map datas={};
  String anwaster="请输入三个字，app将根据所输入字符进行相关诗句的搜索";
  getdata(String duipeng)async{
    var response=await register(duipeng);
    setState(() {
      Utf8Decoder decode = new Utf8Decoder();
      datas=json.decode(response?.data);
      if(datas['content']!=null){
        anwaster=datas['content'];
      }
      else{
        anwaster="未搜索到，请重新输入";
      }
    });
  }


  static Future<Response?> register(String duipeng) async{
    try{
      return await Dio().post("http://101.43.253.189:22000/duiduipeng",data:
      {'word':duipeng});//Map or String
    }catch(e){
      print(e);
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/background/d.jpg",
              ),
              fit: BoxFit.fill
          )
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          //Image.asset("assets/background/d.jpg"),
          Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                toolbarHeight: 40,
                leading: IconButton(

                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),

              ),
              body: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child:Container(
                  child: Column(
                    children: [
                      Container(
                        child: const Image(image: AssetImage('assets/title/duipeng.png'),),
                      ),
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                const SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),),
                                      child: const Image(image: AssetImage('assets/chat/gezi.png'),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Container(
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),),
                                      child: const Image(image: AssetImage('assets/chat/gezi.png'),
                                      ),
                                    ),
                                    const SizedBox(width: 10,),
                                    Container(
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),),
                                      child: const Image(image: AssetImage('assets/chat/gezi.png'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: PinCodeTextField(

                                keyboardType: TextInputType.text,
                                length: 3,
                                obscureText: false,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.underline,
                                    fieldHeight: 80,
                                    fieldWidth: 80,
                                    disabledColor: Colors.transparent,
                                    activeColor: Colors.transparent,
                                    inactiveColor: Colors.transparent,
                                    activeFillColor: Colors.transparent,
                                    inactiveFillColor: Colors.transparent,
                                    selectedFillColor: Color.fromARGB(100,100,60,15)
                                ),
                                animationDuration: const Duration(milliseconds: 300),
                                backgroundColor: Colors.transparent,
                                enableActiveFill: true,
                                textStyle: const TextStyle(fontSize: 40),
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


                          ],
                        ),
                      ),
                      Container(
                        height: 72,
                        width: 144,
                        child: MaterialButton(
                          child: const Text('搜索',
                            style: TextStyle(
                                fontSize: 30, color: Colors.black),
                          ),
                          onPressed: () {
                            getdata(currentText);
                            setState(() {
                            });;
                          },
                          color: Color.fromARGB(200,139,71,38),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 250,
                        width: 300,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(150,250, 240, 230),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: CustomScrollView(
                          scrollDirection: Axis.vertical,
                          slivers: <Widget>[
                            SliverList(
                              delegate:SliverChildListDelegate(
                                [
                                  SizedBox(height: 10,),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(20.0)
                                    ),
                                    child:Text(anwaster,
                                    style: TextStyle(fontSize: 20),),
                                    alignment: Alignment.center,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              )
          )
        ],
      ),
    );
  }


}
