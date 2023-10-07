import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = Provider.of<bool>(context, listen: false);

    if (isLoggedIn) {
      return const HomePage();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 200.0),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24.0),
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  if (usernameController.text == 'Ramadhan' &&
                      emailController.text == 'Ramadhan@gmail.com' &&
                      passwordController.text == '123') {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLoggedIn', true);
                    await prefs.setString('username', usernameController.text);
                    await prefs.setString('email', emailController.text);
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Login Failed'),
                          content: const Text('Invalid accounts.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26.0,
                    vertical: 14.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
