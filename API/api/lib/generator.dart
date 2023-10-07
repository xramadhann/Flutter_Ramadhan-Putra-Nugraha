import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

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
  String imageSvg = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> generateImage(String name) async {
    String apiUrl;

    if (name == 'smokey') {
      apiUrl =
          'https://api.dicebear.com/7.x/adventurer-neutral/svg?seed=Smokey';
    } else if (name == 'milo') {
      apiUrl = 'https://api.dicebear.com/7.x/adventurer-neutral/svg?seed=Milo';
    } else {
      final List<String> apiUrls = [
        'https://api.dicebear.com/7.x/adventurer-neutral/svg?seed=Jack',
        'https://api.dicebear.com/7.x/adventurer-neutral/svg?seed=Pumpkin',
        'https://api.dicebear.com/7.x/adventurer-neutral/svg?seed=Max',
        'https://api.dicebear.com/7.x/adventurer-neutral/svg?seed=Abby',
        'https://api.dicebear.com/7.x/adventurer-neutral/svg?seed=Princess',
        'https://api.dicebear.com/7.x/adventurer-neutral/svg?seed=Jasmine'
      ];

      final random = Random();
      apiUrl = apiUrls[random.nextInt(apiUrls.length)];
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
        backgroundColor: Colors.blue,
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
                        width: 200,
                        height: 200,
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Enter Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                if (name.isNotEmpty) {
                  generateImage(name);
                }
              },
              child: Text('Generate Image'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                onPrimary: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
