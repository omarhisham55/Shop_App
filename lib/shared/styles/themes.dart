import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black)),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
        selectedItemColor: Colors.deepOrange),
    textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black)),
            fontFamily: 'Capriasimo'
            );

ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(333739),
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Color(333739),
            statusBarIconBrightness: Brightness.light),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white)),
    scaffoldBackgroundColor: Color(333739),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(333739),
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
        selectedItemColor: Colors.deepOrange),
    textTheme: TextTheme(
        bodyLarge: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white)),
            fontFamily: 'Capriasimo'
            );
