import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apiResponse = ''; // Variabel untuk menyimpan respons dari API

  @override
  void initState() {
    super.initState();
    _makeApiCall(); // Panggil API saat halaman pertama kali dimuat
  }

  // Metode untuk melakukan panggilan API
  void _makeApiCall() async {
    try {
      final response = await Dio()
          .get('https://api.dicebear.com/7.x/pixel-art/svg?seed=John');

      if (response.statusCode == 200) {
        // Jika panggilan API berhasil
        final responseData =
            response.data.toString(); // Respons dari API berupa string

        setState(() {
          apiResponse = responseData;
        });
      } else {
        // Jika panggilan API tidak berhasil
        print('Gagal melakukan panggilan API');
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi
      print('Terjadi kesalahan: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                apiResponse.isNotEmpty
                    ? SvgPicture.string(
                        apiResponse,
                        width: 200, // Atur lebar gambar menjadi 200 piksel
                        height: 200, // Atur tinggi gambar menjadi 200 piksel
                      )
                    : CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
