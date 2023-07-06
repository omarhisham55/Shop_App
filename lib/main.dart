import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/navigation/cubit_nav/navigation_bloc.dart';
import 'package:shop_app/screens/boarding/boarding_screen.dart';
import 'package:shop_app/screens/login/cubit/login_cubit.dart';
import 'package:shop_app/screens/login/shop_login_screen.dart';
import 'package:shop_app/screens/register/cubit/register_cubit.dart';
import 'package:shop_app/shared/network/remote/remote_api.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'navigation/cubit_nav/navigation_states.dart';
import 'screens/boarding/cubit/boarding_bloc.dart';
import 'shared/bloc_observer/bloc_observer.dart';
import 'shared/network/local/local_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await SharedPrefs.init();

  bool isDark = SharedPrefs.getTheme(key: 'isDark');
  bool onBoarding = SharedPrefs.getSharedData(key: 'onBoarding');

  runApp(MainApp(appTheme: isDark, onBoarding: onBoarding));
}

class MainApp extends StatelessWidget {
  final bool? appTheme;
  final bool? onBoarding;
  const MainApp({super.key, this.appTheme, this.onBoarding});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                NavigationManager()..changeTheme(isDark: appTheme)),
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
              home: (onBoarding ?? false) ? ShopLoginScreen() : BoardingScreen(),
            );
          }),
    );
  }
}
