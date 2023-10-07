import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'gridviewpoto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ContactBloc(),
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
    // Ambil instance dari ContactBloc
    final contactBloc = BlocProvider.of<ContactBloc>(context);

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
                  contactBloc.add(AddContact(
                    name: _nameController.text,
                    phone: _phoneController.text,
                    color: _currentColor,
                    fileName: _fileName,
                  ));

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
                    BlocBuilder<ContactBloc, ContactState>(
                      builder: (context, state) {
                        if (state is ContactLoaded) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.contacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              final contact = state.contacts[index];
                              return ListTile(
                                title: Text(contact.name),
                                subtitle: Column(
                                  children: [
                                    Text(
                                      'Nomor Telp: ${contact.phone}  | Tanggal : ${DateFormat('dd-MM-yyyy').format(currentDate)}',
                                    ),
                                    Row(
                                      children: [
                                        Text(' Warna Tiket : '),
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Container(
                                            color: contact.color,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Bukti Transfer : ${contact.fileName}',
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        contactBloc.add(RemoveContact(index));
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
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

// Definisikan event untuk BLoC
abstract class ContactEvent {}

class AddContact extends ContactEvent {
  final String name;
  final String phone;
  final Color color;
  final String fileName;

  AddContact({
    required this.name,
    required this.phone,
    required this.color,
    required this.fileName,
  });
}

class RemoveContact extends ContactEvent {
  final int index;

  RemoveContact(this.index);
}

class UpdateContact extends ContactEvent {
  final int index;
  final Contact updatedContact;

  UpdateContact(this.index, this.updatedContact);
}

// Definisikan state untuk BLoC
abstract class ContactState {}

class ContactInitial extends ContactState {}

class ContactLoaded extends ContactState {
  final List<Contact> contacts;

  ContactLoaded({required this.contacts});
}

// Buat BLoC
class ContactBloc extends Bloc<ContactEvent, ContactState> {
  List<Contact> _contacts = [];

  ContactBloc() : super(ContactInitial());

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is AddContact) {
      _contacts.add(Contact(
        name: event.name,
        phone: event.phone,
        color: event.color,
        fileName: event.fileName,
      ));

      yield ContactLoaded(contacts: _contacts);
    } else if (event is RemoveContact) {
      if (event.index >= 0 && event.index < _contacts.length) {
        _contacts.removeAt(event.index);
        yield ContactLoaded(contacts: _contacts);
      }
    } else if (event is UpdateContact) {
      if (event.index >= 0 && event.index < _contacts.length) {
        _contacts[event.index] = event.updatedContact;
        yield ContactLoaded(contacts: _contacts);
      }
    }
  }
}
