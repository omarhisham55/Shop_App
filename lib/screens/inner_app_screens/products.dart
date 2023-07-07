import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/inner_app_screens/cubit/shop_bloc.dart';
import 'package:shop_app/screens/inner_app_screens/cubit/shop_states.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop_app/shared/components/components.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopManager, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopManager manager = ShopManager.shopManager(context);
          return Conditional.single(
              context: context,
              conditionBuilder: (context) => manager.shopModel.data != null,
              widgetBuilder: (context) => Center(
                    child: Text('success'),
                  ),
              fallbackBuilder: (context) => fallBackIndicator());
        });
  }
}
