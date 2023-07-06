import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/screens/login/cubit/login_states.dart';
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

  late UserModel userModel;

  void sendLogin(BuildContext context, String email, String password) {
    emit(LoadingLoginState());
    DioHelper.postData(url: login, data: {'email': email, 'password': password})
        .then((value) {
      userModel = UserModel.fromJSON(value.data);
      emit(SuccessLoginState(userModel));
    }).catchError((e) {
      debugPrint(e.toString());
      emit(ErrorLoginState(e.toString()));
    });
  }
}
