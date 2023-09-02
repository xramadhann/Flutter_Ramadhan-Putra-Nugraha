import 'dart:async';

Future<List<int>> multiListAsync(List<int> dataList, int multiplier) async {
  List<int> hasilPerkalian = [];

  for (int number in dataList) {
    int hasil = number * multiplier;
    hasilPerkalian.add(hasil);

    print("Perkalian $number * $multiplier = $hasil");

    await Future.delayed(Duration(seconds: 1));
  }

  return hasilPerkalian;
}

Future<void> main() async {
  List<int> data = [1, 2, 3, 4, 5];
  int pengali = 2;

  List<int> hasilPerkalian = await multiListAsync(data, pengali);
  print("Hasil perkaliannya adalah: $hasilPerkalian");
}
