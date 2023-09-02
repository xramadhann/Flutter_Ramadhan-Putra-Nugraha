import 'dart:io';

void main() async {
  stdout.write("Masukkan bilangan untuk menghitung faktorial: ");
  int n = int.parse(stdin.readLineSync()!);

  try {
    int hasil = await hitungFaktorial(n);
    print("Faktorialnya adalah $hasil");
  } catch (error) {
    print("Terjadi kesalahan: $error");
  }
}

Future<int> hitungFaktorial(int n) async {
  if (n < 0) {
    throw Exception("Bilangan tidak boleh negatif");
  }

  int faktorial = 1;
  for (int i = 1; i <= n; i++) {
    faktorial *= i;
  }
  return faktorial;
}
