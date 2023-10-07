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
      body: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
