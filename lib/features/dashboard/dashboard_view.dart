import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  static const routeName = '/dashboard';
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashboardView'),
      ),
      body: const Center(child: Text('DashboardView')),
    );
  }
}
