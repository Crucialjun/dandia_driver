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
  final XFile? image;
  final String carColor;
  final String carModel;
  final String carNumber;

  const SignupWithEmailEvent(
      {required this.email,
      required this.password,
      required this.username,
      required this.phone,
      required this.image,
      required this.carColor,
      required this.carModel,
      required this.carNumber});

  @override
  List<Object?> get props => [email, password, username, phone, image, carColor, carModel, carNumber];
}

class PhonenumberChanged extends SignupEvent {
  final PhoneNumber phoneNumber;

  const PhonenumberChanged({required this.phoneNumber});
}

class ChooseImageEvent extends SignupEvent {}
