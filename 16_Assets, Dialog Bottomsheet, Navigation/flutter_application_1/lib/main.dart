import 'package:flutter/material.dart';
import 'ui/screen/input_form.dart';
import 'ui/screen/gridviewpoto.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const MyApp(),
      '/galeri': (context) => gridviewpoto(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'XRamadhann Kontak',
            style: TextStyle(fontSize: 15.5),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: MyForm(),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Contact'),
                onTap: () {
                  Navigator.of(context).pushNamed('/');
                },
              ),
              ListTile(
                title: Text('Galeri'),
                onTap: () {
                  Navigator.of(context).pushNamed('/galeri');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
