import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => HomePage(),
        '/contacts': (context) => const ContactsPage(),
        '/gallery': (context) => const GalleryPage(),
        '/images': (context) => const ImageView(imageAsset: ''),
      },
    );
  }
}

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

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List data = [
    {
      'name': 'Lewis Hamilton',
      'number': '(717) 550-1675',
    },
    // ... (your other data items)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MaterialApp'),
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
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 25,
              child: Text(
                data[index]['name'][0],
                style: const TextStyle(fontSize: 24),
              ),
            ),
            title: Text(
              data[index]['name'],
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              data[index]['number'],
              style: const TextStyle(fontSize: 16),
            ),
            onTap: () {},
          );
        },
        itemCount: data.length,
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
            color: Colors.grey,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final List<Picture> _pictures = [
    Picture(1, "Picture 01", "subtitle 01",
        "https://w0.peakpx.com/wallpaper/481/11/HD-wallpaper-jade-on-purple-aesthetic-in-2022-jdm-best-jdm-cars-car-thumbnail.jpg"),
    // ... (gambar lainnya)
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
        child: Image.network(picture.assetName),
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
              Image.network(picture.assetName),
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

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final List<Contact> contacts = [];
  DateTime? selectedDate;
  Color pickerColor = Colors.black;
  String? selectedFilePath;

  int selectedIndex = -1;
  bool isNameValid = true;
  bool isContactValid = true;

  void validateInput() {
    final String name = nameController.text.trim();
    final String contact = contactController.text.trim();

    setState(() {
      isNameValid = validateName(name);
      isContactValid = validatePhoneNumber(contact);
    });

    if (isNameValid && isContactValid) {
      setState(() {
        if (selectedIndex == -1) {
          _addContact(name, contact);
        } else {
          _updateContact(name, contact);
        }
      });
    }
  }

  void _addContact(String name, String contact) {
    nameController.text = '';
    contactController.text = '';
    contacts.add(
      Contact(
        name: name,
        contact: contact,
        date: selectedDate,
        color: pickerColor,
        filePath: selectedFilePath,
      ),
    );
  }

  void _updateContact(String name, String contact) {
    contacts[selectedIndex].name = name;
    contacts[selectedIndex].contact = contact;
    contacts[selectedIndex].date = selectedDate;
    contacts[selectedIndex].color = pickerColor;
    contacts[selectedIndex].filePath = selectedFilePath;
    selectedIndex = -1;
    nameController.text = '';
    contactController.text = '';
    selectedDate = null;
    pickerColor = Colors.black;
    selectedFilePath = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Contacts'),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Center(
                child: Icon(Icons.contacts),
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Create New Contacts',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Lorem ipsum dolor sit amet, sed do magna aliqua. Ut enim ad minim veniam, quis nostrud ex ea commodo consequat. Duis aute in repreh null pariatur.',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            _buildNameTextField(),
            const SizedBox(height: 10),
            _buildContactTextField(),
            const SizedBox(height: 10),
            _buildButtonsRow(),
            const SizedBox(height: 10),
            const Text(
              'List Contacts',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: _buildContactList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextField(
      controller: nameController,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        hintText: 'Contact Name',
        labelText: 'Contact Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: isNameValid ? Colors.grey : Colors.red,
          ),
        ),
        errorText: isNameValid ? null : 'Name invalid',
        prefixIcon: const Icon(Icons.person),
      ),
    );
  }

  Widget _buildContactTextField() {
    return TextField(
      controller: contactController,
      keyboardType: TextInputType.number,
      maxLength: 15,
      decoration: InputDecoration(
        hintText: 'Contact Number',
        labelText: 'Contact Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        errorText: isContactValid ? null : 'Number invalid',
        prefixIcon: const Icon(Icons.phone),
      ),
    );
  }

  Widget _buildButtonsRow() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: _pickDate,
              child: Text(
                selectedDate == null
                    ? 'Pick date'
                    : DateFormat('dd MMM yyyy').format(selectedDate!),
              ),
            ),
            ElevatedButton(
              onPressed: _pickColor,
              style: ElevatedButton.styleFrom(
                backgroundColor: pickerColor,
              ),
              child: const Text('Pick color'),
            ),
            ElevatedButton(
              onPressed: _pickFile,
              child: const Text('Pick file'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                validateInput();
                if (isNameValid && isContactValid) {
                  setState(() {
                    selectedDate = null;
                    pickerColor = Colors.black;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add to list contact'),
                    ),
                  );
                }
              },
              child: Text(selectedIndex == -1 ? 'Submit' : 'Update'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactList() {
    return ListView.builder(
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        return _buildContactCard(index);
      },
    );
  }

  Widget _buildContactCard(int index) {
    Color contactColor = contacts[index].color;

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: contactColor,
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(contacts[index].contact),
            Text(contacts[index].date != null
                ? DateFormat.yMMMd().format(contacts[index].date!)
                : 'No date selected'),
            Row(
              children: [
                const Text('Color: '),
                Container(
                  color: contactColor,
                  height: 15,
                  width: 15,
                ),
              ],
            ),
            Text('File: ${contacts[index].filePath ?? 'Not selected'}'),
          ],
        ),
        trailing: SizedBox(
          width: 50,
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  nameController.text = contacts[index].name;
                  contactController.text = contacts[index].contact;
                  setState(() {
                    selectedIndex = index;
                    selectedDate = contacts[index].date;
                    pickerColor = contacts[index].color;
                    selectedFilePath = contacts[index].filePath;
                  });
                },
                child: const Icon(Icons.edit),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    contacts.removeAt(index);
                  });
                },
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2101),
    ).then(
      (date) {
        if (date != null) {
          setState(() {
            selectedDate = date;
          });
        }
      },
    );
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                setState(() {
                  pickerColor = color;
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String? path = result.files.single.path;
      if (path != null) {
        String fileName = path.split('/').last;

        setState(() {
          selectedFilePath = fileName;
        });
      }
    }
  }

  bool validateName(String name) {
    if (name.isEmpty) return false;
    const namePattern = r"^[A-Z][a-zA-Z]+(?: [A-Z][a-zA-Z]+)*$";
    final regExp = RegExp(namePattern);
    return regExp.hasMatch(name);
  }

  bool validatePhoneNumber(String phone) {
    if (phone.isEmpty) return false;
    const phonePattern = r"^(0[0-9]{7,14})$";
    final regExp = RegExp(phonePattern);
    return regExp.hasMatch(phone);
  }
}

class Contact {
  String name;
  String contact;
  DateTime? date;
  Color color;
  String? filePath;

  Contact({
    required this.name,
    required this.contact,
    this.date,
    required this.color,
    this.filePath,
  });
}
