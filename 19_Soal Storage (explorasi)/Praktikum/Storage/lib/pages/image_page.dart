import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key, required this.imageAsset}) : super(key: key);
  final String imageAsset;

  static const routeName = '/images';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image"),
      ),
      body: Center(
        child: Image.asset(imageAsset),
      ),
    );
  }
}
