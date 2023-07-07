class CategoryModel {
  late bool? status;
  late CategoryDataModel? data;

  CategoryModel({this.status, this.data});

  CategoryModel.fromJSON(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryDataModel.fromJSON(json['data']);
  }
}

class CategoryDataModel {
  late int currentPage;
  List<Map<String, dynamic>> data = [];

  CategoryDataModel.fromJSON(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) => data.add(element));
  }
}

class Category {
  late int id;
  late String name;
  late String image;

  Category.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
