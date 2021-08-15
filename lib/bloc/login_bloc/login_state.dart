part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoggedInState extends LoginState {}

class NotLoggedInState extends LoginState {}

class LoginErrorState extends LoginState {
  final String errorMessage;
  const LoginErrorState({ this.errorMessage});
}

class LoginLoadingState extends LoginState {}


class SignUpScreenState extends LoginState {}

class LoginScreenState extends LoginState{}