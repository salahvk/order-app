import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:order/animation/animation.dart';
import 'package:order/components/color_manager.dart';
import 'package:order/components/style_manager.dart';
import 'package:order/services/routes_manager.dart';
import 'package:order/main.dart';
import 'package:order/model/shops.dart';
import 'package:provider/provider.dart';

class ShopList extends StatefulWidget {
  const ShopList({Key? key}) : super(key: key);

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  String selectedPlace = '';
  String? shopName;
  final storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

  @override
  void initState() {
    final provider = Provider.of<Data>(context, listen: false);
    // TODO: implement initState
    super.initState();
    selectedPlace = provider.place;

    print('vanno');
    print(selectedPlace);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser!;
    final provider = Provider.of<Data>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user.email} '),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.introduction);
                  FirebaseAuth.instance.signOut();
                  provider.place = '';
                },
                child: const Text('Log out')),
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder<List<Shops>>(
            stream: readShops(),
            builder: (contexts, snapshot) {
              if (snapshot.hasError) {
                final shops = snapshot.data;
                print(shops?.length);

                print('l');
                return Text('Something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final shops = snapshot.data;
                print(shops);

                List<String>? name = shops?.map(((e) {
                  return e.shopName;
                })).toList();
                int? len = name?.length;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return FadeCustomAnimation(
                      delay: 0.001,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        child: InkWell(
                          onTap: () {
                            final provider =
                                Provider.of<Data>(context, listen: false);
                            Navigator.of(context).pushNamed(Routes.homePage);
                            provider.shopName = name![index];
                            shopName = name[index];
                            createChat();
                          },
                          child: Container(
                            // width: 300,
                            height: size.height / 10,
                            decoration: BoxDecoration(
                                // color: Colors.red,
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(name![index],
                                  style: getBoldtStyle(
                                      color: ColorManager.background,
                                      fontSize: 20)),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: len,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Stream<List<Shops>> readShops() {
    final provider = Provider.of<Data>(context, listen: false);
    // print(FirebaseFirestore.instance.collection('places').doc('Naderi').);
    final data = FirebaseFirestore.instance
        .collection('places')
        .doc(provider.place)
        .collection('shopNames')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Shops.fromJson(doc.data())).toList());

    print('Kingdom');
    print(data);
    return data;
  }

  createChat() async {
    // final provider = Provider.of<Data>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    final docMsg = FirebaseFirestore.instance
        .collection('places')
        .doc(selectedPlace)
        .collection('shopNames')
        .doc(shopName)
        .collection('rooms')
        .doc(user?.uid)
        .collection('messages')
        .doc();

    final text = {"text": "Hi"};

    try {
      await docMsg.set(text);
    } on Exception {
      print('object');
    }
  }
}
