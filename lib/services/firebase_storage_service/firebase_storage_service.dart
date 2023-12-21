import 'dart:io';

import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/services/firebase_storage_service/i_firebase_storage_service.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService implements IFirebaseStorageService {
  final _storage = FirebaseStorage.instance;
  @override
  Future<Either<Failure, String>> uploadFile(
      {required File file, required String imageId}) async {
    Reference ref = _storage.ref().child("Images").child(imageId);
    try {
      await ref.putFile(file);
      var url = await ref.getDownloadURL();
      return Right(url);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
