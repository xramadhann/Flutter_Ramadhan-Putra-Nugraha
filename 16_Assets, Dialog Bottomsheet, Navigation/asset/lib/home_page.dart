import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List data = [
    {
      'name': 'Lewis Hamilton',
      'number': '(717) 550-1675',
    },
    {
      'name': 'Max Verstappen',
      'number': '(262) 162-1585',
    },
    {
      'name': 'Charles Leclerc',
      'number': '(201) 874-8593',
    },
    {
      'name': 'Valterri Bottas',
      'number': '(206) 342-8631',
    },
    {
      'name': 'Lando Norris',
      'number': '(248) 762-0356',
    },
    {
      'name': 'Fernando Alonso',
      'number': '(253) 644-2182',
    },
    {
      'name': 'Alex Albon',
      'number': '(212) 658-3916',
    },
    {
      'name': 'Esteban Ocon',
      'number': '(209) 300-2557',
    },
    {
      'name': 'Kevin Magnussen',
      'number': '(252) 258-3799',
    },
    {
      'name': 'Yuki Tsunoda',
      'number': '(234) 109-6666',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaterialApp'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                if (ModalRoute.of(context)?.settings.name != '/') {
                  Navigator.pushNamed(context, '/');
                }
              },
              child: const ListTile(
                title: Text("Home"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                if (ModalRoute.of(context)?.settings.name != '/contacts') {
                  Navigator.pushNamed(context, '/contacts');
                }
              },
              child: const ListTile(
                title: Text("Contacts"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                if (ModalRoute.of(context)?.settings.name != '/gallery') {
                  Navigator.pushNamed(context, '/gallery');
                }
              },
              child: const ListTile(
                title: Text("Gallery"),
              ),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 25,
              child: Text(
                data[index]['name'][0],
                style: const TextStyle(fontSize: 24),
              ),
            ),
            title: Text(
              data[index]['name'],
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              data[index]['number'],
              style: const TextStyle(fontSize: 16),
            ),
            onTap: () {},
          );
        },
        itemCount: data.length,
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
            color: Colors.grey,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
