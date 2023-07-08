import 'package:shop_app/models/favoritesModel.dart';

import '../../../models/user_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingCategoryState extends ShopStates {}

class ShopSuccessCategoryState extends ShopStates {}

class ShopErrorCategoryState extends ShopStates {}

class ShopLoadingFavoritesState extends ShopStates {}

class ShopSuccessFavoritesState extends ShopStates {
  final ChangeFavorites model;

  ShopSuccessFavoritesState(this.model);
}

class ShopErrorFavoritesState extends ShopStates {}

class ShopLoadingSettingsState extends ShopStates {}

class ShopSuccessSettingsState extends ShopStates {}

class ShopErrorSettingsState extends ShopStates {}

class ShopToFavoritesState extends ShopStates {}

class GetProfileLoadingState extends ShopStates {}

class GetProfileSuccessState extends ShopStates {
  UserModel userModel;
  GetProfileSuccessState(this.userModel);
}

class GetProfileErrorState extends ShopStates {}

class UpdateProfileLoadingState extends ShopStates {}

class UpdateProfileSuccessState extends ShopStates {
  UserModel userModel;
  UpdateProfileSuccessState(this.userModel);
}

class UpdateProfileErrorState extends ShopStates {}
