part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class InitiateHomeState extends SplashState {
  const InitiateHomeState();
}

class NoNetworkState extends SplashState {
  const NoNetworkState();
}

class SplashLoadingState extends SplashState {
  const SplashLoadingState();
}
