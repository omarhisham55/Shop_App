import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import '../../shared/components/components.dart';
import 'cubit/shop_bloc.dart';
import 'cubit/shop_states.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopManager, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopManager manager = ShopManager.shopManager(context);
          return ListView.separated(
              itemBuilder: (context, index) => categoryBuilder(
                  context, manager.categoryModel.data!.data[index]),
              separatorBuilder: (context, index) => const Divider(
                    thickness: 2,
                  ),
              itemCount: manager.categoryModel.data!.data.length);
        });
  }
}

Widget categoryBuilder(BuildContext context, Map<String, dynamic> model) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(children: [
        Image(
          image: NetworkImage(model['image']),
          width: width(context, .3),
        ),
        Text(model['name']),
        const Spacer(),
        Icon(Icons.chevron_right)
      ]),
    );
