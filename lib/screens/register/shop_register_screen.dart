import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/register/cubit/register_cubit.dart';
import 'package:shop_app/screens/register/cubit/register_states.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopRegisterScreen extends StatelessWidget {
  const ShopRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterManager, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
              child: SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              formTitle(context, 'Shop Register'),
              
            ]),
          ))),
        );
      },
    );
  }
}
