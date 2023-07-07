import 'package:shop_app/models/shop)model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {
  ShopModel model;
  ShopSuccessHomeDataState(this.model);
}

class ShopErrorHomeDataState extends ShopStates {
  final String error;
  ShopErrorHomeDataState(this.error);
}
