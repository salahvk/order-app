import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:order/components/color_manager.dart';
import 'package:order/components/style_manager.dart';
import 'package:order/services/routes_manager.dart';

import '../components/assets_manager.dart';

class Introduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/background.jpeg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            scale: 1,
          ),
          SafeArea(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFffffff).withOpacity(0.1),
                            Color(0xFFFFFFFF).withOpacity(0.05),
                          ],
                          stops: [
                            0.1,
                            1,
                          ])),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: LottieBuilder.asset(
                            ImageAssets.food,
                            width: size.width * 0.9,
                            height: size.height * 0.5,
                          )),
                      Text(
                        'Order your \nBest products here!',
                        textAlign: TextAlign.center,
                        style: getBoldtStyle(
                            color: ColorManager.whiteText, fontSize: 24),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20, bottom: size.height * 0.16),
                        child: Text(
                          'Order your products here\n and within minutes it will reach your destination',
                          textAlign: TextAlign.center,
                          style: getBoldtStyle(
                              color: ColorManager.grayLight, fontSize: 12),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            color: ColorManager.whiteText,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              child: Container(
                                width: size.width * 0.4,
                                height: size.height * 0.06,
                                decoration: BoxDecoration(),
                                child: Center(
                                  child: Text(
                                    'Email',
                                    style: getBoldtStyle(
                                        color: ColorManager.grayDark),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.signInRoute);
                              },
                            ),
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.newWhite,
                            child: InkWell(
                              child: Container(
                                width: size.width * 0.4,
                                height: size.height * 0.06,
                                decoration: BoxDecoration(),
                                child: Center(
                                  child: Text(
                                    'Phone Number',
                                    style: getBoldtStyle(
                                        color: ColorManager.grayDark),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.phoneNumber);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
