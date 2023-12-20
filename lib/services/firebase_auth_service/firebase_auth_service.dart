import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/services/firebase_auth_service/i_firebase_auth_service.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements IFirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either<Failure, User?>> registerWIthEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return left(const Failure('The password provided is too weak'));
      } else if (e.code == 'email-already-in-use') {
        return left(const Failure('The account already exists for that email'));
      }
      return left(Failure(e.message ?? 'Something went wrong'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left(const Failure('No user found for that email'));
      } else if (e.code == 'wrong-password') {
        return left(const Failure('Wrong password provided for that user'));
      }
      return left(Failure(e.message ?? 'Something went wrong'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> logout() async{
    try {
      return _firebaseAuth.signOut().then((value) => right(null));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  
}
