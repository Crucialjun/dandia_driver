import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/core/locator.dart';
import 'package:dandia_driver/core/models/app_user_model.dart';
import 'package:dandia_driver/core/usecase.dart';
import 'package:dandia_driver/services/firebase_database_service/i_firebase_database_service.dart';
import 'package:dartz/dartz.dart';

class RetrieveUserUsecase
    with UseCases<Either<Failure, AppUserModel?>, String> {
  final _repository = locator<IFirebaseDatabaseService>();
  @override
  Future<Either<Failure, AppUserModel?>> call(params) async {
    return await _repository.retrieveUser(uid: params);
  }
}
