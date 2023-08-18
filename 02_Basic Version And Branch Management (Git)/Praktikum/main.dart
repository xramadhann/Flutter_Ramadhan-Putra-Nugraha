double panjang = 10.5;
double lebar = 9.8;
double sisi = 5.3;

//Rumus persegi
double luaspersegi = sisi * sisi;
double kelilingpersegi = 4 * sisi;

//Rumus persegi panjang
double kelilingpersegipanjang = 2 * panjang + lebar;
double luaspersegipanjang = panjang * lebar;
void main() {
  print("Luas persegi dengan sisi $sisi adalah $luaspersegi");
  print("Luas persegi dengan sisi $sisi adalah $kelilingpersegi");
  print("Luas persegi dengan sisi $sisi adalah $luaspersegipanjang");
  print("Luas persegi dengan sisi $sisi adalah $kelilingpersegipanjang");
}
