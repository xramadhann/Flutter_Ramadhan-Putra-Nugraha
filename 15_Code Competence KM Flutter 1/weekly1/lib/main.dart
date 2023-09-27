import 'package:flutter/material.dart';

class Seat {
  final String id;
  bool isOccupied;

  Seat(this.id, this.isOccupied);
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transportation App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.orangeAccent,
        ),
        fontFamily: 'Roboto',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transportation App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WelcomeSection(),
            Column(
              children: [
                Image.asset('assets/your_logo.png', height: 80.0),
                SizedBox(height: 10.0),
                Text(
                  'Selamat Datang di Transportasi Perusahaan Kami',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          children: [
                            Text(
                              'Hubungi Kami:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ContactUsForm(),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingFormPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orangeAccent,
                        ),
                        child: Text(
                          'Pesan Sekarang',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeSection extends StatefulWidget {
  @override
  _WelcomeSectionState createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection> {
  bool showWelcome = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        showWelcome = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showWelcome) {
      return Container(
        color: Colors.blue,
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/your_logo.png', height: 100.0),
              SizedBox(height: 10.0),
              Text(
                'Nama Perusahaan Anda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

class BookingFormPage extends StatefulWidget {
  @override
  _BookingFormPageState createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? selectedRoute;
  Seat? selectedSeat;

  List<String> routes = ['Rute A', 'Rute B', 'Rute C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pemesanan'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Text(
            'Isi Form Pemesanan:',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: firstNameController,
            decoration: InputDecoration(
              labelText: 'Nama Awal',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: lastNameController,
            decoration: InputDecoration(
              labelText: 'Nama Akhir',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10.0),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              labelText: 'Nomor Telepon',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20.0),
          DropdownButtonFormField<String>(
            value: selectedRoute,
            onChanged: (value) {
              setState(() {
                selectedRoute = value;
              });
            },
            items: routes.map((route) {
              return DropdownMenuItem(
                value: route,
                child: Text(route),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Rute',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Silahkan Pilih Kursi Anda:',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 10.0),
          SeatSelection(selectedSeat: selectedSeat),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              String firstName = firstNameController.text;
              String lastName = lastNameController.text;
              String email = emailController.text;
              String phone = phoneController.text;
              String route = selectedRoute ?? 'Belum Dipilih';
              String selectedSeatId = selectedSeat?.id ?? 'Belum Dipilih';

              print('Nama Awal: $firstName');
              print('Nama Akhir: $lastName');
              print('Email: $email');
              print('No. Telepon: $phone');
              print('Rute: $route');
              print('Kursi: $selectedSeatId');
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.orangeAccent,
            ),
            child: Text(
              'Kirim Pesan',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SeatSelection extends StatefulWidget {
  Seat? selectedSeat;

  SeatSelection({required this.selectedSeat});

  @override
  _SeatSelectionState createState() => _SeatSelectionState();
}

class _SeatSelectionState extends State<SeatSelection> {
  List<Seat> seats = [
    Seat('A1', false),
    Seat('A2', false),
    Seat('B1', false),
    Seat('B2', false),
    Seat('C1', false),
    Seat('C2', false),
    Seat('D1', false),
    Seat('D2', false),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: seats.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Seat seat = seats[index];
        return SeatButton(
          seat: seat,
          onPressed: () {
            setState(() {
              if (!seat.isOccupied) {
                if (widget.selectedSeat != null) {
                  widget.selectedSeat!.isOccupied = false;
                }
                seat.isOccupied = true;
                widget.selectedSeat = seat;
              } else {
                // Jika kursi sudah terisi dan di-klik kembali, maka batalkan pemilihan.
                seat.isOccupied = false;
                widget.selectedSeat = null;
              }
            });
          },
        );
      },
    );
  }
}

class SeatButton extends StatelessWidget {
  final Seat seat;
  final VoidCallback onPressed;

  SeatButton({
    required this.seat,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: seat.isOccupied ? Colors.grey : Colors.green,
        padding: EdgeInsets.all(8.0),
        minimumSize: Size(40, 40),
      ),
      child: Text(
        seat.id,
        style: TextStyle(
          fontSize: 12.0,
        ),
      ),
    );
  }
}

class ContactUsForm extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Nama',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: messageController,
          decoration: InputDecoration(
            labelText: 'Pesan',
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
        ),
        SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () {
            String name = nameController.text;
            String email = emailController.text;
            String message = messageController.text;

            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Pesan Terkirim'),
                  content: Text('Nama: $name\nEmail: $email\nPesan: $message'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.orangeAccent,
          ),
          child: Text(
            'Kirim Pesan',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
