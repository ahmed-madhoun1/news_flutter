import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:news_flutter/layout/news_layout/news_layout.dart';
import 'package:news_flutter/shared/network/remote/dio_helper.dart';

void main() {
  DioHelper.init();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        indicatorColor: colorFromHex('FFEC3C36'),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          actionsIconTheme: const IconThemeData(color: Colors.black),
          elevation: 0.0,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 24.0,
          ),
          toolbarHeight: 80.0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.grey[400],
              statusBarIconBrightness: Brightness.light),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: colorFromHex('F9F9F9'),
          selectedItemColor: colorFromHex('FFEC3C36'),
          unselectedItemColor: colorFromHex('FFAAAAAA'),
        )),
    home: const NewsLayout(),
  ));
}
