import 'package:cloud_firestore/cloud_firestore.dart';

class Messages {
  // String authorId;
  String text;
  Timestamp lastMessageTime;
  String author;

  Messages({
    // required this.authorId,
    required this.text,
    required this.lastMessageTime,
    required this.author,
  });

  Map<String, dynamic> tojson() => {
        // ' authorId': authorId,
        'text': text,
        'lastMessageTime': lastMessageTime,
        'author': author
      };

  static Messages fromJson(Map<String, dynamic> json) => Messages(
        // authorId: json[' authorId'],
        text: json['text'],
        lastMessageTime: json['lastMessageTime'],
        author: json['author'],
      );
}
