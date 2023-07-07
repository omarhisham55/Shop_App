class SettingsModel {
  late bool? status;
  late SettingsDataModel? data;

  SettingsModel({this.status, this.data});
  SettingsModel.fromJSON(Map<String, dynamic> json) {
    status = json['status'];
    data = SettingsDataModel.fromJSON(json['data']);
  }
}

class SettingsDataModel {
  late String terms;
  late String about;

  SettingsDataModel.fromJSON(Map<String, dynamic> json) {
    terms = json['terms'];
    about = json['about'];
  }
}
