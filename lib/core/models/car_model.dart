import 'package:hive/hive.dart';

part 'car_model.g.dart';

@HiveType(typeId: 1)
class CarModel {
  @HiveField(0)
  final String carColor;

  @HiveField(1)
  final String carModel;

  @HiveField(2)
  final String carNumber;

  CarModel(
      {required this.carColor,
      required this.carModel,
      required this.carNumber});

  //copy with
  CarModel copyWith({
    String? carColor,
    String? carModel,
    String? carNumber,
  }) {
    return CarModel(
      carColor: carColor ?? this.carColor,
      carModel: carModel ?? this.carModel,
      carNumber: carNumber ?? this.carNumber,
    );
  }

  //from map
  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      carColor: map['carColor'] ?? "",
      carModel: map['carModel'] ?? "",
      carNumber: map['carNumber'] ?? "",
    );
  }

  //to map
  Map<String, dynamic> toMap() {
    return {
      'carColor': carColor,
      'carModel': carModel,
      'carNumber': carNumber,
    };
  }
}
