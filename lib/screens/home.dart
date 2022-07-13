import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:order/screens/offerPage.dart';
import 'package:order/screens/sign_in.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('place menu');
            return const OfferPage();
          } else {
            print('Login pages');
            return const LoginPage();
          }
        },
      ),
    );
  }
}
