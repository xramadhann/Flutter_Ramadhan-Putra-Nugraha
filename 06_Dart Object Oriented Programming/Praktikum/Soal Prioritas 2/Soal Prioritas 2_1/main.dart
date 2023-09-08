import 'dart:io';
import 'kalkulator.dart';

void main() {
  Kalculator calculator = Kalculator();

  stdout.write("Masukkan nilai pertama  : ");
  double num1 = double.parse(stdin.readLineSync()!);

  stdout.write("Masukkan nilai kedua    : ");
  double num2 = double.parse(stdin.readLineSync()!);

  print("Penjumlahan  : ${calculator.penjumlahan(num1, num2)}");
  print("Pengurangan  : ${calculator.pengurangan(num1, num2)}");
  print("Perkalian    : ${calculator.perkalian(num1, num2)}");

  try {
    print("Pembagian    : ${calculator.pembagian(num1, num2)}");
  } catch (e) {
    print(e);
  }
}
