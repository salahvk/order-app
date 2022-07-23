import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order/main.dart';
import 'package:order/services/routes_manager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  pushToHome() async {
    Timer(const Duration(seconds: 2), () {
      print('Started');
      if (FirebaseAuth.instance.currentUser?.uid == null) {
        print('Not signed in');
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.introduction, (route) => false);
      } else {
        getUserDetails();
        Timer(Duration(seconds: 2), () {
          print("This code executes after 2 seconds");
          // Navigator.pushNamedAndRemoveUntil(
          //     context, Routes.homePage, (route) => false);
        });
      }
    });
  }

  getUserDetails() {
    final provider = Provider.of<Data>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    print(user?.email);
    print('Login name');
    FirebaseFirestore.instance
        .collection("users data")
        .where("userName", isEqualTo: "${user?.email}")
        .get()
        .then((value) {
      value.docs.forEach((result) {
        print(result.data().values.elementAt(2));
        String newname = result.data().values.elementAt(2);
        // provider.changeShopName(newname);
      });
      print('Got it');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pushToHome();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SizedBox(
          height: size.height / 6,
          width: size.height / 6,
          child: Image.asset("assets/Order-Now.png"),
        ),
      ),
    );
  }
}
