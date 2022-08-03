import 'dart:math';

import 'package:flutter/material.dart';
import 'package:order/components/color_manager.dart';
import 'package:order/main.dart';
import 'package:provider/provider.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Data>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        flexibleSpace: Container(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                decoration: BoxDecoration(
                    color: ColorManager.whiteText,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: ColorManager.grayLight)),
                width: size.width * 0.9,
                height: 50,
              )
            ],
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff11998E), Color(0xff38EF7D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              // height: 50,
              // width: 500,
              // color: ColorManager.errorRed,
              child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          // height: 100,

                          width: 120,
                          decoration: BoxDecoration(
                            color: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)]
                                .withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          )),
                    );
                  }),
                  itemCount: 15,
                  scrollDirection: Axis.horizontal),
            ),
          ),
          Flexible(
            flex: 4,
            child: Container(
              // height: 50,
              // width: 500,
              // color: ColorManager.errorRed,
              child: ListView.builder(
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.primaries[
                                  Random().nextInt(Colors.primaries.length)]
                              .withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 50,
                      ),
                    );
                  }),
                  itemCount: 15,
                  scrollDirection: Axis.vertical),
            ),
          )
        ],
      ),
    );
  }
}
