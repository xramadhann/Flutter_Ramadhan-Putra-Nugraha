import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/contact_page.dart';
import 'pages/gallery_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'providers/contact_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
        Provider<bool>.value(value: isLoggedIn),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/contacts': (context) => const ContactsPage(),
        '/gallery': (context) => const GalleryPage(),
      },
    );
  }
}
