part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeScreenContent extends HomeEvent {
  const GetHomeScreenContent();
}

class GetMovieDetails extends HomeEvent {
  final String movieId;
  const GetMovieDetails({this.movieId});
}
