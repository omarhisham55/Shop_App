import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/screens/inner_app_screens/search/cubit/search_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/remote_api.dart';

import '../../../../shared/components/constants.dart';

class SearchManager extends Cubit<SearchStates> {
  SearchManager() : super(InitSearchState());

  static SearchManager searchManager(context) =>
      BlocProvider.of<SearchManager>(context);

  SearchModel? searchModel;

  void getSearsh(String text) {
    emit(LoadingSearchState());
    DioHelper.postData(url: searchProduct, token: token, data: {'text': text})
        .then((value) {
      printFullText('fawzy ${value.data['data']['data'][0]}');
      searchModel = SearchModel.fromJSON(value.data);
      printFullText('fawzy ${searchModel!.status}');
      printFullText('fawzy ${searchModel!.data!.seachProducts}');
      emit(SuccessSearchState());
    }).catchError((e) {
      print(e.toString());
      emit(ErrorSearchState());
    });
  }
}
