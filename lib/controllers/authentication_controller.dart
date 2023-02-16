import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthenticationController {
  static signIn(email, password, context) async {
    await dotenv.load(fileName: ".env");
    final prefs = await SharedPreferences.getInstance();
    String serverUrl = '${dotenv.env['SERVER_URL']}/signin';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      var receivedUsername = jsonDecode(response.body)['username'];
      await prefs.setString('username', receivedUsername);
      var receivedJsonWebToken = jsonDecode(response.body)['token'];
      await prefs.setString('token', receivedJsonWebToken);
      if (context.mounted) Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.body,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }

  static signUp(username, email, password, context) async {
    await dotenv.load(fileName: ".env");
    String serverUrl = '${dotenv.env['SERVER_URL']}/signup';
    final response = await http.post(
      Uri.parse(serverUrl),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        'username': username,
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 201) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      var receivedJsonWebToken = jsonDecode(response.body)['token'];
      await prefs.setString('token', receivedJsonWebToken);
      if (context.mounted) Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.body,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }
  }
}
