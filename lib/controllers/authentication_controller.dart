import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthenticationController {
  static postDataToServer(service, dataToSend) async {
    await dotenv.load(fileName: ".env");
    String serverUrl = '${dotenv.env['SERVER_URL']}$service';
    final response = await http.post(Uri.parse(serverUrl),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: dataToSend);
    return response;
  }

  static verifyToken(context) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token == null) {
      Navigator.pushReplacementNamed(context, '/signup');
      return;
    }
    final response = await postDataToServer('/verifytoken', {'token': token});
    if (response.statusCode != 200) {
      Navigator.pushReplacementNamed(context, '/signin');
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

  static void signIn(email, password, context) async {
    final response = await postDataToServer(
        '/signin', {'email': email, 'password': password});
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      var receivedUsername = jsonDecode(response.body)['username'];
      await prefs.setString('username', receivedUsername);
      var receivedJsonWebToken = jsonDecode(response.body)['token'];
      await prefs.setString('token', receivedJsonWebToken);
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
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
    final response = await postDataToServer('/signup',
        {'username': username, 'email': email, 'password': password});
    if (response.statusCode == 201) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', username);
      var receivedJsonWebToken = jsonDecode(response.body)['token'];
      await prefs.setString('token', receivedJsonWebToken);
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
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
