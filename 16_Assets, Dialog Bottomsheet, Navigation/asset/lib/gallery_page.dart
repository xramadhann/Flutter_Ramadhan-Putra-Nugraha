import 'package:flutter/material.dart';

import 'image_page.dart';

class GaleryPage extends StatefulWidget {
  const GaleryPage({Key? key}) : super(key: key);

  @override
  _GaleryPageState createState() => _GaleryPageState();
}

class _GaleryPageState extends State<GaleryPage> {
  final List<Picture> _pictures = [
    Picture(1, "Picture 01", "subtitle 01", "assets/images/picture-01.jpg"),
    Picture(2, "Picture 02", "subtitle 02", "assets/images/picture-02.jpg"),
    Picture(3, "Picture 03", "subtitle 03", "assets/images/picture-03.jpg"),
    Picture(4, "Picture 04", "subtitle 04", "assets/images/picture-04.jpg"),
    Picture(5, "Picture 05", "subtitle 05", "assets/images/picture-05.jpg"),
    Picture(6, "Picture 06", "subtitle 06", "assets/images/picture-06.jpg"),
    Picture(7, "Picture 07", "subtitle 07", "assets/images/picture-07.jpg"),
    Picture(8, "Picture 08", "subtitle 08", "assets/images/picture-08.jpg"),
    Picture(9, "Picture 09", "subtitle 09", "assets/images/picture-09.jpg"),
    Picture(10, "Picture 10", "subtitle 10", "assets/images/picture-10.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Gallery'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                if (ModalRoute.of(context)?.settings.name != '/') {
                  Navigator.pushNamed(context, '/');
                }
              },
              child: const ListTile(
                title: Text("Home"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                if (ModalRoute.of(context)?.settings.name != '/contacts') {
                  Navigator.pushNamed(context, '/contacts');
                }
              },
              child: const ListTile(
                title: Text("Contacts"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                if (ModalRoute.of(context)?.settings.name != '/gallery') {
                  Navigator.pushNamed(context, '/gallery');
                }
              },
              child: const ListTile(
                title: Text("Gallery"),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(8),
          childAspectRatio: 1,
          children: _pictures.map((picture) {
            return _buildPictureItem(picture);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildPictureItem(Picture picture) {
    return GestureDetector(
      onTap: () {
        _showPictureDetail(context, picture);
      },
      child: FittedBox(
        fit: BoxFit.contain,
        alignment: Alignment.center,
        child: Image.asset(picture.assetName),
      ),
    );
  }

  void _showPictureDetail(BuildContext context, Picture picture) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(picture.assetName),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Tidak'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _navigateToDetailPage(context, picture);
                    },
                    child: const Text('Ya'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToDetailPage(BuildContext context, Picture picture) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageView(imageAsset: picture.assetName),
      ),
    );
  }
}

class Picture {
  Picture(this.id, this.title, this.subtitle, this.assetName);
  final id;
  final title;
  final subtitle;
  final assetName;
}
