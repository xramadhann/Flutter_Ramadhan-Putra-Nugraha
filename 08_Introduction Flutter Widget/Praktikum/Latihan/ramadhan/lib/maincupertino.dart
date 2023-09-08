import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
        home: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text("Contoh cupertino"),
            ),
            child: Center(
              child: Text("Hallo, Nama saya Ramadhan Putra"),
            )));
  }
}
