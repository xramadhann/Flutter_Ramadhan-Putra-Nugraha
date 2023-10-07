import 'package:flutter/material.dart';

import 'package:testing_app/class/contact.dart';

class ContactProvider extends ChangeNotifier {
  final List<Contact> _contacts = [];
  Color pickerColor = Colors.black;
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
    final String name = nameController.text.trim();
    final String contact = contactController.text.trim();

    isNameValid = validateName(name);
    isContactValid = validatePhoneNumber(contact);

    notifyListeners();
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
