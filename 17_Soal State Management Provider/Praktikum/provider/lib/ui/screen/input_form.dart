import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'gridviewpoto.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime _dueDate = DateTime.now();
  final currentDate = DateTime.now();
  Color _currentColor = Colors.orange;
  PlatformFile? _pickedFile;
  var _fileName = '';

  @override
  Widget build(BuildContext context) {
    // Ambil data dari ContactProvider
    final contactProvider = context.watch<ContactProvider>();
    final contacts = contactProvider.contacts;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Icon(Icons.login_sharp),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'DAFTAR PENUMPANG',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Form untuk Keberangkatan Penumpang hari ini'),
            ],
          ),
          Divider(),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nama',
            ),
          ),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Nomor Telp',
            ),
          ),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tanggal Hari ini'),
                  TextButton(
                    onPressed: () async {
                      final selectDate = await showDatePicker(
                        context: context,
                        initialDate: currentDate,
                        firstDate: DateTime(1990),
                        lastDate: DateTime(currentDate.year + 5),
                      );

                      setState(() {
                        if (selectDate != null) {
                          _dueDate = selectDate;
                        }
                      });
                    },
                    child: const Text('Select'),
                  ),
                ],
              ),
              Text(DateFormat('dd-MM-yyyy').format(_dueDate)),
            ],
          ),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Color'),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                width: double.infinity,
                color: _currentColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(_currentColor),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Warna Tiket'),
                          content: BlockPicker(
                            pickerColor: _currentColor,
                            onColorChanged: (color) {
                              setState(() {
                                _currentColor = color;
                              });
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Save'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Pick Color'),
                ),
              )
            ],
          ),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Foto Bukti Transfer'),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _pickFile();
                  },
                  child: const Text('Pick and Open File'),
                ),
              ),
              if (_pickedFile != null)
                Text('Bukti Transfer: ${_pickedFile!.name}'),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  String name = _nameController.text;
                  String phone = _phoneController.text;
                  Color color = _currentColor;
                  var fileName = _fileName;
                  Contact newContact = Contact(name: name, phone: phone, color: color, fileName: fileName);
                  setState(() {
                    contactProvider.addContact(newContact);
                  });
                  _nameController.clear();
                  _phoneController.clear();

                  setState(() {
                    _pickedFile = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Submit'),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => gridviewpoto()),
              );
            },
            child: Text('Buka Halaman Baru'),
          ),
          Divider(),
          Column(
            children: <Widget>[
              Text(
                'List Kontak Penumpang',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: contacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(contacts[index].name),
                          subtitle: Column(
                            children: [
                              Text(
                                'Nomor Telp: ${contacts[index].phone}  | Tanggal : ${DateFormat('dd-MM-yyyy').format(currentDate)}',
                              ),
                              Row(
                                children: [
                                  Text(' Warna Tiket : '),
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Container(
                                      color: contacts[index].color,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Bukti Transfer : ${contacts[index].fileName}',
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {

                                  contactProvider.removeContact(index);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  showDialog(
                                    context: context, 
                                    builder: (context) {
                                      _nameController.text = contacts[index].name;
                                      _phoneController.text = contacts[index].phone;
                                      _currentColor = contacts[index].color;
                                      _fileName = contacts[index].fileName;

                                      return AlertDialog(
                                        title: Text('Edit Kontak'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget> [
                                            TextFormField(
                                              controller: _nameController,
                                              decoration: InputDecoration(
                                                labelText: 'Nama',
                                              ),
                                            ),
                                            TextFormField(
                                              controller: _phoneController,
                                              decoration: InputDecoration(
                                                labelText: 'Nomor Telp',
                                              ),
                                            ),
                                            SizedBox(height: 16.0),
                                            Text('Color'),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              height: 100,
                                              width: double.infinity,
                                              color: _currentColor,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all(_currentColor),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                  context: context, 
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text('Warna Tiket'),
                                                      content: BlockPicker(
                                                        pickerColor: _currentColor,
                                                        onColorChanged: (color) {
                                                          setState(() {
                                                            _currentColor = color;
                                                          });
                                                        },
                                                      ),
                                                    );
                                                    // actions: [
                                                    //   TextButton(
                                                    //     onPressed: () {
                                                    //       Navigator.pop(context);
                                                    //     },
                                                    //     child: Text('Save'),
                                                    //   )
                                                    // ];
                                                  }
                                                );
                                              }, 
                                              child: Text('Pick Color'), 
                                            ),
                                            SizedBox(height: 16.0),
                                            Text('Foto Bukti Transfer'),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                _pickFile();
                                              },
                                              child: Text('Pick and Open File'),
                                            ),
                                            if (_pickFile != null)
                                            Text('Bukti Transfer: $_fileName')
                                          ],
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () {
                                              Contact updatedContact = Contact(
                                                name: _nameController.text,
                                                phone: _phoneController.text,
                                                color: _currentColor,
                                                fileName: _fileName,
                                              );
                                              contactProvider.updateContact(index, updatedContact);
                                              Navigator.pop(context); 
                                            },
                                            child: Text('Update'),
                                          )
                                        ],
                                      );
                                    }
                                  );
                                }, 
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

void _pickFile() async {
  final result = await FilePicker.platform.pickFiles();
   if (result == null) return;
   _fileName = result.files.single.name;
   final file = result.files.first;
   setState(() {
     _pickedFile = file;
   });
   print('ini file name : $_fileName');
  }
}

class Contact {
  String name;
  String phone;
  Color color;
  var fileName;

  Contact({
    required this.name,
    required this.phone,
    required this.color,
    required this.fileName,
  });
}

class ContactProvider extends ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners(); // Memberi tahu listener bahwa state telah berubah.
  }

  void removeContact(int index) {
    _contacts.removeAt(index);
    notifyListeners(); // Memberi tahu listener bahwa state telah berubah.
  }

  void updateContact(int index, Contact updatedContact) {
    if (index >= 0 && index < _contacts.length) {
      _contacts[index] = updatedContact;
      notifyListeners();
    }
  }
}
