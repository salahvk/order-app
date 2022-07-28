import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:order/components/color_manager.dart';
import 'package:order/components/style_manager.dart';
import 'package:order/constants/colors.dart';
import 'package:order/main.dart';
import 'package:order/model/usersData.dart';
import 'package:order/services/routes_manager.dart';
import 'package:order/utilis/snackbar.dart';
import 'package:provider/provider.dart';

class OtpAfter extends StatefulWidget {
  const OtpAfter({Key? key}) : super(key: key);

  @override
  State<OtpAfter> createState() => _OtpAfterState();
}

class _OtpAfterState extends State<OtpAfter> {
  TextEditingController namecontroller = TextEditingController();

  var focusNode = FocusNode();
  bool isPasswordVisible = false;

  List<dynamic> placeNames = [];
  String name = "";
  String? selectedValue;

  bool loading = false;
  List<String?> pNames = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 221, 221),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [ColorManager.gradient1, ColorManager.gradient2],
          )),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.08, right: size.width * 0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.11, bottom: size.height * 0.02),
                    child: Text(
                      '',
                      style: getRegularStyle(
                          color: ColorManager.background, fontSize: 16),
                    ),
                  ),
                  Text(
                    '',
                    style: getRegularStyle(
                        color: ColorManager.background, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),

                  // ? Your name field start
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02),
                    child: Container(
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                          color: ColorManager.whiteText,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextField(
                            controller: namecontroller,
                            keyboardType: TextInputType.name,
                            onSubmitted: (value) {
                              FocusScope.of(context).requestFocus(focusNode);
                            },
                            onChanged: (value) {},
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your name to display',
                                hintStyle: getRegularStyle(
                                    color: ColorManager.grayDark,
                                    fontSize: 12)),
                          ),
                        ),
                      ),
                    ),
                  ),

// ? Your name field end

                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02),
                    child: Container(
                      height: size.height * 0.06,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                          color: ColorManager.whiteText,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            hint: Text('Select Your Location',
                                style: getRegularStyle(
                                    color: ColorManager.grayDark,
                                    fontSize: 12)),
                            dropdownMaxHeight: size.height * .3,
                            items: placeNames
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item!,
                                      ),
                                    ))
                                .toList(),
                            value: selectedValue,
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value as String;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // * Shop name

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [],
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      onsubmitted();
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: size.height / 25, bottom: size.height * 0.04),
                      height: size.height / 17,
                      width: size.width / 1.2,
                      decoration: BoxDecoration(
                          color: ColorManager.errorRed,
                          border: Border.all(color: borderColor, width: 1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: loading == false
                            ? Text("Next",
                                style: TextStyle(
                                    fontSize: size.height / 51,
                                    fontFamily: "Open",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white))
                            : Container(
                                child: const CircularProgressIndicator(
                                  backgroundColor: fabColor,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                      ),
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: const Divider(
                            color: Colors.black,
                            height: 50,
                          )),
                    ),
                    Text("Or continue with",
                        style: getRegularStyle(color: ColorManager.grayDark)),
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: const Divider(
                            color: Colors.black,
                            height: 50,
                          )),
                    ),
                  ]),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Material(
                          color: ColorManager.whiteText,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            child: Container(
                              width: size.width * 0.2,
                              height: size.height * 0.06,
                              decoration: const BoxDecoration(),
                              child: const Center(
                                  child: FaIcon(
                                FontAwesomeIcons.google,
                                color: ColorManager.errorRed,
                              )),
                            ),
                            onTap: () {
                              // Navigator.pushNamed(context, Routes.SignUpRoute);
                            },
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManager.whiteText,
                          child: InkWell(
                            child: Container(
                              width: size.width * 0.2,
                              height: size.height * 0.06,
                              decoration: const BoxDecoration(),
                              child: const Center(
                                  child: FaIcon(
                                FontAwesomeIcons.apple,
                              )),
                            ),
                            onTap: () {
                              // Navigator.pushNamed(context, Routes.phoneNumber);
                            },
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManager.whiteText,
                          child: InkWell(
                            child: Container(
                              width: size.width * 0.2,
                              height: size.height * 0.06,
                              decoration: const BoxDecoration(),
                              child: const Center(
                                  child: FaIcon(
                                FontAwesomeIcons.facebook,
                                color: Colors.blue,
                              )),
                            ),
                            onTap: () {
                              // Navigator.pushNamed(context, Routes.phoneNumber);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: getRegularStyle(
                            color: ColorManager.background, fontSize: 12),
                      ),
                      GestureDetector(
                        child: Text(
                          'Sign in now',
                          style:
                              getRegularStyle(color: Colors.blue, fontSize: 12),
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.signInRoute);
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future onsubmitted() async {
    name = namecontroller.text;
    print("On submit function initiated");

    if (selectedValue == null) {
      showSnackBar("Select Your Location", context,
          icon: Icons.place, color: Colors.white);
      return;
    } else if (name.length < 0) {
      showSnackBar("Enter your name", context,
          icon: Icons.person, color: Colors.white);
      return;
    } else {
      setState(() {
        loading = true;
      });

      final authUser = FirebaseAuth.instance.currentUser;
      final userPhoneNo = authUser?.phoneNumber;
      final userUid = authUser?.uid;

      log(userPhoneNo!);
      log(userUid!);
      try {
        // * Enter data into firestore
        final docUser =
            FirebaseFirestore.instance.collection('users data').doc(userUid);
        final user = Users(
            email: userPhoneNo,
            id: authUser!.uid,
            name: name,
            place: selectedValue);
        final json = user.tojson();
        try {
          await docUser.set(json);
          showSnackBar("Account created Successfully", context,
              icon: Icons.phone_android, color: Colors.white);
          print('Account created Successfully');
        } on Exception {
          print('Some exception occured');
        }
        await getUserDetails();
        Navigator.pushReplacementNamed(context, Routes.shopList);

        loading = false;
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
        });
        print(e.message);
      }
    }
  }

  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('places');
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await collectionRef.get();

    placeNames = querySnapshot.docs.map((doc) => doc.get('place')).toList();
    print(placeNames);
    return;
  }

  getUserDetails() async {
    final provider = Provider.of<Data>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    log('Get user details');
    print(user?.phoneNumber);
    print('Login number');

    await FirebaseFirestore.instance
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
}
