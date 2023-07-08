import 'package:shop_app/models/favoritesModel.dart';

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
