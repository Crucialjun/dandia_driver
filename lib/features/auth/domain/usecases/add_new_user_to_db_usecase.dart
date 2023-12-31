import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/core/locator.dart';
import 'package:dandia_driver/core/models/app_user_model.dart';
import 'package:dandia_driver/core/usecase.dart';
import 'package:dandia_driver/features/auth/data/repository/i_auth_repository.dart';

import 'package:dartz/dartz.dart';

class AddNewUserToDbUseCase
    with UseCases<Either<Failure, AppUserModel>, AppUserModel> {
  final _repository = locator<IAUthRepository>();
  @override
  Future<Either<Failure, AppUserModel>> call(params) async {
    return await _repository.addNewUserToDB(
        user: params);
  }
}
