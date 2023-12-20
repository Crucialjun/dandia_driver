

import 'package:dandia_driver/core/failure.dart';
import 'package:dandia_driver/core/models/app_user_model.dart';
import 'package:dandia_driver/services/firebase_database_service/i_firebase_database_service.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';

class FirebaseDatabaseService implements IFirebaseDatabaseService {
  final db = FirebaseDatabase.instance;

  @override
  Future<Either<Failure, AppUserModel>> addNewUserToDB(
      {required String uid,
      required String email,
      required String name,
      required String phone,
      required bool blockStatus}) async {
    try {
      var appUser = AppUserModel(
          id: uid,
          email: email,
          username: name,
          phone: phone,
          blockStatus: blockStatus);
      await db.ref().child('drivers').child(uid).set(appUser.toMap());
      return right(appUser);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppUserModel?>> retrieveUser(
      {required String uid}) async {
    try {
      return await db.ref().child('drivers').child(uid).once().then((event) {
        if (event.snapshot.value == null) {
          return right(null);
        } else {
          Logger().i(event.snapshot.value);
          var mapOfMaps =
              Map<String, dynamic>.from(event.snapshot.value as Map);

          var res = mapOfMaps.map((key, value) => MapEntry(key, value));
          return right(AppUserModel.fromMap(res));
        }
      });
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
