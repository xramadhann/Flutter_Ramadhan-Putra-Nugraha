import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

import 'package:testing_app/class/contact.dart';
import 'package:testing_app/providers/contact_provider.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts'),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Center(
                child: Icon(Icons.contacts),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Create New Contacts',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Lorem ipsum dolor sit amet, sed do magna aliqua. Ut enim ad minim veniam, quis nostrud ex ea commodo consequat. Duis aute in repreh null pariatur.',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            _buildNameTextField(context),
            const SizedBox(height: 10),
            _buildContactTextField(context),
            const SizedBox(height: 10),
            _buildButtonsRow(context),
            const SizedBox(height: 10),
            const Text(
              'List Contacts',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Consumer<ContactProvider>(
                builder: (context, contactProvider, child) {
                  final contacts = contactProvider.contacts;
                  return _buildContactList(contacts, contactProvider);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameTextField(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, contactProvider, child) {
        return TextField(
          controller: contactProvider.nameController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: 'Contact Name',
            labelText: 'Contact Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: contactProvider.isNameValid ? Colors.grey : Colors.red,
              ),
            ),
            errorText: contactProvider.isNameValid ? null : 'Name invalid',
            prefixIcon: const Icon(Icons.person),
          ),
        );
      },
    );
  }

  Widget _buildContactTextField(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, contactProvider, child) {
        return TextField(
          controller: contactProvider.contactController,
          keyboardType: TextInputType.number,
          maxLength: 15,
          decoration: InputDecoration(
            hintText: 'Contact Number',
            labelText: 'Contact Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            errorText: contactProvider.isContactValid ? null : 'Number invalid',
            prefixIcon: const Icon(Icons.phone),
          ),
        );
      },
    );
  }

  Widget _buildButtonsRow(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, contactProvider, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _pickDate(context, contactProvider),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 8), // Spasi antara ikon dan teks
                      Text(
                        contactProvider.selectedDate == null
                            ? 'Pick Date'
                            : DateFormat('dd MMM yyyy')
                                .format(contactProvider.selectedDate!),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _pickColor(context, contactProvider),
                  child: Row(
                    children: [
                      Icon(Icons.color_lens),
                      SizedBox(width: 8), // Spasi antara ikon dan teks
                      Text('Pick Color'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: contactProvider.pickerColor,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _pickFile(context, contactProvider),
                  child: Row(
                    children: [
                      Icon(Icons.attach_file),
                      SizedBox(width: 8), // Spasi antara ikon dan teks
                      Text('Pick File'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _validateAndSubmit(context, contactProvider);
                    if (contactProvider.isNameValid &&
                        contactProvider.isContactValid) {
                      contactProvider.setSelectedDate(null);
                      contactProvider.setPickerColor(Colors.black);
                      contactProvider.setSelectedFilePath(null);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Add to list contact'),
                        ),
                      );
                    }
                  },
                  child: Text(contactProvider.selectedIndex == -1
                      ? 'Submit'
                      : 'Update'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildContactList(
      List<Contact> contacts, ContactProvider contactProvider) {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return _buildContactCard(
            context, index, contacts[index], contactProvider);
      },
    );
  }

  Widget _buildContactCard(BuildContext context, int index, Contact contact,
      ContactProvider contactProvider) {
    Color contactColor = contact.color;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: contactColor,
          foregroundColor: Colors.white,
          child: Text(
            contact.name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(contact.contact),
            Text(contact.date != null
                ? DateFormat.yMMMd().format(contact.date!)
                : 'No date selected'),
            Row(
              children: [
                const Text('Color: '),
                Container(
                  color: contactColor,
                  height: 15,
                  width: 15,
                ),
              ],
            ),
            Text('File: ${contact.filePath ?? 'Not selected'}'),
          ],
        ),
        trailing: SizedBox(
          width: 50,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  contactProvider.nameController.text = contact.name;
                  contactProvider.contactController.text = contact.contact;
                  contactProvider.setSelectedIndex(index);
                },
                child: const Icon(Icons.edit),
              ),
              InkWell(
                onTap: () {
                  contactProvider.removeContact(contact);
                },
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDate(BuildContext context, ContactProvider contactProvider) {
    showDatePicker(
      context: context,
      initialDate: contactProvider.selectedDate ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2101),
    ).then(
      (date) {
        if (date != null) {
          contactProvider.setSelectedDate(date);
        }
      },
    );
  }

  void _pickColor(BuildContext context, ContactProvider contactProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: contactProvider.pickerColor,
              onColorChanged: (Color color) {
                contactProvider.setPickerColor(color);
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _pickFile(BuildContext context, ContactProvider contactProvider) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String? path = result.files.single.path;
      if (path != null) {
        String fileName = path.split('/').last;
        contactProvider.setSelectedFilePath(fileName);
      }
    }
  }

  void _validateAndSubmit(
      BuildContext context, ContactProvider contactProvider) {
    final String name = contactProvider.nameController.text.trim();
    final String contact = contactProvider.contactController.text.trim();

    contactProvider.validateInput();

    if (contactProvider.isNameValid && contactProvider.isContactValid) {
      if (contactProvider.selectedIndex == -1) {
        contactProvider.addContact(
          Contact(
            name: name,
            contact: contact,
            color: contactProvider.pickerColor,
            date: contactProvider.selectedDate,
            filePath: contactProvider.selectedFilePath,
          ),
        );
      } else {
        contactProvider.updateContact(
          contactProvider.selectedIndex,
          Contact(
            name: name,
            contact: contact,
            color: contactProvider.pickerColor,
            date: contactProvider.selectedDate,
            filePath: contactProvider.selectedFilePath,
          ),
        );
        contactProvider.setSelectedIndex(-1);
      }
      contactProvider.nameController.text = '';
      contactProvider.contactController.text = '';
    }
  }
}
