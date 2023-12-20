import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/core/locator.dart';
import 'package:dandia_driver/core/models/app_user_model.dart';
import 'package:dandia_driver/core/usecase.dart';
import 'package:dandia_driver/features/auth/data/repository/i_auth_repository.dart';
import 'package:dandia_driver/features/auth/domain/params/add_new_user_to_db_params.dart';
import 'package:dartz/dartz.dart';

class AddNewUserToDbUseCase
    with UseCases<Either<Failure, AppUserModel>, AddNewUserToDbParams> {
  final _repository = locator<IAUthRepository>();
  @override
  Future<Either<Failure, AppUserModel>> call(params) async {
    return await _repository.addNewUserToDB(
        uid: params.id,
        email: params.email,
        name: params.name,
        phone: params.phone,
        blockStatus: params.blockStatus);
  }
}
