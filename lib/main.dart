import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/navigation/cubit_nav/navigation_bloc.dart';
import 'package:shop_app/screens/boarding_screen.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'navigation/cubit_nav/navigation_states.dart';
import 'screens/cubit_screens/screens_bloc.dart';
import 'shared/bloc_observer/bloc_observer.dart';
import 'shared/network/local/local_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await SharedPrefs.init();

  bool isDark = SharedPrefs.getTheme(key: 'isDark');

  runApp(MainApp(appTheme: isDark));
}

class MainApp extends StatelessWidget {
  final bool? appTheme;
  const MainApp({super.key, this.appTheme});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                NavigationManager()..changeTheme(isDark: appTheme)),
        BlocProvider(create: (context) => ScreenManager()),
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
              home: BoardingScreen(),
            );
          }),
    );
  }
}
