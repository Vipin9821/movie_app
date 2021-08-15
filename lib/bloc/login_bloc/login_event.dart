part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginWithEmailPassEvent extends LoginEvent {
  final String email;
  final String pass;
  const LoginWithEmailPassEvent({this.email, this.pass});
}

class NewUserRegistrationEvent extends LoginEvent {
  final String email;
  final String pass;
  const NewUserRegistrationEvent({this.email, this.pass});
}

class LoginCancelledEvent extends LoginEvent{}

class ToggleSignUpEvent extends LoginEvent{}

class ToggleLoginEvent extends LoginEvent{} 
