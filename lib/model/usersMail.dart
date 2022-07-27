class UserMail {
  String? name;
  String? Uid;

  UserMail({required this.name, required this.Uid});

  Map<String, dynamic> tojson() => {'name': name, 'Uid': Uid};

  static UserMail fromJson(Map<String, dynamic> json) => UserMail(
        name: json['name'],
        Uid: json['Uid'],
      );
}
