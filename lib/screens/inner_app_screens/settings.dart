import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop_app/shared/components/constants.dart';
import '../../shared/components/components.dart';
import 'cubit/shop_bloc.dart';
import 'cubit/shop_states.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phone = TextEditingController();
    return BlocConsumer<ShopManager, ShopStates>(listener: (context, state) {
      if (state is UpdateProfileSuccessState) {
        if (!state.userModel.status) {
          shopToast(
              text: state.userModel.message,
              context: context,
              state: ToastStates.error);
        } else {
          shopToast(
              text: state.userModel.message,
              context: context,
              state: ToastStates.success);
        }
      }
    }, builder: (context, state) {
      ShopManager manager = ShopManager.shopManager(context);
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: manager.formUpdateKey,
              child: Column(
                children: [
                  defaultTextFormField(
                      context: context,
                      controller: name,
                      label: manager.userModel.data.name,
                      prefix: Icon(Icons.person),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter valid Name';
                        }
                        return null;
                      }),
                  const SizedBox(height: 10.0),
                  defaultTextFormField(
                      context: context,
                      controller: email,
                      label: manager.userModel.data.email,
                      prefix: Icon(Icons.mail),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter valid email';
                        }
                        return null;
                      }),
                  const SizedBox(height: 10.0),
                  defaultTextFormField(
                      context: context,
                      controller: phone,
                      label: manager.userModel.data.phone,
                      prefix: Icon(Icons.numbers),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 11) {
                          return 'Enter valid number';
                        }
                        return null;
                      }),
                  const SizedBox(height: 20.0),
                  Conditional.single(
                      context: context,
                      conditionBuilder: (context) =>
                          state is! UpdateProfileLoadingState,
                      widgetBuilder: (context) => shopButton(
                          context: context,
                          onPressed: () {
                            manager.updateUser(
                                name.text, email.text, phone.text);
                          },
                          text: 'Update user info'),
                      fallbackBuilder: (context) => fallBackIndicator())
                ],
              ),
            ),
            Spacer(),
            shopButton(
                context: context,
                onPressed: () {
                  signOut(context);
                },
                text: 'LOGOUT'.toUpperCase())
          ],
        ),
      );
    });
  }
}
