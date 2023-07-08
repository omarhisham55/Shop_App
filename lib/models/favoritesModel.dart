class FavoritesModel {
  bool status = false;
  FavoritesDataModel data = FavoritesDataModel.fromJSON({});

  FavoritesModel.fromJSON(Map<String, dynamic> json) {
    status = json['status'];
    data = FavoritesDataModel.fromJSON(json['data']);
  }
}

class FavoritesDataModel {
  List<FavoriteItemModel> favorites = [];
  FavoritesDataModel.fromJSON(Map<String, dynamic> json) {
    if (json['data'] == null) {
      favorites = [];
    } else {
      json['data'].forEach((element) => favorites.add(FavoriteItemModel.fromJSON(element)));
    }
  }
}

class FavoriteItemModel {
  late int id;
  late Product product;

  FavoriteItemModel.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJSON(json['product']);
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String name;
  late String image;
  late String description;
  Product.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
  }
}

class ChangeFavorites {
  bool status = false;
  String message = '';

  ChangeFavorites.fromJSON(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
