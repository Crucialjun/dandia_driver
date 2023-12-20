import 'package:flutter/material.dart';

class AppInputDecoration extends InputDecoration {
  final String labelString;

  const AppInputDecoration({required this.labelString});

  @override
  String? get labelText => labelString;

  @override
  TextStyle? get labelStyle => const TextStyle(
        fontSize: 14,
      );
  @override

  TextStyle? get errorStyle => const TextStyle(
        color: Colors.red,
      );
}
