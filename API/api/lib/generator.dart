import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MaterialApp(
    home: ImageGenerator(),
  ));
}

class ImageGenerator extends StatefulWidget {
  @override
  _ImageGeneratorState createState() => _ImageGeneratorState();
}

class _ImageGeneratorState extends State<ImageGenerator> {
  TextEditingController nameController = TextEditingController();
  String imageSvg = ''; // Inisialisasi imageSvg dengan nilai awal kosong

  @override
  void initState() {
    super.initState();
  }

  Future<void> getImage(String name) async {
    String apiUrl;

    if (name == 'Jack') {
      apiUrl = 'https://api.dicebear.com/7.x/adventurer-neutral/svg?seed=Jack';
    } else if (name == 'Smokey') {
      apiUrl =
          'https://api.dicebear.com/7.x/adventurer-neutral/svg?seed=Smokey';
    } else {
      apiUrl = 'https://api.dicebear.com/7.x/adventurer-neutral/svg?seed=Milo';
    }

    try {
      final response = await Dio().get(apiUrl);

      if (response.statusCode == 200) {
        setState(() {
          imageSvg = response.data.toString();
        });
      } else {
        return;
      }
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Generator'),
        backgroundColor: Colors.blue, // Ganti warna latar belakang app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imageSvg.isNotEmpty
                ? Column(
                    children: [
                      Text(
                        'Generated Image:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      SvgPicture.string(
                        imageSvg,
                        width: 200, // Atur lebar gambar
                        height: 200, // Atur tinggi gambar
                      ),
                    ],
                  )
                : Container(),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Enter Name',
                border: OutlineInputBorder(), // Tambahkan border ke input field
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                if (name.isNotEmpty) {
                  getImage(name);
                }
              },
              child: Text('Generate Image'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Ganti warna tombol
                onPrimary: Colors.white, // Ganti warna teks tombol
              ),
            ),
          ],
        ),
      ),
    );
  }
}
