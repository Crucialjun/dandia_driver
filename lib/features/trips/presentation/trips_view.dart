import 'package:flutter/material.dart';

class TripsView extends StatelessWidget {
  const TripsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TripsView'),
        ),
        body: const Center(child: Text('TripsView')));
  }
}
