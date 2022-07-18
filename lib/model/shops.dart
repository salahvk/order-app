class Shops {
  String shopName;
  // String id;
  Shops({
    required this.shopName,
    //  required this.id
  });

  Map<String, dynamic> tojson() => {
        'shopName': shopName,
      };

  static Shops fromJson(Map<String, dynamic> json) => Shops(
        shopName: json['shopName'],
        //  id: json['id']
      );
}
