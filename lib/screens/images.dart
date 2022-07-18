// import 'dart:html';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class Img extends StatefulWidget {
//   const Img({Key? key}) : super(key: key);

//   @override
//   State<Img> createState() => _ImgState();
// }

// class _ImgState extends State<Img> {
//   PlatformFile? pickedfile;
//   Future selectFile() async {
//     final result = await FilePicker.platform.pickFiles();
//     if (result == null) {
//       return;
//     }
//     setState(() {
//       pickedfile = result.files.first;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//             child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           child: Image.file(),
//         ),
//         ElevatedButton(onPressed: () {}, child: Text('select file')),
//         ElevatedButton(onPressed: () {}, child: Text('upload file'))
//       ],
//     )));
//   }
// }
