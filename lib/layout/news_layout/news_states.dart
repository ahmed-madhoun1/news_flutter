abstract class NewsStates {}

class InitNewsState extends NewsStates {}

class ChangeBottomNavigationNewsState extends NewsStates {}

class AppCreateDatabaseState extends NewsStates {}

class GetLatestNewsSuccessNewsState extends NewsStates {}

class GetLatestNewsLoadingNewsState extends NewsStates {}

class GetLatestNewsErrorNewsState extends NewsStates {
  final String errorMessage;

  GetLatestNewsErrorNewsState(this.errorMessage);
}

class InsertArticlesDatabaseNewsState extends NewsStates {}

class GetLatestNewsDatabaseSuccessNewsState extends NewsStates {}

class GetLatestNewsDatabaseLoadingNewsState extends NewsStates {}

class GetLatestNewsDatabaseErrorNewsState extends NewsStates {
  final String errorMessage;

  GetLatestNewsDatabaseErrorNewsState(this.errorMessage);
}

class GetSearchedNewsSuccessNewsState extends NewsStates {}

class GetSearchedNewsLoadingNewsState extends NewsStates {}

class GetSearchedNewsErrorNewsState extends NewsStates {
  final String errorMessage;

  GetSearchedNewsErrorNewsState(this.errorMessage);
}

class GetSavedNewsSuccessNewsState extends NewsStates {}

class GetSavedNewsLoadingNewsState extends NewsStates {}

class GetSavedNewsErrorNewsState extends NewsStates {
  final String errorMessage;

  GetSavedNewsErrorNewsState(this.errorMessage);
}

class ChangeDrawerNavigationNewsState extends NewsStates {}

class InternetConnected extends NewsStates {}

class InternetNotConnected extends NewsStates {}

