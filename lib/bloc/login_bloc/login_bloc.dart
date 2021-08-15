import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/services/login_service.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield LoginLoadingState();
    if (event is LoginCancelledEvent) {
      yield LoginInitial();
    }
    if (event is NewUserRegistrationEvent) {
      yield LoginLoadingState();
      try {
        var user = await GetIt.I<LoginService>().signupWithEmailPassword(
          event.email,
          event.pass,
        );
        if (user != null) {
          yield LoggedInState();
        } else {
          yield LoginErrorState(
              errorMessage: GetIt.I<LoginService>().errorMessage);
        }
      } catch (e) {
        yield LoginErrorState(
            errorMessage: GetIt.I<LoginService>().errorMessage);
      }
    }

    if (event is ToggleLoginEvent) {
      yield LoginLoadingState();
      yield LoginScreenState();
    }

    if (event is ToggleSignUpEvent) {
      yield LoginLoadingState();
      yield SignUpScreenState();
    }
    if (event is LoginWithEmailPassEvent) {
      yield LoginLoadingState();
      try {
        var user = await GetIt.I<LoginService>().signinWithEmailPassword(
          event.email,
          event.pass,
        );
        if (user != null) {
          yield LoggedInState();
        } else {
          yield LoginErrorState(
              errorMessage: GetIt.I<LoginService>().errorMessage);
        }
      } catch (e) {
        yield LoginErrorState();
      }
    }
  }
}
