import 'package:flutter/material.dart';

import '../controllers/authentication_controller.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    AuthenticationController.verifyToken(context);
    return const Text('Dashboard for KeyTastic!');
  }
}
