class UserModel {
  bool status = false;
  String message = '';
  UserDataModel data = UserDataModel.fromJSON({});

  UserModel.fromJSON(Map<String, dynamic> json) {
    status = json["status"] ?? false;
    message = json["message"] ?? '';
    data = UserDataModel.fromJSON(json['data'] ?? {});
  }
}

class UserDataModel {
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credits;
  late String token;

  // UserDataModel({required this.id, required this.name, required this.email, required this.phone, required this.image,
  //     required this.points, required this.credits, required this.token});

  UserDataModel.fromJSON(Map<String, dynamic> json) {
    id = json["id"] ?? 0;
    name = json["name"] ?? '';
    email = json["email"] ?? '';
    phone = json["phone"] ?? '';
    image = json["image"] ?? '';
    points = json["points"] ?? 0;
    credits = json["credits"] ?? 0;
    token = json["token"] ?? '';
  }
}
