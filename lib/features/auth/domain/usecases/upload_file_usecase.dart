import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/core/locator.dart';
import 'package:dandia_driver/core/usecase.dart';
import 'package:dandia_driver/features/auth/data/repository/i_auth_repository.dart';
import 'package:dandia_driver/features/auth/domain/params/upload_file_params.dart';
import 'package:dartz/dartz.dart';

class UploadFileUseCase
    with UseCases<Either<Failure, String>, UploadFileParams> {
  final _repository = locator<IAUthRepository>();
  @override
  Future<Either<Failure, String>> call(params) async {
    return await _repository.uploadFile(
        imageId: params.fileName, file: params.file);
  }
}
