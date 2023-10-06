import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'gridviewpoto.dart';

class MyForm extends StatefulWidget {
  const MyForm({Key? key});

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  List<Contact> _contacts = [];
  DateTime _dueDate = DateTime.now();
  final currentDate = DateTime.now();
  Color _currentColor = Colors.orange;
  PlatformFile? _pickedFile;
  String _fileName = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Buat Kontak Baru',
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
              Text('Silahkan membuat kontak baru'),
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
              labelText: 'Nomer Telephone',
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
                          title: const Text('Warna Kontak'),
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
                              child: const Text('Simpan'),
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Pilih Warna'),
                ),
              )
            ],
          ),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Foto Profile Kontak'),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _pickFile();
                  },
                  child: const Text('Pilih File'),
                ),
              ),
              if (_pickedFile != null) Text('Profile: $_fileName'),
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
                  Contact newContact = Contact(
                      name: name,
                      phone: phone,
                      color: color,
                      fileName: fileName);
                  setState(() {
                    _contacts.add(newContact);
                  });
                  _nameController.clear();
                  _phoneController.clear();
                  // Reset picked file
                  setState(() {
                    _pickedFile = null;
                    _fileName = '';
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
          Divider(),
          Column(
            children: <Widget>[
              Text(
                'Kontak Anda',
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
                      itemCount: _contacts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(_contacts[index].name),
                          subtitle: Column(
                            children: [
                              Text(
                                'Nomer Telephone: ${_contacts[index].phone}  | Tanggal : ${DateFormat('dd-MM-yyyy').format(currentDate)}',
                              ),
                              Row(
                                children: [
                                  Text(' Warna Kontak: '),
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Container(
                                      color: _contacts[index].color,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Foto Profile : ${_contacts[index].fileName}',
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _contacts.removeAt(index);
                                  });
                                },
                              ),
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

  Contact(
      {required this.name,
      required this.phone,
      required this.color,
      required this.fileName});
}
