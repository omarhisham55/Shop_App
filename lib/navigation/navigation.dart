import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/navigation/cubit_nav/navigation_bloc.dart';
import 'package:shop_app/screens/inner_app_screens/search/search.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/local_prefs.dart';
import 'cubit_nav/navigation_states.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationManager, NavigationState>(
        listener: (context, state) {},
        builder: (context, state) {
          NavigationManager nav = NavigationManager.nav(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Shopify'),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, Search());
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
            body: nav.screens[nav.currentNavBarIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: nav.currentNavBarIndex,
              onTap: (index) => nav.setNavBarIndex(index),
              items: nav.bottomNavBarItems,
            ),
          );
        });
  }
}
