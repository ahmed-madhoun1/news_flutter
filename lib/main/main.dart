import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_flutter/main/app_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_cubit.dart';
import 'package:news_flutter/layout/news_layout/news_layout.dart';
import 'package:news_flutter/main/app_state.dart';
import 'package:news_flutter/models/article.dart';
import 'package:news_flutter/modules/drawer/drawer_screen.dart';
import 'package:news_flutter/shared/components/components.dart';
import 'package:news_flutter/shared/network/local/cache_helper.dart';
import 'package:news_flutter/shared/network/remote/dio_helper.dart';
import 'package:news_flutter/shared/styles/themes.dart';

void main() async {
  /// Mean it will finish all the operation then execute runApp Function
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter<Article>(ArticleAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter<Source>(SourceAdapter());
  }
  await Hive.openBox<Article>('articles');
  await Hive.openBox<Source>('sources');
  bool? isDark = CacheHelper.getBool(key: 'isDark');
  runApp(MainApp(isDark: isDark));
}

class MainApp extends StatelessWidget {
  final isDark;

  const MainApp({Key? key, required this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()
              ..delayedSplashScreen(
                  context: context,
                  splashScreen: splashScreen(),
                  homeScreen: Stack(
                    children: const [DrawerScreen(), NewsLayout()],
                  ))
              ..changeAppMode(isDarkShared: isDark)),
        BlocProvider(
            create: (context) => NewsCubit()
              ..checkInternetConnection()
              ..getLatestNews()
              ..getSavedNews()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme(),
              darkTheme: darkTheme(),
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: SafeArea(
                child: Scaffold(body: AppCubit.get(context).screen),
              ));
        },
      ),
    );
  }
}
