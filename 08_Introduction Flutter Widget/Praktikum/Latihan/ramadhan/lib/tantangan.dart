import 'package:flutter/material.dart';

void main() => runApp(TantanganApp());

class TantanganApp extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tantangan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TantanganHomePage(),
    );
  }
}

class TantanganHomePage extends StatefulWidget {
  @override
  _TantanganHomePageState createState() => _TantanganHomePageState();
}

class _TantanganHomePageState extends State<TantanganHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    // Ganti dengan halaman-halaman Anda sendiri di sini
    Placeholder(
      color: Colors.white,
    ),
    Placeholder(
      color: Colors.blue,
    ),
    Placeholder(
      color: Colors.green,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tantangan Flutter'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Hamburger Menu'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Menu 1'),
              onTap: () {
                // Tambahkan aksi yang sesuai untuk Menu 1
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Menu 2'),
              onTap: () {
                // Tambahkan aksi yang sesuai untuk Menu 2
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'user',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: 'user',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
