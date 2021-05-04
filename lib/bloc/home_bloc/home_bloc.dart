import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
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
      yield LoadingHomeScreenContent();
      const apiKey = '4ff255842911eabc0e40fcc8f9357f79';

      Connectivity connectivity = Connectivity();
      // await Api().getSpecificMovieDetails('192');
      try {
        var result = await connectivity.checkConnectivity();
        String getConnectionValue(var res) {
          String status = '';
          switch (result) {
            case ConnectivityResult.mobile:
              status = 'Mobile';
              break;
            case ConnectivityResult.wifi:
              status = 'Wi-Fi';
              break;
            case ConnectivityResult.none:
              status = 'None';
              break;
            default:
              status = 'None';
              break;
          }
          return status;
        }

        var temp = getConnectionValue(result);
        if (temp != 'None') {
          print(result);
          print('connected');
          List<MovieModel> movieData = await Api().getApiData();
          if (movieData.isNotEmpty) {
            yield HomeScreenContentLoadedState(movieData: movieData);
          } else {
            yield HomeScreenErrorState(error: 'Something went wrong.');
          }
        } else {
          yield HomeScreenErrorState(error: 'Something went wrong.');
        }
      } catch (_) {
        print('not connected');
        yield ConnectionChangeState();
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
