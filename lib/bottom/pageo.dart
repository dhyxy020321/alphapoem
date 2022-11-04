import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_common_templates/bottom/pageo_imageslist.dart';
import 'package:flutter_common_templates/page/Nine_grid.dart';
import 'package:flutter_common_templates/page/feihua.dart';
import 'package:flutter_common_templates/page/duiduipeng.dart';
import 'package:flutter_common_templates/page/langtaosha.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class page0 extends StatefulWidget {
  page0({Key? key}) : super(key: key);

  @override
  _page0State createState() => _page0State();
}

class _page0State extends State<page0> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Stack(
        children: [
          //背景图片
          Container(
            child: Image.asset(
              "images/0background.jpg",
              fit: BoxFit.fill,
            ),
            height: double.infinity,
            width: double.infinity,
          ),
          //大紫框
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 171, 130, 255), //紫
                  Color.fromARGB(255, 216, 250, 250)
                ],
              ),

              // color: Color.fromARGB(100, 171, 130, 255),
            ),
          ),
          //logo
          Positioned(
              left: 125,
              top: 37,
              child: Container(
                width: 160,
                height: 50,
                child: Image.asset(
                  "images/logo.png",
                  fit: BoxFit.fill,
                ),
              )),
          //四个按钮
          Positioned(
            top: 110,
            left: 13,
            child: Row(
              children: [
                Container(
                  height: 80.0,
                  width: 80.0,
                  child: new GestureDetector(onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Nine_grid()));
                  }),
                  decoration: ShapeDecoration(
                      image: const DecorationImage(
                          image: AssetImage('images/lianglogo.png'),
                          fit: BoxFit.fitWidth),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(15))),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 80.0,
                  width: 80.0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ChatPage()));
                      print(
                          'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
                    },
                  ),
                  decoration: ShapeDecoration(
                      image: const DecorationImage(
                          image: AssetImage('images/feilogo.png'),
                          fit: BoxFit.fitWidth),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(15))),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Colliding()));
                      print('对对碰');
                    },
                  ),
                  height: 80.0,
                  width: 80.0,
                  decoration: ShapeDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/lianglogo.png'),
                          fit: BoxFit.fitWidth),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(15))),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  child: new GestureDetector(
                    onTap: () {
                       Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => langtao()));
                      print(
                          'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
                    },
                  ),
                  height: 80.0,
                  width: 80.0,
                  decoration: ShapeDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/feilogo.png'),
                          fit: BoxFit.fitWidth),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(15))),
                ),
              ],
            ),
          ),

          Positioned(
              bottom: 150,
              child: Container(
                child:
                    // SizedBox(
                    //   width: 200,
                    //   height: 240,
                    // ),
                    swipertext(),
                // SizedBox(
                //   width: 200,
                //   height: 30,
                // ),
                //swipernews()
              ))
        ],
      )),
    );
  }

  // 图片滚动
  swiperimages() {
    return Container(
      height: 150,
      width: double.infinity,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
              color: Colors.red.withOpacity(.3),
              child: Image.asset(
                imageList[index]["url"],
                fit: BoxFit.cover,
              ));
        },
        itemCount: imageList.length,
        itemWidth: 350,
        layout: SwiperLayout.STACK,
        autoplay: true,
        loop: true,
        duration: 300,
      ),
    );
  }

  // 新闻滚动
  swipernews() {
    return Container(
      height: 150,
      width: 400,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Container(
            decoration: ShapeDecoration(
                image: DecorationImage(
                    image: AssetImage(newList[index]["url"]),
                    fit: BoxFit.fitWidth),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(10))),

            //color: Colors.red.withOpacity(.3),
            // child: Image.asset(
            //   newList[index]["url"],
            //   fit: BoxFit.cover,
            // )
          );
        },
        itemCount: imageList.length,
        itemWidth: 350,
        //layout: SwiperLayout.STACK,
        autoplay: true,
        loop: true,
        duration: 300,
      ),
    );
  }

  // 文字滚动
  swipertext() {
    return Container(
      height: 200,
      width: 400,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: const Color.fromARGB(255, 216, 250, 250),
            child: ListTile(
              title: Text(newPoem[index]['poem'], style: TextStyle(fontSize: 25)),
              subtitle: Text(
                newPoem[index]['author'],
                textAlign: TextAlign.end,
              ),
            ),
          );
        },
        itemCount: imageList.length,
        itemWidth: 350,
        layout: SwiperLayout.STACK,
        autoplay: true,
        loop: true,
        duration: 300,
      ),
    );
  }

  buttonlogo() {
    return Container(
      height: 90.0,
      width: 90.0,
      child: new GestureDetector(
        onTap: () {
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => page1()));
          print(
              'hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh');
        },
      ),
      decoration: ShapeDecoration(
          image: DecorationImage(
              image: AssetImage('images/lianglogo.png'), fit: BoxFit.fitWidth),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(15))),
    );
  }
}
