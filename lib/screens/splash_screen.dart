import 'dart:async';
import 'dart:developer';

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
        Timer(const Duration(seconds: 2), () {
          print("This code executes after 2 seconds");
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.shopList, (route) => false);
        });
      }
    });
  }

  getUserDetails() {
    final provider = Provider.of<Data>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    log('Get user details');
    print(user?.email);
    print('Login name');

    FirebaseFirestore.instance
        .collection("users data")
        .doc(user?.uid)
        .get()
        .then((value) {
      final userPlace = value.get('place');
      final userName = value.get('name');
      print('is this the place $userPlace ?');
      provider.changePlace(userPlace);
      print('is this the name $userName ?');
      provider.changeName(userName);
      print('user place and name getting');
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
