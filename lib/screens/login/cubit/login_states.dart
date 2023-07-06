abstract class LoginState {}

class InitialLoginState extends LoginState {}

class ChangePasswordIconState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {}

class ErrorLoginState extends LoginState {
  final error;
  ErrorLoginState(this.error);
}
