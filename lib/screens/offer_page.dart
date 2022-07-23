import 'package:flutter/material.dart';
import 'package:order/components/color_manager.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [FirstList(size: size), SecondList(size: size)],
      ),
    );
  }
}

class SecondList extends StatelessWidget {
  const SecondList({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.06,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: ColorManager.background, width: 0.4),
                    // color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Text('${index + 1}'),
                    ),
                    Container(
                      width: 200,
                      child: TextFormField(
                        // controller: numController,
                        decoration: const InputDecoration(
                            counterText: '', hintText: 'Your Product'),
                        keyboardType: TextInputType.name,
                        // focusNode: focusNode,
                      ),
                    ),
                    Container(
                      width: 50,
                      child: TextFormField(
                        // controller: numController,
                        decoration: const InputDecoration(
                            counterText: '', hintText: 'Price'),
                        keyboardType: TextInputType.number,
                        // focusNode: focusNode,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class FirstList extends StatelessWidget {
  const FirstList({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(13.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.background),
                  // color: ColorManager.errorRed,
                  borderRadius: BorderRadius.circular(10)),
              width: size.width * 0.4,
              height: size.height * 0.3,
              child: Column(
                children: [
                  Container(
                    child: Center(
                      child: Text('Add an Image'),
                    ),
                    height: size.height * 0.15,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorManager.background, width: 0.4),
                        // color: ColorManager.primary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
