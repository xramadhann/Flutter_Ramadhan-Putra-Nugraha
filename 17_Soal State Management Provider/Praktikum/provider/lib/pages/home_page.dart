import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:testing_app/providers/contact_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
