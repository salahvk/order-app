class Messages {
  // String authorId;
  String text;

  Messages({
    // required this.authorId,
    required this.text,
  });

  Map<String, dynamic> tojson() => {
        // ' authorId': authorId,
        'text': text,
      };

  static Messages fromJson(Map<String, dynamic> json) => Messages(
        // authorId: json[' authorId'],
        text: json['text'],
      );
}
