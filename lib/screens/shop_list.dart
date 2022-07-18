import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:order/animation/animation.dart';
import 'package:order/components/routes_manager.dart';
import 'package:order/main.dart';
import 'package:order/model/shops.dart';
import 'package:provider/provider.dart';

class ShopList extends StatefulWidget {
  ShopList({Key? key}) : super(key: key);

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  String selectedPlace = '';
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
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, Routes.homeRoute);
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
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                        child: Container(
                          // width: 300,
                          height: size.height / 10,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(name![index]),
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

  Stream<List<Shops>> readShops() => FirebaseFirestore.instance
      .collection('$selectedPlace')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Shops.fromJson(doc.data())).toList());
}
