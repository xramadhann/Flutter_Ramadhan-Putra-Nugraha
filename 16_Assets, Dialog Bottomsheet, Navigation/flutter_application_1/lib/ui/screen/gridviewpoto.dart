import 'package:flutter/material.dart';
import 'detailpoto.dart';

class gridviewpoto extends StatefulWidget {
  gridviewpoto({super.key});

  @override
  State<gridviewpoto> createState() => _gridviewpotoState();
}

class _gridviewpotoState extends State<gridviewpoto> {
  final List<String> imagePaths = [
    'assets/images/Harimau.png',
    'assets/images/Wolf.png',
    'assets/images/Panda.png',
    'assets/images/Harimau.png',
    'assets/images/Wolf.png',
    'assets/images/Panda.png',
  ];

  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Galeri'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Jumlah kolom dalam grid
        ),
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _selectedImageIndex = index; // Setel indeks yang dipilih
              _showOptionsDialog(context);
            },
            child: Card(
              color: Colors.white.withOpacity(0),
              elevation: 0,
              margin: EdgeInsets.all(8.0),
              child: Image.asset(
                imagePaths[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  void _showOptionsDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Apakah ingin melihat gambar dengan detail?',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Image.asset(
                imagePaths[_selectedImageIndex],
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _navigateToNewPage(context);
                },
                child: Text('Ya, Lihat Detail'),
              ),
              SizedBox(height: 8.0), // Spasi antara tombol
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tidak'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToNewPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DetailPoto(imagePath: imagePaths[_selectedImageIndex]),
      ),
    );
  }
}
