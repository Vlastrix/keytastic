import 'package:flutter/material.dart';
import 'package:fancy_password_field/fancy_password_field.dart';
import 'package:email_validator/email_validator.dart';

import '../models/keytastic_colors.dart';
import '../controllers/authentication_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign In!',
                  style: TextStyle(
                      fontSize: 40, color: KeyTasticColors.keytasticYellow),
                ),
                const SizedBox(
                  height: 20.0,
                  width: 200.0,
                  child: Divider(
                    color: KeyTasticColors.keytasticWhite,
                  ),
                ),
                Container(
                  width: 346,
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (enteredEmail) {
                      if (enteredEmail == null || enteredEmail.isEmpty) {
                        return 'Please enter some text.';
                      } else if (enteredEmail.contains(' ')) {
                        return 'Emails cannot contain spaces.';
                      } else if (!RegExp(r'^[a-z0-9_.@]+$')
                          .hasMatch(enteredEmail)) {
                        return 'Only lowercase letters and latin characters.';
                      } else if (!EmailValidator.validate(email as String)) {
                        return 'Enter a valid email.';
                      }
                      return null;
                    },
                    onChanged: (enteredEmail) {
                      email = enteredEmail;
                    },
                    decoration: const InputDecoration(
                      errorStyle:
                          TextStyle(color: KeyTasticColors.keytasticYellow),
                      hintText: 'Email',
                      filled: true,
                      fillColor: KeyTasticColors.keytasticWhite,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: KeyTasticColors.keytasticYellow),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 346,
                  padding: const EdgeInsets.all(10),
                  child: FancyPasswordField(
                    validator: (enteredPassword) {
                      if (enteredPassword == null || enteredPassword.isEmpty) {
                        return 'Please enter some text.';
                      } else if (enteredPassword.contains(' ')) {
                        return 'Passwords cannot contain spaces.';
                      } else if (!RegExp(
                              r'^[A-Za-z0-9_\.!@=#\$%\^&\*\(\)\?\+\[\]\|\-`~:;]+$')
                          .hasMatch(enteredPassword)) {
                        return 'Only latin characters are accepted.';
                      }
                      return null;
                    },
                    onChanged: (enteredPassword) {
                      password = enteredPassword;
                    },
                    hasValidationRules: false,
                    hasStrengthIndicator: false,
                    decoration: const InputDecoration(
                      errorStyle:
                          TextStyle(color: KeyTasticColors.keytasticYellow),
                      hintText: 'Password',
                      filled: true,
                      fillColor: KeyTasticColors.keytasticWhite,
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2, color: KeyTasticColors.keytasticYellow),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  width: 328,
                  child: ElevatedButton(
                    onPressed: () {
                      final form = _formKey.currentState!;
                      if (form.validate()) {
                        AuthenticationController.signIn(
                            email, password, context);
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        KeyTasticColors.keytasticCyan,
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.all(20),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: KeyTasticColors.keytasticWhite),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'Sign Up!',
                        style:
                            TextStyle(color: KeyTasticColors.keytasticYellow),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
