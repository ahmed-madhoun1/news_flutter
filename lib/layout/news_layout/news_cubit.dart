import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/modules/latest_news/latest_news_screen.dart';
import 'package:news_flutter/modules/saved_news/saved_news_screen.dart';
import 'package:news_flutter/modules/settings/settings_screen.dart';
import 'package:news_flutter/shared/components/constants.dart';
import 'package:news_flutter/shared/network/remote/dio_helper.dart';
import 'news_states.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitNewsState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int bnbCurrentIndex = 0;
  List<Widget> screens = const [LatestNewsScreen(), SavedNewsScreen(), SettingsScreen()];

  /// Latest News
  List<dynamic> latestNews = [];

  List<BottomNavigationBarItem> bnbItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.featured_play_list_outlined), label: 'Latest News'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.save_outlined), label: 'Saved News'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  /// Change selected item index in [BottomNavigationBar]
  void changeBnbItem(int index) {
    bnbCurrentIndex = index;
    emit(ChangeBottomNavigationNewsState());
  }

  /// Get latest news
  void getLatestNews() {
    emit(GetLatestNewsLoadingNewsState());
    DioHelper.getData(url: latestNewsUrl, query: {'country': 'us', 'category': 'business', 'apiKey': apiKey})
      .then((response) => {
        latestNews = response.data['articles'],
        emit(GetLatestNewsSuccessNewsState())
      }).catchError((error) => {
        emit(GetLatestNewsErrorNewsState(error.toString())),
      });
  }
}
