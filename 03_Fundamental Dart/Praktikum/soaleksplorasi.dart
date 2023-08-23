void main() {
  String InputKalimat1 = "kasur rusak";
  String InputKalimat2 = "mobil balap";
  String KalimatReversed = InputKalimat1.split('').reversed.join('');
  print("Contoh 1");
  if (InputKalimat1 == KalimatReversed) {
    print("Output : $InputKalimat1 adalah Palindrom");
    print(
        "Penjelasan : $InputKalimat1 jika dibalik adalah $InputKalimat1 sehingga kata ini merupakan kata palindrom.");
  } else {
    print("Tidak Palindrom");
  }
  print(" ");
  print("Contoh 2");
  if (InputKalimat2 == KalimatReversed) {
    print("Output : $InputKalimat2 adalah Palindrom");
    print(
        "Penjelasan : $InputKalimat2 jika dibalik adalah $InputKalimat2 sehingga kata ini merupakan kata palindrom.");
  } else {
    print("Output : $InputKalimat2 adalah Tidak Palindrom");
    print(
        "Penjelasan : $InputKalimat2 jika dibalik adalah bukan $InputKalimat2 sehingga kata ini merupakan bukan kata palindrom.");
  }
}
