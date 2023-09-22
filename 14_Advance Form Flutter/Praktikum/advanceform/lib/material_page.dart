import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ContactsPage(),
    );
  }
}

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact> contacts = [
    Contact(name: "Ramadhan Putra", phone: "+621827364628"),
    Contact(name: "Rama Putra", phone: "+62222484939"),
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.phone_android,
            ),
            SizedBox(height: 20),
            Text("Create New Contacts", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text(
                "A dialog is a type of modal window that appears in front of app content to provide critical information, or prompt for a decision to be made. "),
            ContactForm(
              nameController: nameController,
              phoneController: phoneController,
              onAddContact: addContact,
            ),
            SizedBox(height: 20),
            Text(
              "List Contacts",
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: ContactList(
                contacts: contacts,
                onDeleteContact: deleteContact,
                onEditContact: editContact,
                onUpdateContact: updateContact,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addContact(String name, String phone) {
    setState(() {
      contacts.add(Contact(name: name, phone: phone));
    });
  }

  void deleteContact(Contact contact) {
    setState(() {
      contacts.remove(contact);
    });
  }

  void editContact(Contact contact) {
    showDialog(
      context: context,
      builder: (context) {
        final updatedNameController = TextEditingController(text: contact.name);
        final updatedPhoneController =
            TextEditingController(text: contact.phone);

        return AlertDialog(
          title: Text("Edit Contact"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: updatedNameController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: updatedPhoneController,
                decoration: InputDecoration(labelText: 'No. Telepon'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                final updatedName = updatedNameController.text;
                final updatedPhone = updatedPhoneController.text;
                if (updatedName.isNotEmpty && updatedPhone.isNotEmpty) {
                  updateContact(
                      contact, Contact(name: updatedName, phone: updatedPhone));
                  Navigator.of(context).pop();
                }
              },
              child: Text("Simpan"),
            ),
          ],
        );
      },
    );
  }

  void updateContact(Contact oldContact, Contact newContact) {
    setState(() {
      final index = contacts.indexOf(oldContact);
      if (index != -1) {
        contacts[index] = newContact;
      }
    });
  }
}

class ContactForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final Function(String, String) onAddContact;

  ContactForm({
    required this.nameController,
    required this.phoneController,
    required this.onAddContact,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nama'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'No. Telepon'),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              final name = nameController.text;
              final phone = phoneController.text;
              if (name.isNotEmpty && phone.isNotEmpty) {
                onAddContact(name, phone);
                nameController.clear();
                phoneController.clear();
              }
            },
            child: Text("Submit"),
          ),
        ),
      ],
    );
  }
}

class ContactList extends StatelessWidget {
  final List<Contact> contacts;
  final Function(Contact) onDeleteContact;
  final Function(Contact) onEditContact;
  final Function(Contact, Contact) onUpdateContact;

  ContactList({
    required this.contacts,
    required this.onDeleteContact,
    required this.onEditContact,
    required this.onUpdateContact,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return ListTile(
          title: Text(contact.name),
          subtitle: Text(contact.phone),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  onEditContact(contact);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  onDeleteContact(contact);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class Contact {
  final String name;
  final String phone;

  Contact({required this.name, required this.phone});
}
