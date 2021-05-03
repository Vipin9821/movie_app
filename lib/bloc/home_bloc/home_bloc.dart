import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/models/model.dart';
import 'package:movie_app/repositories/api/api.dart';
import 'package:movie_app/screens/home_screen.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    print(event);
    if (event is GetHomeScreenContent) {
      List<MovieModel> movieData = await Api().getApiData();

      // await Api().getSpecificMovieDetails('192');
      try {
        if (movieData.isNotEmpty) {
          yield HomeScreenContentLoadedState(movieData: movieData);
        } else {
          yield HomeScreenErrorState(error: 'Something went wrong.');
        }
      } catch (e) {
        throw e;
      }
    }
    if (event is GetMovieDetails) {
      print(event.movieId);
      MovieModel data = await Api().getSpecificMovieDetails(event.movieId);
      try {
        if (data.id.toString() != null) {
          yield MovieDetailState(detail: data);
        } else {
          yield HomeScreenErrorState(error: 'Something went wrong.');
        }
      } catch (e) {
        throw e;
      }
    }
    // yield LoadingHomeScreenContent();
  }
}
