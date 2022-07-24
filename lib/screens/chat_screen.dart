import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:order/main.dart';
import 'package:order/model/messages.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController chatMsg = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          StreamBuilder<List<Messages>>(
              // initialData: widget.room,
              stream: readUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  final shops = snapshot.data;
                  print(shops?.length);

                  print('l');
                  return Text('Something went wrong! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final shops = snapshot.data;
                  print(shops);
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        return ChatBubble(
                          clipper:
                              ChatBubbleClipper1(type: BubbleType.sendBubble),
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.only(top: 20),
                          backGroundColor: Colors.blue,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: const Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                      itemCount: 1);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          // ),
          // ),

          Positioned(
            bottom: 20,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 5),
                  child: Container(
                    color: Colors.amber,
                    width: size.width * 0.86,
                    height: 50,
                    child: TextField(
                      controller: chatMsg,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      sendMessage();
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    ));
  }

  sendMessage() {}

  Stream<List<Messages>> readUsers() {
    final provider = Provider.of<Data>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    // print(FirebaseFirestore.instance.collection('places').doc('Naderi').);
    final data = FirebaseFirestore.instance
        .collection('places')
        .doc(provider.place)
        .collection('shopNames')
        .doc(provider.shopName)
        .collection('rooms')
        .doc(user?.uid)
        .collection('messages')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Messages.fromJson(doc.data())).toList());

    print('Kingdom');
    return data;
  }
}
