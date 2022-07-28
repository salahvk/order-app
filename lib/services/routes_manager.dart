import 'package:flutter/material.dart';
import 'package:order/screens/home_page.dart';
import 'package:order/screens/introduction.dart';
import 'package:order/screens/otp_after_screen.dart';
import 'package:order/screens/phone_number.dart';
import 'package:order/screens/shop_list.dart';
import 'package:order/screens/sign_up.dart';

import '../screens/sign_in.dart';
import '../screens/splash_screen.dart';

class Routes {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String introduction = '/introduction';
  static const String signInRoute = '/signIn';
  static const String signUpRoute = '/signUp';
  static const String phoneNumber = '/phoneNumber';
  static const String otpAfter = '/otpAfter';
  static const String placeMenu = '/PlaceMenu';
  static const String data = '/data';
  static const String dataEntry = '/dataEntry';
  static const String shopList = '/shopList';
  static const String homePage = '/homePage';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.introduction:
        return MaterialPageRoute(builder: (_) => Introduction());
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.signInRoute:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case Routes.otpAfter:
        return MaterialPageRoute(builder: (_) => const OtpAfter());
      case Routes.shopList:
        return MaterialPageRoute(builder: (_) => ShopList());
      case Routes.phoneNumber:
        return MaterialPageRoute(builder: (_) => PhoneNumber());
      // case Routes.data:
      //   return MaterialPageRoute(builder: (_) => const Data());
      // case Routes.dataEntry:
      //   return MaterialPageRoute(builder: (_) => const DataEntry());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text("No Route Found"),
        ),
        body: const Center(
          child: Text("No Route Found"),
        ),
      ),
    );
  }
}
