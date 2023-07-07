import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import '../../shared/components/components.dart';
import 'cubit/shop_bloc.dart';
import 'cubit/shop_states.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopManager, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopManager manager = ShopManager.shopManager(context);
          return Conditional.single(
              context: context,
              conditionBuilder: (context) => manager.settingsModel.data != null,
              widgetBuilder: (context) => Center(
                    child: Text('success'),
                  ),
              fallbackBuilder: (context) => fallBackIndicator());
        });
  }
}