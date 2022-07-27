// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database_rest/firebase_database_rest.dart';
// import 'package:flutter/material.dart';
// import 'package:order/services/routes_manager.dart';
// import 'package:order/constants/colors.dart';
// import 'package:order/constants/textfieldDecoration.dart';
// import 'package:order/customWidgets/dropdown.dart';
// import 'package:order/main.dart';
// import 'package:order/model/shops.dart';
// import 'package:order/model/usersData.dart';
// import 'package:order/utilis/snackbar.dart';
// import 'package:provider/provider.dart';

// class SignUps extends StatefulWidget {
//   const SignUps({Key? key}) : super(key: key);

//   @override
//   State<SignUps> createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUps> {
//   TextEditingController emailcontroller = TextEditingController();
//   TextEditingController passcontroller = TextEditingController();
//   var focusNode = FocusNode();
//   bool isPasswordVisible = false;
//   String email = "";
//   String password = "";
//   bool loading = false;
//   List<Shops> newlist = [];
//   List<dynamic> placeNames = [];

//   String? selectedValue;
//   final snackBar = const SnackBar(
//     content: Text('Account Created!'),
//   );
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     void setPsswordVisibility() {
//       setState(() {
//         isPasswordVisible = !isPasswordVisible;
//       });
//     }

//     return Scaffold(
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             Container(
//               margin: EdgeInsets.only(top: size.height / 26),
//               child: Text("Sign Up",
//                   style: TextStyle(
//                       fontSize: size.height / 38.5,
//                       fontFamily: "Open",
//                       fontWeight: FontWeight.w600,
//                       color: incomingCallerNameColor)),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: size.height / 32),
//               height: size.height / 17,
//               width: size.width / 1.2,
//               child: TextField(
//                 autofocus: false,
//                 controller: emailcontroller,
//                 // keyboardType: TextInputType.emailAddress,
//                 onSubmitted: (value) {
//                   FocusScope.of(context).requestFocus(focusNode);
//                 },
//                 onChanged: (value) {},
//                 style: TextStyle(
//                     color: readRowTextColor,
//                     fontFamily: "Open",
//                     fontWeight: FontWeight.w600,
//                     fontSize: size.height / 54),
//                 decoration: searchBoxDecoration.copyWith(
//                   hintText: "Email",
//                 ),
//                 cursorColor: readRowTextColor,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(top: size.height / 30),
//               height: size.height / 17,
//               width: size.width / 1.2,
//               child: TextField(
//                 focusNode: focusNode,
//                 autofocus: false,
//                 obscureText: !isPasswordVisible,
//                 controller: passcontroller,
//                 onSubmitted: (value) {},
//                 onChanged: (value) {
//                   setState(() {
//                     password = value;
//                   });
//                 },
//                 style: TextStyle(
//                     color: readRowTextColor,
//                     fontFamily: "Open",
//                     fontWeight: FontWeight.w600,
//                     fontSize: size.height / 54),
//                 decoration: searchBoxDecoration.copyWith(
//                   hintText: "Password",
//                   suffixIcon: IconButton(
//                       icon: Icon(
//                         isPasswordVisible
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                       ),
//                       onPressed: () {
//                         setPsswordVisibility();
//                       }),
//                 ),
//                 cursorColor: readRowTextColor,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton2(
//                   isExpanded: true,
//                   hint: Row(
//                     children: const [
//                       Icon(
//                         Icons.list,
//                         size: 16,
//                       ),
//                       SizedBox(
//                         width: 4,
//                       ),
//                       Expanded(
//                         child: Text(
//                           'Select Your Location',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                   items: placeNames
//                       .map((item) => DropdownMenuItem<String>(
//                             value: item,
//                             child: Text(
//                               item!,
//                             ),
//                           ))
//                       .toList(),
//                   onChanged: (String? newValue) {
//                     // readShops();
//                     getData();
//                     print('Butterfly');
//                     print(newlist);

//                     setState(() {
//                       selectedValue = newValue;
//                     });
//                   },
//                   value: selectedValue,
//                   icon: const Icon(
//                     Icons.arrow_forward_ios_outlined,
//                   ),
//                   iconSize: 14,
//                   iconEnabledColor: Colors.yellow,
//                   iconDisabledColor: Colors.grey,
//                   buttonHeight: 50,
//                   buttonWidth: 360,
//                   buttonPadding: const EdgeInsets.only(left: 14, right: 14),
//                   buttonDecoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     border: Border.all(
//                       color: Colors.black26,
//                     ),
//                     color: Colors.white,
//                   ),
//                   buttonElevation: 2,
//                   itemHeight: 40,
//                   itemPadding: const EdgeInsets.only(left: 14, right: 14),
//                   dropdownMaxHeight: 200,
//                   dropdownWidth: size.width * 0.4,
//                   dropdownPadding: null,
//                   dropdownDecoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     // color: Colors.redAccent,
//                   ),
//                   dropdownElevation: 8,
//                   scrollbarRadius: const Radius.circular(40),
//                   scrollbarThickness: 6,
//                   scrollbarAlwaysShow: true,
//                   offset: const Offset(100, 0),
//                 ),
//               ),
//             ),
//             Row(
//               children: const [],
//             ),
//             GestureDetector(
//               onTap: () {
//                 print('tappp');

//                 onsubmitted();
//               },
//               child: Container(
//                 margin: EdgeInsets.only(top: size.height / 25),
//                 height: size.height / 17,
//                 width: size.width / 1.2,
//                 decoration: BoxDecoration(
//                     color: Colors.blue,
//                     border: Border.all(color: borderColor, width: 1),
//                     borderRadius: const BorderRadius.all(Radius.circular(28))),
//                 child: Center(
//                   child: loading == false
//                       ? Text("Sign Up",
//                           style: TextStyle(
//                               fontSize: size.height / 51,
//                               fontFamily: "Open",
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white))
//                       : Container(
//                           child: const CircularProgressIndicator(
//                             backgroundColor: fabColor,
//                             valueColor:
//                                 AlwaysStoppedAnimation<Color>(Colors.white),
//                           ),
//                         ),
//                 ),
//               ),
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Already have an account? '),
//                 GestureDetector(
//                   child: const Text(
//                     'Sign In',
//                     style: TextStyle(color: Colors.blue),
//                   ),
//                   onTap: () {
//                     Navigator.pushReplacementNamed(context, Routes.signInRoute);
//                   },
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             )
//           ],
//         ),
//       )),
//     );
//   }

//   Future onsubmitted() async {
//     email = emailcontroller.text.trim();
//     password = passcontroller.text.trim();
//     print(email);
//     bool emailValid = RegExp(
//             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//         .hasMatch(email);
//     print('$emailValid emailValid');

//     if (email.isEmpty || email.length < 4 || emailValid != true) {
//       showSnackBar("Enter a valid Email", context,
//           icon: Icons.email, color: Colors.white);
//     } else if (password.isEmpty || password.length < 6) {
//       showSnackBar("Password must be 6 Characters", context,
//           icon: Icons.email, color: Colors.white);
//     } else if (selectedValue == null) {
//       showSnackBar("Select Your Location", context,
//           icon: Icons.place, color: Colors.white);
//       return;
//     } else {
//       setState(() {
//         loading = true;
//       });
//       try {
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//             email: emailcontroller.text, password: passcontroller.text);
//         ScaffoldMessenger.of(context).showSnackBar(snackBar);
//         print('successsssssssss');
//         final docUser =
//             FirebaseFirestore.instance.collection('users data').doc();
//         final user = Users(id: docUser.id, name: email, place: selectedValue);
//         final json = user.tojson();
//         try {
//           await docUser.set(json);
//         } on Exception {
//           print('object');
//         }

//         Navigator.pushReplacementNamed(context, Routes.signInRoute);
//         loading = false;
//       } on FirebaseAuthException catch (e) {
//         setState(() {
//           loading = false;
//         });
//         print(e.code);
//         if (e.code == 'email-already-in-use') {
//           showSnackBar(
//               "The email address is already in use by another account", context,
//               icon: Icons.email, color: Colors.white);
//         }
//         print(e.message);
//       }
//     }
//   }

//   // Stream<List<Shops>> readShops() {
//   //   final nShops = FirebaseFirestore.instance.collection('Calicut').snapshots()
//   //       // .map((event) => event.docs.first);
//   //       .map((snapshot) {
//   //     newlist = snapshot.docs.map((doc) => Shops.fromJson(doc.data())).toList();
//   //     print(newlist.length);
//   //     print('hiveaaa');
//   //     return newlist;
//   //   });
//   //   // print(nShops.elementAt(2));
//   //   print('Siuuu');
//   //   return nShops;
//   // }
// //   Future getDocs() async {
// //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("collection"). doc();
// //   for (int i = 0; i < querySnapshot.documents.length; i++) {
// //     var a = querySnapshot.documents[i];
// //     print(a.documentID);
// //   }
// // }
//   // CollectionReference collectionRef =
//   //     FirebaseFirestore.instance.collection('Calicut').;
//   CollectionReference collectionRef =
//       FirebaseFirestore.instance.collection('places');
//   Future<void> getData() async {
//     QuerySnapshot querySnapshot = await collectionRef.get();

//     placeNames = querySnapshot.docs.map((doc) => doc.get('place')).toList();
//     print(placeNames);
//     return;
//   }

//   // final firstlis = placeNames.first;
//   // // jsonDecode();
//   // final newjson = jsonEncode(firstlis);
//   // print(newjson);
//   // print(jsonDecode(newjson));
//   // final s = jsonDecode(newjson);
//   // print(s['place']);
// }

// class CustomClass {
//   final String text;
//   final int value;
//   CustomClass({required this.text, required this.value});
//   CustomClass.fromJson(Map<String, dynamic> json)
//       : text = json['text'],
//         value = json['value'];

//   static Map<String, dynamic> toJson(CustomClass value) =>
//       {'text': value.text, 'value': value.value};
// }
