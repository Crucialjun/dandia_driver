import 'package:dandia_driver/core/models/car_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'app_user_model.g.dart';

@HiveType(typeId: 0)
class AppUserModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String username;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final bool blockStatus;

  @HiveField(5)
  final String imageUrl;

  @HiveField(6)
  final CarModel car;

  AppUserModel(
      {required this.id,
      required this.email,
      required this.username,
      required this.phone,
      required this.blockStatus,
      required this.imageUrl,
      required this.car});

  @override
  List<Object?> get props =>
      [id, email, username, phone, blockStatus, imageUrl, car];

  //copy with
  AppUserModel copyWith(
      {String? id,
      String? email,
      String? username,
      String? phone,
      bool? blockStatus,
      String? imageUrl,
      CarModel? car}) {
    return AppUserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        phone: phone ?? this.phone,
        blockStatus: blockStatus ?? this.blockStatus,
        imageUrl: imageUrl ?? this.imageUrl,
        car: car ?? this.car);
  }

  //from map
  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
        id: map['id'] ?? "",
        email: map['email'] ?? "",
        username: map['username'] ?? "",
        phone: map['phone'] ?? "",
        blockStatus: map['blockStatus'] ?? false,
        imageUrl: map['imageUrl'] ?? "",
        car: CarModel.fromMap(map['car']));
  }

  //to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'phone': phone,
      'blockStatus': blockStatus,
      'imageUrl': imageUrl,
      'car': car.toMap()
    };
  }

  //from json
  factory AppUserModel.fromJson(String source) =>
      AppUserModel.fromMap(source as Map<String, dynamic>);

  //to json
  String toJson() => toMap().toString();
}
