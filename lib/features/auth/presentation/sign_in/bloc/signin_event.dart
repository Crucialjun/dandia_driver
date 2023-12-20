part of 'signin_bloc.dart';

sealed class SigninEvent extends Equatable {
  const SigninEvent();

  @override
  List<Object> get props => [];
}

class NavigateToSignupEvent extends SigninEvent {}

class SigninWithEmailEvent extends SigninEvent {
  final String email;
  final String password;

  const SigninWithEmailEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
