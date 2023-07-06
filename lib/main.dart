import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/navigation/cubit_nav/navigation_bloc.dart';

import 'navigation/cubit_nav/navigation_states.dart';
import 'screens/cubit_screens/screens_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationManager()),
        BlocProvider(create: (context) => ScreenManager()),
      ],
      child: BlocConsumer<NavigationManager, NavigationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Hello World!'),
              ),
            ),
          );
        }
      ),
    );
  }
}
