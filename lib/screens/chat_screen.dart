import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:order/components/color_manager.dart';
import 'package:order/components/style_manager.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Data>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: Text(
            provider.shopName,
            style:
                getRegularStyle(color: ColorManager.background, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              StreamBuilder<List<Messages>>(
                  // initialData: widget.room,
                  stream: readUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print('l');
                      return Text('Something went wrong! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final msg = snapshot.data;
                      final len = msg?.length;
                      List<String>? name = msg?.map(((e) {
                        return e.text;
                      })).toList();
                      List<String>? auth = msg?.map(((e) {
                        return e.author;
                      })).toList();

                      print(msg);
                      return ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.only(bottom: 64),
                          itemBuilder: (context, index) {
                            final user = FirebaseAuth.instance.currentUser;
                            bool sentByme = auth?[len! - 1 - index] != user?.uid
                                ? false
                                : true;
                            return ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: sentByme
                                      ? BubbleType.sendBubble
                                      : BubbleType.receiverBubble),
                              alignment: sentByme
                                  ? Alignment.topRight
                                  : Alignment.topLeft,
                              margin: const EdgeInsets.only(top: 20),
                              backGroundColor: sentByme
                                  ? const Color.fromARGB(255, 133, 166, 194)
                                  : const Color.fromARGB(255, 57, 99, 137),
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.7,
                                ),
                                child: Text(
                                  "${name?[len! - 1 - index]}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          },
                          itemCount: len);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              // ),
              // ),

              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  color: Colors.white,
                  width: size.width,
                  height: 60,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: ColorManager.grayLight)),
                          width: size.width * 0.86,
                          height: 50,
                          child: TextField(
                            controller: chatMsg,
                            decoration:
                                const InputDecoration(border: InputBorder.none),
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
                ),
              )
            ],
          ),
        ));
  }

  sendMessage() async {
    final provider = Provider.of<Data>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    final docMsg = FirebaseFirestore.instance
        .collection('places')
        .doc(provider.place)
        .collection('shopNames')
        .doc(provider.shopName)
        .collection('rooms')
        .doc(user?.uid)
        .collection('messages')
        .doc();

    final text = Messages(
        text: chatMsg.text,
        lastMessageTime: Timestamp.now(),
        author: user!.uid);

    try {
      await docMsg.set(text.tojson());
    } on Exception {
      print('object');
    }
    chatMsg.text = '';
  }

  Stream<List<Messages>> readUsers() {
    final provider = Provider.of<Data>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;
    final data = FirebaseFirestore.instance
        .collection('places')
        .doc(provider.place)
        .collection('shopNames')
        .doc(provider.shopName)
        .collection('rooms')
        .doc(user?.uid)
        .collection('messages')
        .orderBy('lastMessageTime')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Messages.fromJson(doc.data())).toList());
    print(data);
    print('Kingdom');
    return data;
  }

  // static DateTime toDateTime(Timestamp value) {
  //   if (value == null) {
  //     print('null');
  //     return DateTime.now();
  //   }
  //   return value.toDate();
  // }
}
