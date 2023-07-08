import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/end_points/end_points.dart';
import '../../../shared/network/remote/remote_api.dart';
import 'register_states.dart';

class RegisterManager extends Cubit<RegisterState> {
  RegisterManager() : super(InitialRegisterState());

  static RegisterManager registerManager(context) =>
      BlocProvider.of<RegisterManager>(context);

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

  void userRegister(BuildContext context, String name, String email,
      String password, String number) {
    emit(LoadingRegisterState());
    DioHelper.postData(url: register, data: {
      'name': name,
      'password': password,
      'email': email,
      'phone': number,
    }).then((value) {
      debugPrint('${value.data}');
      shopToast(text: value.data['message'], context: context, state: ToastStates.success);
      Navigator.pop(context);
      emit(SuccessRegisterState());
    }).catchError((e) {
      debugPrint(e.toString());
      emit(ErrorRegisterState(e.toString()));
    });
  }
}
