import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_states.dart';

class NavigationManager extends Cubit<NavigationState> {
  NavigationManager() : super(InitialState());

  // static NavigationManager nav(context) =>
  //     BlocProvider.of<NavigationManager>(context);

  // int currentNavBarIndex = 0;

  // void setNavBarIndex(int index) {
  //   currentNavBarIndex = index;
  //   emit(NavBarIndexChanged());
  // }

  // List<String> navTitles = ['Tasks', 'Done', 'Archive'];
  // List<StatelessWidget> screens = const [
    
  // ];
}