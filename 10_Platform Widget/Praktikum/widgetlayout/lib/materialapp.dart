import 'package:flutter/material.dart';

void main() => runApp(TantanganApp());

class TantanganApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soal Prioritas 1',
      theme: ThemeData.dark(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.system,
      home: TantanganHomePage(),
    );
  }
}

class TantanganHomePage extends StatefulWidget {
  @override
  _TantanganHomePageState createState() => _TantanganHomePageState();
}

List<Map<String, String>> data_kontak = [
  {"title": "Kepala Suku", "nomer_telfon": "08521242141245"},
  {"title": "Guru Bahasa Cinta", "nomer_telfon": "0821341245334"},
  {"title": "Bendahara Sekolah", "nomer_telfon": "08589201832"},
  {"title": "Guru Matematika", "nomer_telfon": "08123256753"},
  {"title": "Guru Biologi", "nomer_telfon": "08521231241"},
  {"title": "Kepala Suku", "nomer_telfon": "08521242141245"},
  {"title": "Guru Bahasa Cinta", "nomer_telfon": "0821341245334"},
  {"title": "Bendahara Sekolah", "nomer_telfon": "08589201832"},
  {"title": "Guru Matematika", "nomer_telfon": "08123256753"},
  {"title": "Guru Biologi", "nomer_telfon": "08521231241"}
];

class _TantanganHomePageState extends State<TantanganHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Container(
      color: const Color.fromARGB(255, 47, 47, 47),
      child: ListView.builder(
        itemCount: data_kontak.length,
        itemBuilder: (BuildContext context, int index) {
          String title = data_kontak[index]["title"] ?? "";
          String nomertelfon = data_kontak[index]["nomer_telfon"] ?? "";

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              radius: 25,
              child: Text(
                title.isNotEmpty ? title[0] : "",
                style: TextStyle(fontSize: 20),
              ),
            ),
            title: Text(title),
            subtitle: Text('$nomertelfon'),
          );
        },
      ),
    ),
    Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          'Halaman Config',
          style: TextStyle(fontSize: 24),
        ),
      ),
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
        title: Text('MaterialApp'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Config',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
