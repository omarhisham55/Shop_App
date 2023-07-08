import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/inner_app_screens/categories.dart';
import 'package:shop_app/screens/inner_app_screens/favourites.dart';
import 'package:shop_app/screens/inner_app_screens/products.dart';
import 'package:shop_app/screens/inner_app_screens/settings.dart';
import '../../shared/network/local/local_prefs.dart';
import 'navigation_states.dart';

class NavigationManager extends Cubit<NavigationState> {
  NavigationManager() : super(InitialState());

  static NavigationManager nav(context) =>
      BlocProvider.of<NavigationManager>(context);

  bool isDarkTheme = false;
  void changeTheme({bool? isDark}) {
    if (isDark != null) {
      isDarkTheme = isDark;
      emit(ChangeThemeState());
    } else {
      isDarkTheme = !isDarkTheme;
      SharedPrefs.setTheme(key: 'isDark', value: isDarkTheme)
          .then((value) => emit(ChangeThemeState()));
    }
  }

  int currentNavBarIndex = 0;

  void setNavBarIndex(int index) {
    currentNavBarIndex = index;
    emit(NavBarIndexChanged());
  }

  List<StatelessWidget> screens = const [
    Products(),
    Categories(),
    Favourites(),
    Settings()
  ];
  List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
  ];

  void openSnackBar() {
    emit(SnackBarState());
  }
}
