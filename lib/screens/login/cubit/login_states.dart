import 'package:shop_app/models/user_model.dart';

abstract class LoginState {}

class InitialLoginState extends LoginState {}

class ChangePasswordIconState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final UserModel userModel;

  SuccessLoginState(this.userModel);
}

class ErrorLoginState extends LoginState {
  final String error;
  ErrorLoginState(this.error);
}
