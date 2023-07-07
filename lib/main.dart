import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/navigation/cubit_nav/navigation_bloc.dart';
import 'package:shop_app/screens/boarding/boarding_screen.dart';
import 'package:shop_app/screens/inner_app_screens/cubit/shop_bloc.dart';
import 'package:shop_app/screens/inner_app_screens/products.dart';
import 'package:shop_app/screens/login/cubit/login_cubit.dart';
import 'package:shop_app/screens/login/shop_login_screen.dart';
import 'package:shop_app/screens/register/cubit/register_cubit.dart';
import 'package:shop_app/shared/network/remote/remote_api.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'navigation/cubit_nav/navigation_states.dart';
import 'navigation/navigation.dart';
import 'screens/boarding/cubit/boarding_bloc.dart';
import 'shared/bloc_observer/bloc_observer.dart';
import 'shared/components/constants.dart';
import 'shared/network/local/local_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await SharedPrefs.init();

  Widget startWidget;

  bool isDark = SharedPrefs.getTheme(key: 'isDark');
  bool onBoarding = SharedPrefs.getSharedData(key: 'onBoarding');
  token = SharedPrefs.getSharedData(key: 'token').toString();
  print('shakalala $token');
  if (onBoarding == true) {
    if (token != null.toString()) {
      startWidget = const Navigation();
    } else {
      startWidget = const ShopLoginScreen();
    }
  } else {
    startWidget = BoardingScreen();
  }
  runApp(MainApp(appTheme: isDark, startWidget: startWidget));
}

class MainApp extends StatelessWidget {
  final bool? appTheme;
  final Widget? startWidget;
  const MainApp({super.key, this.appTheme, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                NavigationManager()..changeTheme(isDark: appTheme)),
        BlocProvider(create: (context) => ShopManager()..getHomeData())
      ],
      child: BlocConsumer<NavigationManager, NavigationState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: (NavigationManager.nav(context).isDarkTheme)
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: startWidget,
            );
          }),
    );
  }
}
