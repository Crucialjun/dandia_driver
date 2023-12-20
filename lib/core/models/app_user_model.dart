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

  AppUserModel(
      {required this.id,
      required this.email,
      required this.username,
      required this.phone,
      required this.blockStatus});

  @override
  List<Object?> get props => [id, email, username, phone, blockStatus];

  //copy with
  AppUserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? phone,
    bool? blockStatus,
  }) {
    return AppUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      blockStatus: blockStatus ?? this.blockStatus,
    );
  }

  //from map
  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
      id: map['id'] ?? "",
      email: map['email'] ?? "",
      username: map['username'] ?? "",
      phone: map['phone'] ?? "",
      blockStatus: map['blockStatus'] ?? false,
    );
  }

  //to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'phone': phone,
      'blockStatus': blockStatus,
    };
  }

  //from json
  factory AppUserModel.fromJson(String source) =>
      AppUserModel.fromMap(source as Map<String, dynamic>);

  //to json
  String toJson() => toMap().toString();
}
