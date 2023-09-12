import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Contoh MaterialApp"),
        ),
        body: Container(
          color: Colors.grey,
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
                Text("List anak didik"),
                SizedBox(
                    height: 500,
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        Text('ADE ALI INDRA'),
                        Text('ALWIN ZUHRIANDI MANALU'),
                        Text('ANISA YUNIARTI'),
                        Text('Bima Pangestu Nugraha'),
                        Text('Dastin Pranata Yuda'),
                        Text('David Christian Hui'),
                        Text('David Liem'),
                        Text('Delia Sepiana'),
                        Text('FAJRUL KAMAL'),
                        Text('GHAZI FARHANU DISASMORO'),
                        Text('HIDAYAH DANIAWATI'),
                        Text('JUHARMANSAH'),
                        Text('KATARINA ANDREA LAURENTIA'),
                        Text('MUHAMMAD AFRIZAL RASYID'),
                        Text('MUHAMMAD ARARYA HAFIZH ATHALLA'),
                        Text('MUHAMMAD ILHAM'),
                        Text('MUHAMMAD NGURAH ARYA PRATAMA'),
                        Text('MUSTIKA CHAIRANI'),
                        Text('NURMALASARI'),
                        Text('Phrimus Nufeto'),
                        Text('PUTRI DIANA HAFSYAWATI'),
                        Text('RACHAEL NATHASYA'),
                        Text('RAFI TAUFIQURAHMAN'),
                        Text('RAMADHAN PUTRA NUGRAHA'),
                        Text('YUNITA ANGGERAINI'),
                        Text('ADE ALI INDRA'),
                        Text('ALWIN ZUHRIANDI MANALU'),
                        Text('ANISA YUNIARTI'),
                        Text('Bima Pangestu Nugraha'),
                        Text('Dastin Pranata Yuda'),
                        Text('David Christian Hui'),
                        Text('David Liem'),
                        Text('Delia Sepiana'),
                        Text('FAJRUL KAMAL'),
                        Text('GHAZI FARHANU DISASMORO'),
                        Text('HIDAYAH DANIAWATI'),
                        Text('JUHARMANSAH'),
                        Text('KATARINA ANDREA LAURENTIA'),
                        Text('MUHAMMAD AFRIZAL RASYID'),
                        Text('MUHAMMAD ARARYA HAFIZH ATHALLA'),
                        Text('MUHAMMAD ILHAM'),
                        Text('MUHAMMAD NGURAH ARYA PRATAMA'),
                        Text('MUSTIKA CHAIRANI'),
                        Text('NURMALASARI'),
                        Text('Phrimus Nufeto'),
                        Text('PUTRI DIANA HAFSYAWATI'),
                        Text('RACHAEL NATHASYA'),
                        Text('RAFI TAUFIQURAHMAN'),
                        Text('RAMADHAN PUTRA NUGRAHA'),
                        Text('YUNITA ANGGERAINI'),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
