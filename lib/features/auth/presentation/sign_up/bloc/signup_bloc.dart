import 'dart:async';

import 'package:dandia_driver/core/constants/hive_box_names.dart';
import 'package:dandia_driver/core/constants/hive_storage_keys.dart';

import 'package:dandia_driver/features/auth/domain/params/add_new_user_to_db_params.dart';
import 'package:dandia_driver/features/auth/domain/params/register_with_email_params.dart';
import 'package:dandia_driver/features/auth/domain/usecases/add_new_user_to_db_usecase.dart';
import 'package:dandia_driver/features/auth/domain/usecases/register_with_email_usecase.dart';
import 'package:dandia_driver/features/auth/presentation/sign_in/sign_in_screen.dart';
import 'package:dandia_driver/core/locator.dart';
import 'package:dandia_driver/features/home/presentation/home_view.dart';
import 'package:dandia_driver/services/dialog_and_sheet_service/i_dialog_and_sheet_service.dart';
import 'package:dandia_driver/services/local_storage_service/i_local_storage_service.dart';
import 'package:dandia_driver/services/navigation_service/i_navigation_service.dart';
import 'package:dandia_driver/services/network_service/i_network_service.dart';
import 'package:dandia_driver/shared/dialogs/loading_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) {});
    on<NavigateToSigninEvent>(_navigateToSignin);
    on<SignupWithEmailEvent>(_signUp);
    on<PhonenumberChanged>(_phoneNumberChanged);
  }

  final _navigation = locator<INavigationService>();
  final _network = locator<INetworkService>();
  final _dialogAndSheet = locator<IDialogAndSheetService>();
  final _localStorage = locator<ILocalStorageService>();

  FutureOr<void> _navigateToSignin(
      NavigateToSigninEvent event, Emitter<SignupState> emit) {
    _navigation.navigateToNamed(SignInView.routeName);
  }

  FutureOr<void> _signUp(
      SignupWithEmailEvent event, Emitter<SignupState> emit) async {
    if (state.phoneNumber == null) {
      _dialogAndSheet.showSnackBar(message: "Please enter a phone number");
      return;
    }
    emit(SignupLoading());

    await _network.checkConnectivity().then((value) async {
      if (value) {
        _dialogAndSheet.showAppDialog(
            const LoadingDialog(message: "Registering your account...."));
        final res = await RegisterWithEmailUsecase().call(
            RegisterWithEmailParams(
                email: event.email, password: event.password));
        _navigation.back();

        res.fold((l) {
          _dialogAndSheet.showSnackBar(message: l.message);
        }, (r) async {
          var dbRes = await AddNewUserToDbUseCase().call(AddNewUserToDbParams(
              id: r?.uid ?? "",
              email: event.email,
              name: event.username,
              phone: event.phone ?? "",
              blockStatus: false));

          dbRes.fold((l) {
            _dialogAndSheet.showSnackBar(message: l.message);
          }, (r) async {
            await _localStorage.write(
                boxName: HiveBoxNames.userBox,
                key: HiveStorageKeys.userProfile,
                value: r);
            _navigation.navigateToNamed(HomeView.routeName);
          });
        });
      } else {
        _dialogAndSheet.showSnackBar(
          message: "No Internet Connection",
        );
      }
    });
  }

  FutureOr<void> _phoneNumberChanged(
      PhonenumberChanged event, Emitter<SignupState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }
}
