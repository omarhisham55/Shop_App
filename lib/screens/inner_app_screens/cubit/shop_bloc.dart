import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop)model.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/remote_api.dart';
import 'shop_states.dart';

class ShopManager extends Cubit<ShopStates> {
  ShopManager() : super(ShopInitialState());

  static ShopManager shopManager(context) =>
      BlocProvider.of<ShopManager>(context);

  late ShopModel shopModel;

  Future<void> getHomeData() async {
    print('polala ${shopModel}');
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: home, token: token).then((value) {
      shopModel = ShopModel.fromJSON(value.data);
      printFullText('${shopModel.data.banners.length}');
      emit(ShopSuccessHomeDataState(shopModel));
    }).catchError((e) {
      debugPrint(e.toString());
      emit(ShopErrorHomeDataState(e.toString()));
    });
  }
}
