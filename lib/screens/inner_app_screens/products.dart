import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categoryModel.dart';
import 'package:shop_app/models/shop_model.dart';
import 'package:shop_app/screens/inner_app_screens/cubit/shop_bloc.dart';
import 'package:shop_app/screens/inner_app_screens/cubit/shop_states.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/shared/styles/colors.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopManager, ShopStates>(listener: (context, state) {
      if (state is ShopSuccessFavoritesState) {
        if (!state.model.status) {
          shopToast(
              context: context,
              text: state.model.message,
              state: ToastStates.error);
        }
      }
    }, builder: (context, state) {
      ShopManager manager = ShopManager.shopManager(context);
      return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              manager.shopModel.data != null &&
              manager.categoryModel.data != null,
          widgetBuilder: (context) => builderWidget(
              context, manager.shopModel.data!, manager.categoryModel.data!),
          fallbackBuilder: (context) => fallBackIndicator());
    });
  }
}

Widget builderWidget(BuildContext context, ShopDataModel model,
        CategoryDataModel categoryModel) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Categories', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 10.0),
                SizedBox(
                  height: 100.0,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildCategoryItem(context, categoryModel.data[index]),
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 10.0),
                      itemCount: categoryModel.data.length),
                ),
                Text('New Products', style: TextStyle(fontSize: 20.0)),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1 / 1.68,
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              children: List.generate(model.products.length,
                  (index) => buildGridProduct(context, model.products[index])),
            ),
          )
        ],
      ),
    );

Widget buildCategoryItem(BuildContext context, Category model) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 100.0,
          height: 100.0,
        ),
        Container(
            color: Colors.black.withOpacity(.6),
            width: 100.0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                model.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            )),
      ],
    );

Widget buildGridProduct(context, ProductModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 200.0,
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(model.name, maxLines: 2, overflow: TextOverflow.ellipsis),
              Row(
                children: [
                  Text(
                    model.price.round().toString(),
                    style: TextStyle(
                        color: ShopColors.defaultColor, fontSize: 12.0),
                  ),
                  SizedBox(width: 10.0),
                  Visibility(
                    visible: (model.discount == 0) ? false : true,
                    child: Text(
                      model.oldPrice.round().toString(),
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
                      icon: ShopManager.shopManager(context).fav[model.id]!
                          ? Icon(Icons.favorite, color: Colors.red)
                          : Icon(Icons.favorite_border))
                ],
              ),
            ],
          ),
        ),
      ],
    );
