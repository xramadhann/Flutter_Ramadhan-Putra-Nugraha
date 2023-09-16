import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var dropDownValue = 0;
  bool checkValueDart = false;
  bool checkValuePHP = false;
  bool checkValueHTML = false;
  bool checkValueCSS = false;
  var inputController = TextEditingController();
  var radioValue = '';
  List<Map<String, String>> dataKontak = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Contoh MaterialApp"),
        ),
        body: Container(
          color: const Color.fromARGB(255, 216, 216, 216),
          margin: EdgeInsets.only(top: 30, right: 20, left: 20),
          child: Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ramadhan"),
                    Text("Putra"),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('List Anak Didik'),
                TextField(
                  controller: inputController,
                  onChanged: (input) {
                    print('$input');
                  },
                ),
                Row(
                  children: [
                    Radio(
                      value: 'Laki-laki',
                      groupValue: radioValue,
                      onChanged: (value) {
                        setState(() {
                          radioValue = value.toString();
                          print('Nilai dari radio value = $radioValue');
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
                      onChanged: (value) {
                        setState(() {
                          radioValue = value.toString();
                          print('Nilai dari radio value = $radioValue');
                        });
                      },
                    ),
                    Text('Perempuan'),
                  ],
                ),
                // Checkbox menggunakan CheckboxListTile
                Divider(),
                CheckboxListTile(
                  value: checkValueDart,
                  onChanged: (value) {
                    setState(() {
                      checkValueDart = value ?? false;
                      print('Bahasa Pemrograman Dart = $checkValueDart');
                    });
                  },
                  title: Text('Dart'),
                ),
                CheckboxListTile(
                  value: checkValuePHP,
                  onChanged: (value) {
                    setState(() {
                      checkValuePHP = value ?? false;
                      print('Bahasa Pemrograman PHP = $checkValuePHP');
                    });
                  },
                  title: Text('PHP'),
                ),
                CheckboxListTile(
                  value: checkValueHTML,
                  onChanged: (value) {
                    setState(() {
                      checkValueHTML = value ?? false;
                      print('Bahasa Pemrograman HTML = $checkValueHTML');
                    });
                  },
                  title: Text('HTML'),
                ),
                CheckboxListTile(
                  value: checkValueCSS,
                  onChanged: (value) {
                    setState(() {
                      checkValueCSS = value ?? false;
                      print('Bahasa Pemrograman CSS = $checkValueCSS');
                    });
                  },
                  title: Text('CSS'),
                ),
                Divider(),
                DropdownButton(
                  value: dropDownValue,
                  items: [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Pilihan 1'),
                    ),
                    DropdownMenuItem(value: 1, child: Text('Pilihan 2')),
                    DropdownMenuItem(value: 2, child: Text('Pilihan 3'))
                  ],
                  onChanged: (value) {
                    setState(() {
                      dropDownValue = value as int;
                      print('$dropDownValue');
                    });
                  },
                ),
                ElevatedButton(
                  child: Text('Submit'),
                  onPressed: () {
                    setState(() {
                      dataKontak.add({
                        "title": "${inputController.text}",
                        "jenis_kelamin": "$radioValue",
                        "bahasa_pemrograman": "${_getSelectedLanguages()}",
                      });

                      // Reset input
                      inputController.clear();
                      radioValue = '';
                      checkValueDart = false;
                      checkValuePHP = false;
                      checkValueHTML = false;
                      checkValueCSS = false;
                    });

                    print('dataKontak : $dataKontak');
                  },
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: dataKontak.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: FlutterLogo(),
                        title: Text('${dataKontak[index]["title"]}'),
                        subtitle: Text(
                            'Jenis Kelamin: ${dataKontak[index]["jenis_kelamin"]}, Bahasa Pemrograman: ${dataKontak[index]["bahasa_pemrograman"]}'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getSelectedLanguages() {
    List<String> selectedLanguages = [];
    if (checkValueDart) selectedLanguages.add('Dart');
    if (checkValuePHP) selectedLanguages.add('PHP');
    if (checkValueHTML) selectedLanguages.add('HTML');
    if (checkValueCSS) selectedLanguages.add('CSS');
    return selectedLanguages.join(', ');
  }
}
