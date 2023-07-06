import 'package:flutter/material.dart';
import 'package:shop_app/screens/login/cubit/login_cubit.dart';
import 'package:shop_app/screens/login/cubit/login_states.dart';
import 'package:shop_app/screens/register/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginManager(),
      child: BlocConsumer<LoginManager, LoginState>(
          listener: (context, state) {},
          builder: (context, state) {
            LoginManager loginManager = LoginManager.loginManager(context);
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: loginManager.formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            formTitle(context, 'Shop Login'),
                            formSubTitle(
                                context, 'login now to browse our hot offers'),
                            const SizedBox(height: 30.0),
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
                                onSubmit: (value) {
                                  if (loginManager.formKey.currentState!
                                      .validate()) {
                                    loginManager.sendLogin(
                                        context,
                                        emailController.text,
                                        passwordController.text);
                                  }
                                },
                                validator: (value) {
                                  if (value!.length < 6) {
                                    return 'Password is too short';
                                  }
                                  return null;
                                },
                                isObscure: loginManager.isVisible,
                                label: 'Password',
                                suffix: IconButton(
                                    onPressed: () =>
                                        loginManager.changePasswordIcon(),
                                    icon: loginManager.passwordIcon)),
                            const SizedBox(height: 30.0),
                            Conditional.single(
                                context: context,
                                conditionBuilder: (context) =>
                                    state is! LoadingLoginState,
                                widgetBuilder: (context) => shopButton(
                                    onPressed: () {
                                      if (loginManager.formKey.currentState!
                                          .validate()) {
                                        loginManager.sendLogin(
                                            context,
                                            emailController.text,
                                            passwordController.text);
                                      }
                                    },
                                    context: context,
                                    isUpperCase: true,
                                    text: 'login'),
                                fallbackBuilder: (context) =>
                                    fallBackIndicator()),
                            const SizedBox(height: 15.0),
                            selectionFormButton(
                                "Don't have an account",
                                () => navigateTo(context, ShopRegisterScreen()),
                                'sign up')
                          ]),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
