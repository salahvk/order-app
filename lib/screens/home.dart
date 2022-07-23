// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:order/services/routes_manager.dart';
// import 'package:order/main.dart';
// import 'package:order/screens/images.dart';
// import 'package:order/screens/offerPage.dart';
// import 'package:order/screens/shop_list.dart';
// import 'package:order/screens/sign_in.dart';
// import 'package:provider/provider.dart';

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   getUserPlace() {
//     final provider = Provider.of<Data>(context, listen: false);
//     final user = FirebaseAuth.instance.currentUser!;
//     print(user.email);
//     print('Login name');
//     FirebaseFirestore.instance
//         .collection("users data")
//         .where("userName", isEqualTo: "${user.email}")
//         .get()
//         .then((value) {
//       value.docs.forEach((result) {
//         print(result.data().values.first);
//         String newValue = result.data().values.first;

//         // setState(() {
//         provider.changePlace(newValue);
//         // provider.place = newValue;
//         print('sssssssssssssssssssssssssssss');
//         print(provider.place);
//         print('1');

//         // });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             getUserPlace();

//             print('2');
//             // return const LoginPage();
//             Timer(Duration(seconds: 2), () {
//               print("This code executes after 2 seconds");
//               Navigator.pushNamed(context, Routes.shopList);
//             });

//             return Center(child: CircularProgressIndicator());
//             // return Img();
//           } else {
//             print('Login pages');
//             return const SignIn();
//           }
//         },
//       ),
//     );
//   }
// }
