import 'package:flutter/material.dart';

class Contact {
  final String name;
  final String phoneNumber;
  final DateTime date;
  final Color color;
  final List<String> selectedFiles;

  Contact(
    this.name,
    this.phoneNumber,
    this.date,
    this.color,
    this.selectedFiles,
  );
}
