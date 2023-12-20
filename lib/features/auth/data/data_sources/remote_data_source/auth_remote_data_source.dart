import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/core/locator.dart';
import 'package:dandia_driver/core/models/app_user_model.dart';
import 'package:dandia_driver/features/auth/data/data_sources/remote_data_source/i_auth_remote_data_source.dart';
import 'package:dandia_driver/services/firebase_auth_service/i_firebase_auth_service.dart';
import 'package:dandia_driver/services/firebase_database_service/i_firebase_database_service.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final _firebaseAuthService = locator<IFirebaseAuthService>();
  final _firebaseDbService = locator<IFirebaseDatabaseService>();
  @override
  Future registerWIthEmailAndPassword(
      {required String email, required String password}) async {
    return await _firebaseAuthService.registerWIthEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<Either<Failure, AppUserModel>> addNewUserToDB(
      {required String uid,
      required String email,
      required String name,
      required String phone,
      required bool blockStatus}) async {
    return await _firebaseDbService.addNewUserToDB(
        uid: uid,
        email: email,
        name: name,
        phone: phone,
        blockStatus: blockStatus);
  }

  @override
  Future<Either<Failure, User?>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await _firebaseAuthService.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<Either<Failure, AppUserModel?>> retrieveUser({required String uid}) async {
    return await _firebaseDbService.retrieveUser(uid: uid);
  }
  
  @override
  Future<Either<Failure, void>> logout() async{
    return await _firebaseAuthService.logout();
  }
}
