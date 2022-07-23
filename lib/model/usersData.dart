class Users {
  String id;
  String name;
  String? place;
  Users({
    required this.id,
    required this.name,
    this.place,
  });

  Map<String, dynamic> tojson() => {
        'id': id,
        'userName': name,
        'from': place,
      };

  static Users fromJson(Map<String, dynamic> json) =>
      Users(id: json['id'], name: json['name'], place: json['place']);
}
