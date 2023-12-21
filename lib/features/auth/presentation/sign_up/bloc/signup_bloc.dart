import 'dart:async';
import 'dart:io';

import 'package:dandia_driver/core/constants/hive_box_names.dart';
import 'package:dandia_driver/core/constants/hive_storage_keys.dart';
import 'package:dandia_driver/core/models/app_user_model.dart';
import 'package:dandia_driver/core/models/car_model.dart';

import 'package:dandia_driver/features/auth/domain/params/add_new_user_to_db_params.dart';
import 'package:dandia_driver/features/auth/domain/params/register_with_email_params.dart';
import 'package:dandia_driver/features/auth/domain/params/upload_file_params.dart';
import 'package:dandia_driver/features/auth/domain/usecases/add_new_user_to_db_usecase.dart';
import 'package:dandia_driver/features/auth/domain/usecases/register_with_email_usecase.dart';
import 'package:dandia_driver/features/auth/domain/usecases/upload_file_usecase.dart';
import 'package:dandia_driver/features/auth/presentation/sign_in/sign_in_screen.dart';
import 'package:dandia_driver/core/locator.dart';
import 'package:dandia_driver/features/dashboard/dashboard_view.dart';
import 'package:dandia_driver/features/home/presentation/home_view.dart';
import 'package:dandia_driver/services/dialog_and_sheet_service/i_dialog_and_sheet_service.dart';
import 'package:dandia_driver/services/local_storage_service/i_local_storage_service.dart';
import 'package:dandia_driver/services/navigation_service/i_navigation_service.dart';
import 'package:dandia_driver/services/network_service/i_network_service.dart';
import 'package:dandia_driver/shared/dialogs/loading_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) {});
    on<NavigateToSigninEvent>(_navigateToSignin);
    on<SignupWithEmailEvent>(_signUp);
    on<PhonenumberChanged>(_phoneNumberChanged);
    on<ChooseImageEvent>(_chooseImage);
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
    if (event.phone == null) {
      _dialogAndSheet.showSnackBar(message: "Please enter a phone number");
      return;
    }
    if (event.image == null) {
      _dialogAndSheet.showSnackBar(message: "Please choose an image");
      return;
    }
    emit(SignupLoading());

    await _network.checkConnectivity().then((value) async {
      if (value) {
        _dialogAndSheet.showAppDialog(
            const LoadingDialog(message: "Registering your account...."));

        final imageId = const Uuid().v4();

        final imageUploadRes = await UploadFileUseCase().call(
            UploadFileParams(fileName: imageId, file: File(event.image!.path)));
        imageUploadRes.fold((uploadFailure) {
          _navigation.back();
          _dialogAndSheet.showSnackBar(message: uploadFailure.message);
        }, (imageUrl) async {
          final res = await RegisterWithEmailUsecase().call(
              RegisterWithEmailParams(
                  email: event.email, password: event.password));
          _navigation.back();

          res.fold((l) {
            _dialogAndSheet.showSnackBar(message: l.message);
          }, (firebaseUser) async {
            CarModel car = CarModel(
                carColor: event.carColor,
                carModel: event.carModel,
                carNumber: event.carModel);

            var user = AppUserModel(
                id: firebaseUser?.uid ?? "",
                email: event.email,
                username: event.username,
                phone: event.phone ?? "",
                blockStatus: false,
                imageUrl: imageUrl,
                car: car);
            var dbRes = await AddNewUserToDbUseCase().call(user);

            dbRes.fold((l) {
              _dialogAndSheet.showSnackBar(message: l.message);
            }, (r) async {
              await _localStorage.write(
                  boxName: HiveBoxNames.userBox,
                  key: HiveStorageKeys.userProfile,
                  value: r);
              _navigation.navigateToNamed(DashboardView.routeName);
            });
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

  FutureOr<void> _chooseImage(
      ChooseImageEvent event, Emitter<SignupState> emit) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      emit(state.copyWith(image: XFile(pickedFile.path)));
    }
  }
}
