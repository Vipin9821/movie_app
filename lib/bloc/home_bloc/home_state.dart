part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeContentLoadingState extends HomeState {
  const HomeContentLoadingState();
}

class LoadingHomeScreenContent extends HomeState {
  const LoadingHomeScreenContent();
}

//state if content is loaded
class HomeScreenContentLoadedState extends HomeState {
  final List<MovieModel> movieData;
  const HomeScreenContentLoadedState({this.movieData});
}

//normal error in home screen
class HomeScreenErrorState extends HomeState {
  final String error;
  const HomeScreenErrorState({this.error});
}

//if error occur in content loading
class HomeScreenContentErrorState extends HomeState {
  const HomeScreenContentErrorState();
}

//if screen is loaded
class HomeScreenLoadedState extends HomeState {
  const HomeScreenLoadedState();
}

//to show movie detail screen
class MovieDetailState extends HomeState {
  final MovieModel detail;
  const MovieDetailState({this.detail});
}
