import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:news_flutter/layout/news_layout/news_layout.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
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
