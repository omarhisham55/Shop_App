import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/register/cubit/register_cubit.dart';
import 'package:shop_app/screens/register/cubit/register_states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController numberController = TextEditingController();
    return BlocProvider(
      create: (context) => RegisterManager(),
      child: BlocConsumer<RegisterManager, RegisterState>(
        listener: (context, state) {
          if (state is SuccessRegisterState) {
            if(state.register.status){
              shopToast(text: state.register.message, context: context, state: ToastStates.success);
              Navigator.pop(context);
            }else{
              shopToast(text: state.register.message, context: context, state: ToastStates.error);
            }
          }
          if (state is ErrorRegisterState) {
            shopToast(
                text: state.error, context: context, state: ToastStates.error);
          }
        },
        builder: (context, state) {
          RegisterManager registerManager =
              RegisterManager.registerManager(context);
          return Scaffold(
            body: Center(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: registerManager.formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      formTitle(context, 'Register'),
                      const SizedBox(height: 30.0),
                      defaultTextFormField(
                          context: context,
                          controller: nameController,
                          prefix: Icon(Icons.account_circle_rounded),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter your username';
                            }
                            return null;
                          },
                          label: 'Username'),
                      const SizedBox(height: 20.0),
                      defaultTextFormField(
                          context: context,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          prefix: Icon(Icons.email),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter valid email';
                            }
                            return null;
                          },
                          label: 'Email'),
                      const SizedBox(height: 20.0),
                      defaultTextFormField(
                          context: context,
                          controller: passwordController,
                          prefix: Icon(Icons.lock),
                          validator: (value) {
                            if (value!.length < 6) {
                              return 'Password is too short';
                            }
                            return null;
                          },
                          isObscure: registerManager.isVisible,
                          label: 'Password',
                          suffix: IconButton(
                              onPressed: () =>
                                  registerManager.changePasswordIcon(),
                              icon: registerManager.passwordIcon)),
                      const SizedBox(height: 20.0),
                      defaultTextFormField(
                          context: context,
                          controller: numberController,
                          keyboardType: TextInputType.number,
                          prefix: Icon(Icons.numbers),
                          validator: (value) {
                            if (value!.length < 11) {
                              return 'Invalid number';
                            }
                            return null;
                          },
                          onSubmit: (value) {
                            if (registerManager.formKey.currentState!
                                .validate()) {
                              registerManager.userRegister(
                                  context,
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  numberController.text);
                            }
                          },
                          label: 'Phone number'),
                      const SizedBox(height: 30.0),
                      Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              state is! LoadingRegisterState,
                          widgetBuilder: (context) => shopButton(
                              context: context,
                              onPressed: () {
                                if (registerManager.formKey.currentState!
                                    .validate()) {
                                  registerManager.userRegister(
                                      context,
                                      nameController.text,
                                      emailController.text,
                                      passwordController.text,
                                      numberController.text);
                                }
                              },
                              text: 'register',
                              isUpperCase: true),
                          fallbackBuilder: (context) => fallBackIndicator()),
                      selectionFormButton("Already have an acoount",
                          () => Navigator.pop(context), 'login')
                    ]),
              ),
            ))),
          );
        },
      ),
    );
  }
}
