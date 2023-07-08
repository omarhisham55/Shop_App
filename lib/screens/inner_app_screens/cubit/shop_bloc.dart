import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoryModel.dart';
import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/models/shop_model.dart';
import 'package:shop_app/models/user_model.dart';
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
  Map<int, bool> fav = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: home, token: token).then((value) {
      shopModel = ShopModel.fromJSON(value.data);
      shopModel.data?.products.forEach((element) {
        fav.addAll({element.id: element.inFavorites});
      });
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
      emit(ShopSuccessCategoryState());
    }).catchError((e) {
      debugPrint(e.toString());
      emit(ShopErrorCategoryState());
    });
  }
  ///////////////////////Favorites Page/////////////////////////////////

  late FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(url: favorites, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJSON(value.data);
      emit(ShopSuccessFavoritesState(changeFavoritesModel));
    }).catchError((e) {
      debugPrint(e.toString());
      emit(ShopErrorFavoritesState());
    });
  }

  late ChangeFavorites changeFavoritesModel;
  void editFavorites(int id) {
    fav[id] = !fav[id]!;
    emit(ShopToFavoritesState());
    DioHelper.postData(url: favorites, data: {'product_id': id}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavorites.fromJSON(value.data);
      if (!changeFavoritesModel.status) {
        fav[id] = !fav[id]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessFavoritesState(changeFavoritesModel));
    }).catchError((e) {
      fav[id] = !fav[id]!;
      print(e.toString());
      emit(ShopErrorFavoritesState());
    });
  }
  ///////////////////////Settings Page/////////////////////////////////

  SettingsModel settingsModel = new SettingsModel();

  void getSettings() {
    emit(ShopLoadingSettingsState());
    DioHelper.getData(url: settings).then((value) {
      settingsModel = SettingsModel.fromJSON(value.data);
      // print(settingsModel.data.toString());
      emit(ShopSuccessSettingsState());
    }).catchError((e) {
      debugPrint(e.toString());
      emit(ShopErrorSettingsState());
    });
  }

  UserModel userModel = UserModel.fromJSON({});
  void getProfile() {
    emit(GetProfileLoadingState());
    DioHelper.getData(url: profile, token: token).then((value) {
      userModel = UserModel.fromJSON(value.data);
      print(userModel.data.id.toString());
      print(userModel.status.toString());
      emit(GetProfileSuccessState(userModel));
    }).catchError((e) {
      debugPrint(e.toString());
      emit(GetProfileErrorState());
    });
  }

  void updateUser(String name, String email, String phone) {
    emit(UpdateProfileLoadingState());
    DioHelper.postData(url: updateProfile, token: token, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      userModel = UserModel.fromJSON(value.data);
      print(userModel.data.email.toString());
      print(userModel.status.toString());
      emit(UpdateProfileSuccessState(userModel));
    }).catchError((e) {
      debugPrint(e.toString());
      emit(UpdateProfileErrorState());
    });
  }

  GlobalKey<FormState> formUpdateKey = GlobalKey<FormState>();
}
