part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class NavigateToSigninEvent extends SignupEvent {}

class SignupWithEmailEvent extends SignupEvent {
  final String email;
  final String password;
  final String username;
  final String? phone;

  const SignupWithEmailEvent(
      {required this.email,
      required this.password,
      required this.username,
      required this.phone});

  @override
  List<Object?> get props => [email, password, username, phone];
}


class PhonenumberChanged extends SignupEvent{
  final PhoneNumber phoneNumber;

  const PhonenumberChanged({required this.phoneNumber});
}
