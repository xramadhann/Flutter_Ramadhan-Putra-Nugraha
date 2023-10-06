import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyForm(),
      theme: ThemeData(),
    );
  }
}

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
  Color _currentColor = Colors.blue;
  PlatformFile? _pickedFile;
  var _fileName = '';
  String? _username;

  _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      setState(() {
        _username = username;
      });
    }
  }

  _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    _fileName = result.files.single.name;
    final file = result.files.first;
    setState(() {
      _pickedFile = file;
    });
    print('ini file name : $_fileName');
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Contact'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName:
                  Text(_username ?? 'Username'), // Gunakan _username di sini
              accountEmail: null,
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.blue,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Pengaturan'),
              onTap: () {
                // Tambahkan aksi ketika pengguna menekan pengaturan di sini
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Keluar'),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Kontak XRamadhann',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Nomor Telephone',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tanggal Hari ini:',
                          style: TextStyle(fontSize: 18.0),
                        ),
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
                          child: Text(
                            'Pilih Tanggal',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      DateFormat('dd MMMM yyyy').format(_dueDate),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Warna Kontak:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      height: 100,
                      width: double.infinity,
                      color: _currentColor,
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Warna Kontak',
                                style: TextStyle(fontSize: 20.0),
                              ),
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
                                  child: Text(
                                    'Simpan',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Pilih Warna',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: _currentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Foto Profile',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        _pickFile();
                      },
                      child: Text(
                        'Pilih dan Buka File',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    if (_pickedFile != null) Text('Foto Profile: $_fileName'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String name = _nameController.text;
                String phone = _phoneController.text;
                Color color = _currentColor;
                var fileName = _fileName;
                Contact newContact = Contact(
                  name: name,
                  phone: phone,
                  color: color,
                  fileName: fileName,
                );
                setState(() {
                  _contacts.add(newContact);
                });
                _nameController.clear();
                _phoneController.clear();
                setState(() {
                  _pickedFile = null;
                  _fileName = '';
                });
              },
              child: Text(
                'Simpan',
                style: TextStyle(fontSize: 18.0),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'List Kontak',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _contacts.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 3.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(
                      _contacts[index].name,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomor Telephone: ${_contacts[index].phone}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Row(
                          children: [
                            Text(
                              'Warna Kontak: ',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              color: _contacts[index].color,
                            ),
                          ],
                        ),
                        Text(
                          'Foto Profile: ${_contacts[index].fileName}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          _contacts.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
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

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  _handleLogin() async {
    if (_usernameController.text == "username" &&
        _passwordController.text == "username") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyForm(),
      ));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Gagal"),
            content: Text("Username atau Password salah."),
            actions: <Widget>[
              TextButton(
                child: Text("Tutup"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 24.0,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
