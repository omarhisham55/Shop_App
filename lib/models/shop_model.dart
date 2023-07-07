class ShopModel {
  late bool? status;
  late ShopDataModel? data;

  ShopModel({this.status, this.data});

  ShopModel.fromJSON(Map<String, dynamic> json) {
    status = json['status'];
    data = ShopDataModel.fromJSON(json['data']);
  }
}

class ShopDataModel {
  List<Map<String, dynamic>> banners = [];
  List<Map<String, dynamic>> products = [];

  ShopDataModel.fromJSON(Map<String, dynamic> json) {
    json['banners'].forEach((element) => banners.add(element));
    json['products'].forEach((element) => products.add(element));
  }
}

class BannerModel {
  late int id;
  late int image;

  BannerModel.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String name;
  late String image;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
