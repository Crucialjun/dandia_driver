import 'dart:io';

import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/core/locator.dart';
import 'package:dandia_driver/core/models/app_user_model.dart';
import 'package:dandia_driver/features/auth/data/data_sources/remote_data_source/i_auth_remote_data_source.dart';
import 'package:dandia_driver/features/auth/data/repository/i_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository implements IAUthRepository {
  final _dataSOurce = locator<IAuthRemoteDataSource>();
  @override
  Future<Either<Failure, User?>> registerWIthEmailAndPassword(
      {required String email, required String password}) async {
    return await _dataSOurce.registerWIthEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<Either<Failure, AppUserModel>> addNewUserToDB(
      {required AppUserModel user}) async {
    return await _dataSOurce.addNewUserToDB(
        user: user);
  }

  @override
  Future<Either<Failure, User?>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _dataSOurce.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<Either<Failure, AppUserModel?>> retrieveUser({required String uid}) async {
    return await _dataSOurce.retrieveUser(uid: uid);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return _dataSOurce.logout();
  }

  @override
  Future<Either<Failure, String>> uploadFile({required String imageId, required, File? file}) {
    return _dataSOurce.uploadFile(imageId: imageId, file: file!);
  }
}
