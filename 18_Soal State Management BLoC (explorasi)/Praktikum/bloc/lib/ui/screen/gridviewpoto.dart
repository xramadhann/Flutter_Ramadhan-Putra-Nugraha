import 'package:flutter/material.dart';
import 'detailpoto.dart';

class gridviewpoto extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/p1.png',
    'assets/images/p2.png',
    'assets/images/p3.png',
    'assets/images/p4.jpeg',
    'assets/images/5.jpeg',
    'assets/images/p6.jpeg',
    'assets/images/p7.jpeg',
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
              elevation: 2.0,
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
              ListTile(
                title: Text('Ya'),
                onTap: () {
                  Navigator.of(context).pop(); 
                  _navigateToNewPage(context); 
                },
              ),
              ListTile(
                title: Text('Tidak'),
                onTap: () {
                  Navigator.of(context).pop(); 
                },
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
        builder: (context) => DetailPoto(imagePath: imagePaths[_selectedImageIndex]),
      ),
    );
  }
}
