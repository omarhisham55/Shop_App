import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop_app/models/favoritesModel.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import 'cubit/shop_bloc.dart';
import 'cubit/shop_states.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopManager, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopManager manager = ShopManager.shopManager(context);
          return Conditional.single(
              context: context,
              conditionBuilder: (context) => manager.shopModel.data != null,
              widgetBuilder: (context) => ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => favoritesItemBuilder(context,
                      manager.favoritesModel.data.favorites[index].product),
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: const Divider(
                          thickness: 2,
                        ),
                      ),
                  itemCount: manager.favoritesModel.data.favorites.length),
              fallbackBuilder: (context) => fallBackIndicator());
        });
  }
}

Widget favoritesItemBuilder(BuildContext context, Product model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 100.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  height: 100.0,
                  width: width(context, .3),
                ),
                Visibility(
                    visible: model.discount == 0 ? false : true,
                    child: Container(
                      color: ShopColors.errorColor,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          'Discount %'.toUpperCase(),
                          style: TextStyle(
                              color: ShopColors.whiteColor, fontSize: 8.0),
                        ),
                      ),
                    ))
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(model.name.toString(),
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: [
                          Text(
                            '${model.price.round()}',
                            style: TextStyle(
                                color: ShopColors.defaultColor, fontSize: 12.0),
                          ),
                          SizedBox(width: 10.0),
                          Visibility(
                            visible: (model.discount == 0) ? false : true,
                            child: Text(
                              '${model.oldPrice.round()}',
                              style: TextStyle(
                                  color: ShopColors.inActiveColor,
                                  fontSize: 12.0,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                ShopManager.shopManager(context)
                                    .editFavorites(model.id);
                              },
                              icon: ShopManager.shopManager(context)
                                      .fav[model.id]!
                                  ? Icon(Icons.favorite, color: Colors.red)
                                  : Icon(Icons.favorite_border))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
