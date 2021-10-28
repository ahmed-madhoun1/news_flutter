import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_flutter/app_cubit.dart';
import 'package:news_flutter/app_state.dart';
import 'package:news_flutter/layout/news_layout/news_layout.dart';
import 'package:news_flutter/shared/network/remote/dio_helper.dart';

void main() {
  DioHelper.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              cardColor: HexColor('FFFFFF'),
              indicatorColor: HexColor('FFEC3C36'),
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
                backgroundColor: HexColor('F9F9F9'),
                selectedItemColor: HexColor('FFEC3C36'),
                unselectedItemColor: HexColor('FFAAAAAA'),
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                    color: HexColor('000000'),
                  ),
                  subtitle1: TextStyle(
                    fontSize: 12.0,
                    color: HexColor('7f8c8d'),
                  )),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('1e272e'),
              cardColor: HexColor('353b48'),
              indicatorColor: HexColor('d2dae2'),
              appBarTheme: AppBarTheme(
                backgroundColor: HexColor('1e272e'),
                actionsIconTheme: const IconThemeData(color: Colors.white),
                elevation: 0.0,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
                toolbarHeight: 80.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('485460'),
                    statusBarIconBrightness: Brightness.light),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor('485460'),
                selectedItemColor: HexColor('FFEC3C36'),
                unselectedItemColor: HexColor('d2dae2'),
              ),
              textTheme: TextTheme(
                  bodyText1: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.0,
                    color: HexColor('FFFFFF'),
                  ),
                  subtitle1: TextStyle(
                    fontSize: 12.0,
                    color: HexColor('DCDCDC'),
                  )),
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const NewsLayout(),
          );
        },
      ),
    );
  }
}
