import 'package:flutter/material.dart';

import './signup.dart';
import './signin.dart';

void main() {
  runApp(const KeyTastic());
}

class KeyTastic extends StatelessWidget {
  const KeyTastic({super.key});

  @override
  Widget build(BuildContext context) {
    return SignUp();
  }
}
