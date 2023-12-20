import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/core/locator.dart';
import 'package:dandia_driver/core/usecase.dart';
import 'package:dandia_driver/features/auth/data/repository/i_auth_repository.dart';
import 'package:dandia_driver/features/auth/domain/params/register_with_email_params.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterWithEmailUsecase
    with UseCases<Either<Failure, User?>, RegisterWithEmailParams> {
  final _repository = locator<IAUthRepository>();
  @override
  Future<Either<Failure, User?>> call(params) async {
    return await _repository.registerWIthEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}
