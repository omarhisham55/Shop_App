import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:shop_app/models/shop_model.dart';
import 'package:shop_app/screens/inner_app_screens/search/cubit/search_cubit.dart';
import 'package:shop_app/screens/inner_app_screens/search/cubit/search_states.dart';

import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchText = TextEditingController();
    return BlocConsumer<SearchManager, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchManager manager = SearchManager.searchManager(context);
          return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFormField(
                        context: context,
                        controller: searchText,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter text to search';
                          }
                          return null;
                        },
                        onSubmit: (value) {
                          manager.getSearsh(searchText.text);
                        },
                        prefix: Icon(Icons.search),
                        label: 'Search'),
                    if (state is LoadingSearchState)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0),
                        child: LinearProgressIndicator(),
                      ),
                    Expanded(
                      child: Conditional.single(
                          context: context,
                          conditionBuilder: (context) =>
                              manager.searchModel != null,
                          widgetBuilder: (context) => ListView.separated(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) => searchBuilder(
                                  context,
                                  manager
                                      .searchModel!.data!.seachProducts[index]),
                              separatorBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: const Divider(
                                      thickness: 2,
                                    ),
                                  ),
                              itemCount: manager
                                  .searchModel!.data!.seachProducts.length),
                          fallbackBuilder: (context) =>
                              Center(child: Text('Search for something...'))),
                    ),
                  ],
                ),
              ));
        });
  }
}

Widget searchBuilder(BuildContext context, ProductModel model) => Padding(
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
                          // const Spacer(),
                          // IconButton(
                          //     onPressed: () {
                          //       ShopManager.shopManager(context)
                          //           .editFavorites(model.id);
                          //     },
                          //     icon: ShopManager.shopManager(context)
                          //             .fav[model.id]!
                          //         ? Icon(Icons.favorite, color: Colors.red)
                          //         : Icon(Icons.favorite_border))
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
