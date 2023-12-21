import 'dart:io';

import 'package:dandia_driver/core/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IFirebaseStorageService {
  Future<Either<Failure, String>> uploadFile({
    required File file,
    required String imageId,
  });
}