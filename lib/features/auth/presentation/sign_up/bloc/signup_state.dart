part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final PhoneNumber? phoneNumber;
  final XFile? image;
  const SignupState({this.image, this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber, image];

  //copy with
  SignupState copyWith({
    PhoneNumber? phoneNumber,
    XFile? image,
  }) {
    return SignupState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      image: image ?? this.image,
    );
  }
}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}
