import 'dart:convert';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/modules/latest_news/latest_news_screen.dart';
import 'package:news_flutter/modules/saved_news/saved_news_screen.dart';
import 'package:news_flutter/modules/search/search_screen.dart';
import 'package:news_flutter/shared/components/constants.dart';
import 'package:news_flutter/shared/network/remote/dio_helper.dart';
import 'news_states.dart';
import 'package:news_flutter/models/article.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitNewsState());

  static NewsCubit get(context) => BlocProvider.of(context);

  bool drawerOpened = false;
  int bnbCurrentIndex = 0;
  bool isInternetConnected = false;
  List<Widget> screens = [
    const LatestNewsScreen(),
    SearchScreen(),
    const SavedNewsScreen(),
  ];

  /// Latest News
  List<dynamic> latestNews = [];

  /// Searched News
  List<dynamic> searchedNews = [];

  /// Saved News
  List<dynamic> savedNews = [];

  List<BottomNavigationBarItem> bnbItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.featured_play_list_outlined), label: 'Latest News'),
    const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.save_outlined), label: 'Saved News'),
  ];

  /// Check internet connection
  void checkInternetConnection() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {
        isInternetConnected = true;
        emit(InternetConnected());
      } else {
        isInternetConnected = false;
        emit(InternetNotConnected());
      }
    });
  }

  /// Get latest news
  void getLatestNews([String category = generalCategory]) {
    emit(GetLatestNewsLoadingNewsState());

    /// Check internet connection
    Connectivity().checkConnectivity().then((connectivityResult) => {
          if (connectivityResult == ConnectivityResult.wifi ||
              connectivityResult == ConnectivityResult.mobile)
            {
              /// If internet is connected it will get the data from api and cache it in its own category
              DioHelper.getData(
                      url: latestNewsUrl,
                      query: {'category': category, 'apiKey': apiKey})
                  .then((response) => {
                        /// Save response to its own cache category
                        APICacheManager()
                            .addCacheData(APICacheDBModel(
                                key: category, syncData: response.toString()))
                            .then((value) => {
                                  debugPrint(
                                      '*****| Data Cached Successfully |*****'),
                                  debugPrint(
                                      '*****| Read Done From Response |*****'),
                                  latestNews = response.data['articles'],
                                  emit(GetLatestNewsSuccessNewsState()),
                                })
                            .catchError((error) => {
                                  emit(GetLatestNewsErrorNewsState(
                                      error.toString())),
                                })
                      }),
            }
          else
            {
              /// If internet is not connected it will get the data from its own cache category
              /// Check if the cache Key is exist to get cached data from it
              APICacheManager().isAPICacheKeyExist(category).then((value) => {
                    if (value)
                      {
                        /// Get cached data from cache key
                        APICacheManager()
                            .getCacheData(category)
                            .then((value) => {
                                  debugPrint(
                                      '*****| Read Done From Cache |*****'),
                                  latestNews = List.from(
                                      jsonDecode(value.syncData)['articles']),
                                  emit(GetLatestNewsSuccessNewsState()),
                                })
                            .catchError((error) => {
                                  emit(GetLatestNewsErrorNewsState(
                                      error.toString())),
                                }),
                      }
                  }),
            }
        });
  }

  /// Get Searched News

  void getSearchedNews({required String searchValue}) {
    emit(GetSearchedNewsLoadingNewsState());
    DioHelper.getData(
            url: everythingNewsUrl, query: {'q': searchValue, 'apiKey': apiKey})
        .then((response) => {
              searchedNews = response.data['articles'],
              emit(GetSearchedNewsSuccessNewsState())
            })
        .catchError((error) => {
              emit(GetSearchedNewsErrorNewsState(error.toString())),
            });
  }

  /// Get Saved News From Local Database
  void getSavedNews() {
    emit(GetSavedNewsLoadingNewsState());
    savedNews = [];
    Article.getArticleBox().values.toList().cast<Article>().forEach((element) {
      savedNews.add(element.toMap());
    });
    emit(GetSavedNewsSuccessNewsState());
  }

  /// Delete Saved Article From Local Database
  void deleteSavedArticle({required BuildContext context, required int index}) {
    Article.getArticleBox()
        .deleteAt(index)
        .then((value) => {
              /// Get saved news after deleting to refresh list
              getSavedNews(),
              debugPrint('*****| Article Deleted From Local Database |*****'),
            })
        .catchError((error) {
      debugPrint('*****| ${error.toString()} |*****');
    });
  }

  /// Save The Article To Local Database
  void saveArticle({required BuildContext context, required Map article}) {
    Article.getArticleBox()
        .add(Article.fromMap(article))
        .then((value) => {
              /// Get saved news after adding to refresh list
              getSavedNews(),
              debugPrint('*****| Article Saved To Local Database |*****'),
            })
        .catchError((error) {
      debugPrint('*****| ${error.toString()} |*****');
    });
  }

  /// Change selected item index in [BottomNavigationBar]
  void changeBnbItem(int index) {
    bnbCurrentIndex = index;
    emit(ChangeBottomNavigationNewsState());
  }

  /// Change Drawer State
  void changeDrawerState() {
    drawerOpened = !drawerOpened;
    emit(ChangeDrawerNavigationNewsState());
  }

  /// Change screen scale when drawer opened or closed
  Matrix4 changeScreenScale() => drawerOpened
      ? (Matrix4.translationValues(250.0, 150.0, 0.0)..scale(0.6))
      : Matrix4.translationValues(0.0, 0.0, 0.0);

  /// Change screen border radius when drawer opened or closed
  BorderRadius changeScreenBorderRadius() =>
      drawerOpened ? BorderRadius.circular(20.0) : BorderRadius.circular(0.0);
}
