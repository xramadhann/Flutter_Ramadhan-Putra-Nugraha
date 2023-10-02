import 'package:flutter/material.dart';

class DetailPoto extends StatelessWidget {
  final String imagePath;

  DetailPoto({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Gambar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16), // Spacer antara gambar dan teks
          Text(
            'Deskripsi Gambar',
            style: TextStyle(
              fontSize: 18, // Sesuaikan dengan ukuran yang Anda inginkan
              fontWeight:
                  FontWeight.bold, // Sesuaikan dengan gaya yang Anda inginkan
            ),
          ),
        ],
      ),
    );
  }
}
