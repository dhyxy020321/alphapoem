// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// class page1 extends StatefulWidget {
//   page1({Key? key}) : super(key: key);
//
//   @override
//   _page1State createState() => _page1State();
// }
//
// class _page1State extends State<page1> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           appBar: AppBar(
//             title: Container(
//               child: Image.asset(
//                 "images/logo.png",
//                 //fit: BoxFit.fill,
//               ),
//             ),
//             centerTitle: true,
//             flexibleSpace: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [
//                   Color(0xFF01C1D9), //蓝
//                   Color(0x9AFF9A), //绿
//                 ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
//               ),
//             ),
//           ),
//           body: ListView(
//             children: <Widget>[
//               Slidableimages("images/guanjun.png"),
//               SizedBox(height: 10),
//               Slidableimages("images/1.webp"),
//               SizedBox(height: 10),
//               Slidableimages("images/2.webp")
//             ],
//           )),
//       theme: ThemeData(primarySwatch: Colors.green),
//     );
//   }
//
//   Widget Slidableimages(String str) {
//     return Container(
//       child: Slidable(
//         // Specify a key if the Slidable is dismissible.
//         key: const ValueKey(0),
//
//         // The start action pane is the one at the left or the top side.
//         startActionPane: ActionPane(
//           // A motion is a widget used to control how the pane animates.
//           motion: const ScrollMotion(),
//
//           // A pane can dismiss the Slidable.
//           dismissible: DismissiblePane(onDismissed: () {}),
//
//           // All actions are defined in the children parameter.
//           children: const [
//             // A SlidableAction can have an icon and/or a label.
//             SlidableAction(
//               onPressed: null,
//               backgroundColor: Color(0xFFFE4A49),
//               foregroundColor: Colors.white,
//               icon: Icons.delete,
//               label: 'Delete',
//             ),
//             SlidableAction(
//               onPressed: null,
//               backgroundColor: Color(0xFF21B7CA),
//               foregroundColor: Colors.white,
//               icon: Icons.share,
//               label: 'Share',
//             ),
//           ],
//         ),
//
//         // 左边两个
//         // endActionPane: const ActionPane(
//         //   motion: ScrollMotion(),
//         //   children: [
//         //     SlidableAction(
//         //       // An action can be bigger than the others.
//         //       flex: 2,
//         //       onPressed: null,
//         //       backgroundColor: Color(0xFF7BC043),
//         //       foregroundColor: Colors.white,
//         //       icon: Icons.archive,
//         //       label: 'Archive',
//         //     ),
//         //     SlidableAction(
//         //       onPressed: null,
//         //       backgroundColor: Color(0xFF0392CF),
//         //       foregroundColor: Colors.white,
//         //       icon: Icons.save,
//         //       label: 'Save',
//         //     ),
//         //   ],
//         // ),
//
//         // The child of the Slidable is what the user sees when the
//         // component is not dragged.
//         child: Container(
//           height: 150,
//           width: double.infinity,
//           child: Image.asset(
//             str,
//             fit: BoxFit.fill,
//           ),
//         ),
//       ),
//     );
//   }
// }
