import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/login/cubit/login_states.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/remote_api.dart';

class LoginManager extends Cubit<LoginState> {
  LoginManager() : super(InitialLoginState());

  static LoginManager loginManager(context) =>
      BlocProvider.of<LoginManager>(context);

  Icon passwordIcon = Icon(Icons.remove_red_eye_rounded);
  bool isVisible = true;
  void changePasswordIcon() {
    if (isVisible) {
      passwordIcon = Icon(Icons.remove_red_eye_outlined);
      isVisible = false;
    } else {
      passwordIcon = Icon(Icons.remove_red_eye_rounded);
      isVisible = true;
    }
    emit(ChangePasswordIconState());
  }

  void sendLogin(email, password) {
    emit(LoadingLoginState());
    DioHelper.postData(url: login, data: {'email': email, 'password': password})
        .then((value) {
      debugPrint(value.data);
      emit(SuccessLoginState());
    }).catchError((e) {
      emit(ErrorLoginState(e.toString()));
    });
  }
}
