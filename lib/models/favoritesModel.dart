class FavoritesModel {
  late bool? status;
  late FavoritesDataModel? data;

  FavoritesModel({this.status, this.data});
  FavoritesModel.fromJSON(Map<String, dynamic> json) {
    status = json['status'];
    data = FavoritesDataModel.fromJSON(json['data']);
  }
}

class FavoritesDataModel {
  List<Map<String, dynamic>> favorites = [];
  FavoritesDataModel.fromJSON(Map<String, dynamic> json) {
    if (json['data'] == null) {
      favorites = [];
    } else {
      json['data'].forEach((element) => favorites.add(element));
    }
  }
}
