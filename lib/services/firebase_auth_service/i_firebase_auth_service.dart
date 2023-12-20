import 'package:dandia_driver/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IFirebaseAuthService {
  Future<Either<Failure, User?>> registerWIthEmailAndPassword({required String email,required String password});
  Future<Either<Failure, User?>> signInWithEmailAndPassword({required String email,required String password});
  Future<Either<Failure,void>> logout();
}
