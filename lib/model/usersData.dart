class Users {
  String email;
  String id;
  String name;
  String? place;

  Users({
    required this.email,
    required this.id,
    required this.name,
    this.place,
  });

  Map<String, dynamic> tojson() => {
        'email': email,
        'id': id,
        'name': name,
        'place': place,
      };

  static Users fromJson(Map<String, dynamic> json) => Users(
      email: json['email'],
      id: json['id'],
      name: json['name'],
      place: json['place']);
}
