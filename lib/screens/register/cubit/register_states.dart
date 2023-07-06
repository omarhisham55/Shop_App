abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class ChangePasswordIconState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class SuccessRegisterState extends RegisterState {}

class ErrorRegisterState extends RegisterState {
  final String error;
  ErrorRegisterState(this.error);
}
