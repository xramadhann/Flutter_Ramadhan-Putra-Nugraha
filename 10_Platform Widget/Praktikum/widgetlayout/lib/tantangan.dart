import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<Map<String, dynamic>> data_kontak = [
  {
    "title": "Kepala SUku",
    "jenis_kelamin": "Laki-laki",
  },
  {
    "title": "Guru Bahasa Cinta",
    "jenis_kelamin": "perempuan",
  },
  {
    "title": "Bendahara Sekolah",
    "jenis_kelamin": "Laki-laki",
  },
  {"title": "Guru Matematika", "jenis_kelamin": "Perempuan"},
  {"title": "Guru Biologi", "jenis_kelamin": "Laki-laki"}
];

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HelloWorld();
  }
}

class HelloWorld extends StatefulWidget {
  const HelloWorld({super.key});

  @override
  State<HelloWorld> createState() => _HelloWorldState();
}

class _HelloWorldState extends State<HelloWorld> {
  var dropDownValue = 0;
  var checkValue = false;
  var inputController = TextEditingController();
  var radioValue = '';
  List<String> checkboxValue = [];
  var isCheckbox1 = false;
  String textFieldData = ''; // Tambahkan ini
  // Dua variabel yang dibuat jika ingin menggunakan date
  DateTime _dueDate = DateTime.now();
  final currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _dueDate) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Muchson App'),
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.grey,
            margin: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () {
                        setState(() {
                          data_kontak.add({
                            "title": "${inputController.text}",
                            "jenis_kelamin": "$radioValue",
                            "skill": "$checkboxValue",
                            "date": DateFormat('yyyy-MM-dd').format(_dueDate),
                          });
                        });

                        print('data_kontak : $data_kontak');
                      },
                    ),
                    TextButton(
                      onPressed: () => _selectDate(context),
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Date: ${DateFormat('yyyy-MM-dd').format(_dueDate)}',
                            style: TextStyle(fontSize: 16),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Text('List Kelas D'),
                TextField(
                  controller: inputController,
                  onChanged: (text) {
                    setState(() {
                      textFieldData = text;
                    });
                  },
                ),
                Row(
                  children: [
                    Radio(
                      value: 'Laki-laki',
                      groupValue: radioValue,
                      onChanged: (String? value) {
                        setState(() {
                          // Logic dari radio button itu dimasukkan
                          radioValue = value ?? '';
                          print('Nilai dari radio value =  $radioValue');
                        });
                      },
                    ),
                    Text('Laki - laki'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 'Perempuan',
                      groupValue: radioValue,
                      onChanged: (String? value) {
                        setState(() {
                          // Logic dari radio button itu dimasukkan
                          radioValue = value ?? '';
                          print('Nilai dari radio value =  $radioValue');
                        });
                      },
                    ),
                    Text('Perempuan'),
                  ],
                ),
                // Checkbox simple
                Divider(),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: data_kontak.length, //3
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: FlutterLogo(),
                        title: Text('${data_kontak[index]["title"]}'),
                        subtitle:
                            Text('${data_kontak[index]["jenis_kelamin"]}'),
                        trailing: Wrap(children: [
                          IconButton(
                            onPressed: () {
                              // Hapus data berdasarkan index
                              setState(() {
                                data_kontak.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () => AlertEdit(context, index),
                            icon: Icon(Icons.edit),
                          ),
                        ]),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> AlertEdit(BuildContext context, int index) async {
    final contact = data_kontak[index]['title'];
    final radioJenisKelamin = data_kontak[index]['jenis_kelamin'];
    TextEditingController nameControllerEdit =
        TextEditingController(text: contact
