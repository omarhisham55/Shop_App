import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoryModel.dart';
import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/models/shop_model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/remote_api.dart';
import '../../../models/settingsModel.dart';
import 'shop_states.dart';

class ShopManager extends Cubit<ShopStates> {
  ShopManager() : super(ShopInitialState());

  static ShopManager shopManager(context) =>
      BlocProvider.of<ShopManager>(context);

///////////////////////Product Page/////////////////////////////////

  ShopModel shopModel = new ShopModel();

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: home, token: token).then((value) {
      shopModel = ShopModel.fromJSON(value.data);
      printFullText('${shopModel.data!.banners.length}');
      emit(ShopSuccessHomeDataState());
    }).catchError((e) {
      debugPrint(e.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  ///////////////////////Categories Page/////////////////////////////////

  CategoryModel categoryModel = new CategoryModel();

  void getCategory() {
    emit(ShopLoadingCategoryState());
    DioHelper.getData(url: categories).then((value) {
      categoryModel = CategoryModel.fromJSON(value.data);
      print(categoryModel.data?.data.toString());
      emit(ShopSuccessCategoryState());
    }).catchError((e) {
      debugPrint(e.toString());
      emit(ShopErrorCategoryState());
    });
  }
  ///////////////////////Favorites Page/////////////////////////////////
  
  FavoritesModel favoritesModel = new FavoritesModel();

  void getFavorites() {
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(url: favorites, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJSON(value.data);
      print(favoritesModel.data.toString());
      emit(ShopSuccessFavoritesState());
    }).catchError((e) {
      debugPrint(e.toString());
      emit(ShopErrorFavoritesState());
    });
  }
  ///////////////////////Settings Page/////////////////////////////////
  
  SettingsModel settingsModel = new SettingsModel();

  void getSettings() {
    emit(ShopLoadingSettingsState());
    DioHelper.getData(url: settings).then((value) {
      settingsModel = SettingsModel.fromJSON(value.data);
      print(settingsModel.data.toString());
      emit(ShopSuccessSettingsState());
    }).catchError((e) {
      debugPrint(e.toString());
      emit(ShopErrorSettingsState());
    });
  }
}
