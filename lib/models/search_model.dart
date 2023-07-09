import 'package:shop_app/models/shop_model.dart';

class SearchModel {
  bool? status;
  SearchDataModel? data;

  // SearchModel({this.status, this.data});
  SearchModel.fromJSON(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    data = SearchDataModel.fromJSON(json['data'] ?? {});
  }
}

class SearchDataModel {
  List<ProductModel> seachProducts = [];

  SearchDataModel.fromJSON(Map<String, dynamic> json) {
    json['data'].forEach(
        (element) => seachProducts.add(ProductModel.fromJSON(element)));
    print('oop $seachProducts');
  }
}
