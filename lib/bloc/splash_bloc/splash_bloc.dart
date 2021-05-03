import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity/connectivity.dart';
import 'package:movie_app/repositories/api/api.dart';
part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial());

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is OnBoardStatus) {
      await Future.delayed(Duration(seconds: 2));
    
   
      yield InitiateHomeState();
    }
    yield SplashLoadingState();
  }
}
