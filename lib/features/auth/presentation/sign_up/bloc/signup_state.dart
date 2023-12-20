part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final PhoneNumber? phoneNumber;
  const SignupState({this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];

  //copy with
  SignupState copyWith({
    PhoneNumber? phoneNumber,
  }) {
    return SignupState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}
