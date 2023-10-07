import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/contacts_page.dart';
import 'pages/home_page.dart';
import 'providers/contact_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/contacts': (context) => const ContactsPage(),
      },
    );
  }
}
