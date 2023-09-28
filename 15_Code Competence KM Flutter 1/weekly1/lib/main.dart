import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ContactUsApp());
}

class ContactUsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Us',
      home: ContactUsScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _notification = "";

  final ScrollController _scrollController = ScrollController();

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Validasi sukses, tampilkan notifikasi
      setState(() {
        _notification =
            'Name: ${_firstNameController.text}\nEmail: ${_emailController.text}\nMessage: ${_messageController.text}';
      });
      _showConfirmationDialog();

      // Mengosongkan teks dalam TextField
      _firstNameController.clear();
      _lastNameController.clear();
      _emailController.clear();
      _messageController.clear();
    } else {
      // Tampilkan pesan kesalahan jika validasi gagal
      setState(() {
        _notification = "There are errors in the form";
      });
    }
  }

  String? _validateName(String? value) {
    if (_firstNameController.text.isEmpty) {
      return 'Name must be filled in';
    }
    return null;
  }

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Tidak bisa menutup dialog dengan mengklik di luar
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to submit the form?'),
                Text(_notification), // Menampilkan notifikasi di dalam dialog
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'XRamadhannForm',
          style: GoogleFonts.righteous(
            fontSize: 20.0,
            color: Colors.black, // Mengatur warna teks
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Positioned(
              child: Text(
                'Welcome to',
                style: GoogleFonts.fugazOne(
                    fontSize: 54.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange),
              ),
            ),
            SizedBox(height: 35.0),
            Positioned(
              child: Text(
                'XRamadhannForm',
                style: GoogleFonts.righteous(
                  fontSize: 30.0,
                  height: -1.1,
                ),
              ),
            ),
            Image.asset(
              'Harimau.png',
              height: 500,
            ),
            GestureDetector(
              onTap: () {
                final double offset = MediaQuery.of(context).size.height;
                _scrollController.animateTo(offset,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: Text(
                'Touch Me to Contact Us',
                style: GoogleFonts.poppins(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 150.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Contact us',
                  style: GoogleFonts.poppins(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  style: GoogleFonts.poppins(
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            maxLines: 2,
                            decoration: InputDecoration(
                                labelText: 'First Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 217, 217, 217),
                                iconColor: Colors.white),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            validator: _validateName,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 217, 217, 217),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            validator: (value) {
                              if (_firstNameController.text.isEmpty) {
                                return ' ';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _emailController,
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 217, 217, 217),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Email must be filled in';
                        } else if (!(value?.contains('@') ?? false)) {
                          return 'Email is not valid';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _messageController,
                      maxLines: 6,
                      decoration: InputDecoration(
                        labelText: 'Message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 217, 217, 217),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Message must be filled in';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          foregroundColor: Colors.white),
                    ),
                    SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.centerLeft,
                    ),
                    SizedBox(height: 70.0),
                    Text(
                      _notification,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 255, 17, 0),
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
