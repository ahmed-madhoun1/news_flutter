import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/modules/latest_news/latest_news_screen.dart';
import 'package:news_flutter/modules/saved_news/saved_news_screen.dart';
import 'package:news_flutter/modules/search_news/search_news_screen.dart';
import 'package:news_flutter/modules/settings/settings_screen.dart';

import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitNewsState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int bnbCurrentIndex = 0;
  List<Widget> screens = const [LatestNewsScreen(), SearchNewsScreen(), SavedNewsScreen(), SettingsScreen()];

  List<BottomNavigationBarItem> bnbItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.featured_play_list_outlined), label: 'Latest'),
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    const BottomNavigationBarItem(icon: Icon(Icons.save_outlined), label: 'Saved'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  /// Change selected item index in [BottomNavigationBar]
  void changeBnbItem(int index) {
    bnbCurrentIndex = index;
    emit(ChangeBottomNavigationNewsState());
  }

}
