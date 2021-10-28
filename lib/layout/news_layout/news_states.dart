abstract class NewsStates {}

class InitNewsState extends NewsStates {}

class ChangeBottomNavigationNewsState extends NewsStates {}

class GetLatestNewsSuccessNewsState extends NewsStates {}

class GetLatestNewsLoadingNewsState extends NewsStates {}

class GetLatestNewsErrorNewsState extends NewsStates {
  final String errorMessage;

  GetLatestNewsErrorNewsState(this.errorMessage);
}
