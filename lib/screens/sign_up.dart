import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:order/components/color_manager.dart';
import 'package:order/components/style_manager.dart';
import 'package:order/constants/colors.dart';
import 'package:order/model/shops.dart';
import 'package:order/services/routes_manager.dart';
import 'package:order/utilis/snackbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController pincontroller = TextEditingController();
  TextEditingController shopcontroller = TextEditingController();

  var focusNode = FocusNode();
  bool isPasswordVisible = false;

  String email = "";
  String password = "";
  String shopName = "";
  String pin = "";
  String? selectedValue;

  bool loading = false;
  bool? uStatus;
  bool tPin = false;
  bool pinLoading = false;

  List<String?> pNames = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    void setPsswordVisibility() {
      setState(() {
        isPasswordVisible = !isPasswordVisible;
      });
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 221, 221),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
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
                      'Welcome friend!',
                      style: getRegularStyle(
                          color: ColorManager.background, fontSize: 16),
                    ),
                  ),
                  Text(
                    'Sign up a new account \nin Order app!',
                    style: getRegularStyle(
                        color: ColorManager.background, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.04, bottom: size.height * 0.02),
                    child: Container(
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                          color: ColorManager.whiteText,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TextField(
                            controller: emailcontroller,
                            onSubmitted: (value) {
                              FocusScope.of(context).requestFocus(focusNode);
                            },
                            onChanged: (value) {},
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter your Email',
                                hintStyle: getRegularStyle(
                                    color: ColorManager.grayDark,
                                    fontSize: 12)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.02),
                    child: Container(
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                          color: ColorManager.whiteText,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: TextField(
                          onSubmitted: (value) {
                            FocusScope.of(context).requestFocus(focusNode);
                          },
                          controller: passcontroller,
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setPsswordVisibility();
                                  }),
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: getRegularStyle(
                                  color: ColorManager.grayDark, fontSize: 12)),
                        ),
                      )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: size.height * 0.02,
                    ),
                    child: Container(
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                          color: ColorManager.whiteText,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(
                            left: 8.0, right: size.height * 0.01),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          onSubmitted: (value) {
                            FocusScope.of(context).requestFocus(focusNode);
                          },
                          controller: pincontroller,
                          onChanged: (value) async {
                            if (value.length == 6) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              // getPinCode(value: value);
                            }
                          },
                          decoration: InputDecoration(
                              suffix: pinLoading
                                  ? SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Icon(
                                      tPin
                                          ? Icons.done
                                          : FontAwesomeIcons.xmark,
                                      color: tPin ? Colors.green : Colors.red,
                                    ),
                              counterText: '',
                              border: InputBorder.none,
                              hintText: 'Enter your Pincode',
                              hintStyle: getRegularStyle(
                                  color: ColorManager.grayDark, fontSize: 12)),
                        ),
                      )),
                    ),
                  ),
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
                            items: pNames
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
                            ? Text("Sign Up",
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
                          child: Divider(
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
                          child: Divider(
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
                              decoration: BoxDecoration(),
                              child: Center(
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
                              decoration: BoxDecoration(),
                              child: Center(
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
                              decoration: BoxDecoration(),
                              child: Center(
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
    email = emailcontroller.text.trim();
    password = passcontroller.text.trim();
    shopName = shopcontroller.text.trim();
    pin = pincontroller.text.trim();
    print(email);
    print(shopName);
    print(pin);

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    print('$emailValid emailValid');

    if (email.isEmpty || email.length < 4 || emailValid != true) {
      showSnackBar("Enter a valid Email", context,
          icon: Icons.email, color: Colors.white);
    } else if (password.isEmpty || password.length < 6) {
      showSnackBar("Password must be 6 Characters", context,
          icon: Icons.email, color: Colors.white);
    } else if (pin.isEmpty) {
      showSnackBar("Enter Your Location Pin", context,
          icon: Icons.place, color: Colors.white);
      return;
    } else if (selectedValue == null) {
      showSnackBar("Select Your Location", context,
          icon: Icons.place, color: Colors.white);
      return;
    } else if (shopName.isEmpty) {
      showSnackBar("Enter Your shop name", context,
          icon: Icons.shop, color: Colors.white);
      return;
    } else {
      setState(() {
        loading = true;
      });

      if (uStatus == false) {
        showSnackBar("Enter a valid Pin", context,
            icon: Icons.shop, color: Colors.white);
        setState(() {
          loading = false;
        });
        return;
      }
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailcontroller.text, password: passcontroller.text);
        showSnackBar("Account created Successfully", context,
            icon: Icons.email, color: Colors.white);
        print('succes');
        final authUser = FirebaseAuth.instance.currentUser;
        print("this is  $authUser");
        final docUser = FirebaseFirestore.instance
            .collection('admins data')
            .doc(authUser?.uid);
        // final user = Shop(
        //   id: docUser.id,
        //   name: email,
        //   pin: pin,
        //   shopName: shopName,
        //   place: selectedValue,
        // );
        // final json = user.tojson();
        print(docUser.id);

        // try {
        //   await docUser.set(json);
        // } on Exception {
        //   print('object');
        // }

        // * place field creation start

        final docPlace = FirebaseFirestore.instance
            .collection('places')
            .doc("$selectedValue");
        final place = {"place": "$selectedValue"};
        print(docPlace.id);
        final docId = docPlace.id;

        try {
          await docPlace.set(place);
        } on Exception {
          print('object');
        }

        final docShop = FirebaseFirestore.instance
            .collection('places')
            .doc(docId)
            .collection('shopNames')
            .doc();

        final shopNames = {"shopName": "$shopName"};
        // final docShopId = docShop.id;
        try {
          await docShop.set(shopNames);
        } on Exception {
          print('object');
        }

        Navigator.pushReplacementNamed(context, Routes.signInRoute);

        loading = false;
      } on FirebaseAuthException catch (e) {
        setState(() {
          loading = false;
        });
        print(e.code);
        if (e.code == 'email-already-in-use') {
          showSnackBar(
              "The email address is already in use by another account", context,
              icon: Icons.email, color: Colors.white);
        }
        print(e.message);
      }
    }
  }

  // getPinCode({required String value}) async {
  //   setState(() {
  //     pNames = [];
  //     selectedValue = null;
  //     pinLoading = true;
  //   });
  //   print('Pin entered');

  //   try {
  //     final response = await http.get(
  //       Uri.parse('https://api.postalpincode.in/pincode/$value'),
  //     );
  //     print(response.body);
  //     print(response.statusCode);

  //     // * Status code 200
  //     if (response.statusCode == 200) {
  //       var json = jsonDecode(response.body);
  //       if (json != null) {
  //         json.forEach((element) {
  //           final pin = PinNo.fromJson(element);
  //           print(pin.status);
  //           print(pin.postOffice?.map((e) => e.name));

  //           print(pin.message);
  //           if (pin.status == 'Success') {
  //             pNames = pin.postOffice!.map((e) => e.name).toList();
  //             setState(() {
  //               pinLoading = false;
  //               tPin = true;
  //             });
  //           } else {
  //             showSnackBar("Incorrect Pin", context,
  //                 icon: Icons.pin, color: Colors.white);
  //             setState(() {
  //               pinLoading = false;
  //               tPin = false;
  //             });
  //           }
  //         });
  //       } else {
  //         print('Something bad happen');
  //       }
  //     } else {
  //       print('Something Wrong');
  //       setState(() {
  //         pinLoading = false;
  //       });
  //       showSnackBar("Incorrect Pin", context,
  //           icon: Icons.pin, color: Colors.white);
  //     }
  //   } on Exception catch (e) {
  //     print(e);
  //     setState(() {
  //       pinLoading = false;
  //     });
  //     showSnackBar("Incorrect Pin", context,
  //         icon: Icons.pin, color: Colors.white);
  //   }
  // }
}
