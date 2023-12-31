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
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  ShopDataModel.fromJSON(Map<String, dynamic> json) {
    json['banners']
        .forEach((element) => banners.add(BannerModel.fromJSON(element)));
    json['products']
        .forEach((element) => products.add(ProductModel.fromJSON(element)));
  }
}

class BannerModel {
  late int id;
  late String image;

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
    id = json['id'] ?? 0;
    price = json['price'] ?? 0;
    oldPrice = json['old_price'] ?? 0;
    discount = json['discount'] ?? 0;
    name = json['name'] ?? '';
    image = json['image'] ?? '';
    inFavorites = json['in_favorites'] ?? false;
    inCart = json['in_cart'] ?? false;
  }
}
