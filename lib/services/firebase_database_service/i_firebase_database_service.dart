import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/core/models/app_user_model.dart';
import 'package:dartz/dartz.dart';

abstract class IFirebaseDatabaseService {
  Future<Either<Failure, AppUserModel>> addNewUserToDB(
      {required String uid,
      required String email,
      required String name,
      required String phone,
      required bool blockStatus});

  Future<Either<Failure, AppUserModel?>> retrieveUser({required String uid});
}
