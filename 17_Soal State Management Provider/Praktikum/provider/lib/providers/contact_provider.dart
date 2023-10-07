import 'package:flutter/material.dart';
import 'package:testing_app/class/contact.dart';

class ContactProvider extends ChangeNotifier {
  final List<Contact> _contacts = [];
  Color pickerColor = Colors.blue;
  DateTime? selectedDate;
  String? selectedFilePath;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  int selectedIndex = -1;
  bool isNameValid = true;
  bool isContactValid = true;

  List<Contact> get contacts => _contacts;

  // untuk menambahkan kontak
  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  // untuk menghapus kontak
  void removeContact(Contact contact) {
    _contacts.remove(contact);
    notifyListeners();
  }

  // untuk mengupdate kontak
  void updateContact(int index, Contact contact) {
    _contacts[index] = contact;
    notifyListeners();
  }

  // untuk mengatur warna yang dipilih
  void setPickerColor(Color color) {
    pickerColor = color;
    notifyListeners();
  }

  // untuk mengatur tanggal yang dipilih
  void setSelectedDate(DateTime? date) {
    selectedDate = date;
    notifyListeners();
  }

  // untuk mengatur path file yang dipilih
  void setSelectedFilePath(String? filePath) {
    selectedFilePath = filePath;
    notifyListeners();
  }

  // untuk mengatur selected index
  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  // untuk validasi input
  void validateInput() {
    // You can remove the validation logic here
    notifyListeners();
  }
}
