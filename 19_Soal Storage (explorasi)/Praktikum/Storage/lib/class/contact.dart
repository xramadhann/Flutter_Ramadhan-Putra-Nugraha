import 'package:flutter/material.dart';

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
