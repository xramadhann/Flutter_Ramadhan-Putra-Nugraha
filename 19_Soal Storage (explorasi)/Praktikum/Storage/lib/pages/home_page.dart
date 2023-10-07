import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:testing_app/providers/contact_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Fungsi untuk memuat data pengguna
  void _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username') ?? "";
      email = prefs.getString('email') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider =
        Provider.of<ContactProvider>(context, listen: false);
    final contacts = contactProvider.contacts;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(username),
              accountEmail: Text(email),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 64,
                  color: Colors.blue,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                if (ModalRoute.of(context)?.settings.name != '/home') {
                  Navigator.pushNamed(context, '/home');
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
            InkWell(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                await prefs.remove('username');
                await prefs.remove('email');
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login',
                  (Route<dynamic> route) => false,
                );
              },
              child: const ListTile(
                title: Text("Logout"),
              ),
            ),
          ],
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 25,
              child: Text(
                contact.name[0],
                style: const TextStyle(fontSize: 24),
              ),
            ),
            title: Text(
              contact.name,
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              contact.contact,
              style: const TextStyle(fontSize: 16),
            ),
            onTap: () {},
          );
        },
        itemCount: contacts.length,
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
