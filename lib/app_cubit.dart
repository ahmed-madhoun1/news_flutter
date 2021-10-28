import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/app_state.dart';

class AppCubit extends Cubit<AppState> {

  AppCubit() : super(InitAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  /// Change Application Mode (Light, Dark)
  void changeAppMode(){
    isDark = !isDark;
    emit(ChangeModeAppState());
  }

}
