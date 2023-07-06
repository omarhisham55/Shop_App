import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/login/cubit/login_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/end_points/end_points.dart';
import 'package:shop_app/shared/network/remote/remote_api.dart';

class LoginManager extends Cubit<LoginState> {
  LoginManager() : super(InitialLoginState());

  static LoginManager loginManager(context) =>
      BlocProvider.of<LoginManager>(context);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

  void sendLogin(BuildContext context, String email, String password) {
    emit(LoadingLoginState());
    DioHelper.postData(url: login, data: {'email': email, 'password': password})
        .then((value) {
      debugPrint('${value.data}');
      ScaffoldMessenger.of(context)
          .showSnackBar(shopSnackBar(value.data['message']));
      emit(SuccessLoginState());
    }).catchError((e) {
      debugPrint(e.toString());
      emit(ErrorLoginState(e.toString()));
    });
  }
}
