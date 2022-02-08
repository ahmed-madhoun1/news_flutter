import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/app_state.dart';
import 'package:news_flutter/shared/components/components.dart';
import 'package:news_flutter/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;
  late Widget screen;

  /// Change Application Mode (Light, Dark)
  void changeAppMode({isDarkShared}) {
    if(isDarkShared != null){
      isDark = isDarkShared;
      emit(ChangeModeAppState());
    }else{
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((value) => {
        emit(ChangeModeAppState()),
      });
    }
  }

  /// Show splash screen and delay for 5 sec and then show home screen
  void delayedSplashScreen({
    required BuildContext context,
    required Widget splashScreen,
    required Widget homeScreen
  }){
    screen = splashScreen;
    emit(SetSplashScreenAppState());
    Future.delayed(const Duration(seconds: 5)).then((value) => {
      screen = homeScreen,
      emit(SetHomeScreenAppState()),
    });
  }
  
}
