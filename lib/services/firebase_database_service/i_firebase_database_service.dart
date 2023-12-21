import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/core/models/app_user_model.dart';
import 'package:dartz/dartz.dart';

abstract class IFirebaseDatabaseService {
  Future<Either<Failure, AppUserModel>> addNewUserToDB(
      {required AppUserModel user});

  Future<Either<Failure, AppUserModel?>> retrieveUser({required String uid});
}
