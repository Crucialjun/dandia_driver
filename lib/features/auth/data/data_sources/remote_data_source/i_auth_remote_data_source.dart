import 'dart:io';

import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/core/models/app_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRemoteDataSource {
  Future registerWIthEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, User?>> signInWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, AppUserModel>> addNewUserToDB(
      {required AppUserModel user});

  Future<Either<Failure, AppUserModel?>> retrieveUser({required String uid});

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, String>> uploadFile(
      {required String imageId, required, File file});
}
