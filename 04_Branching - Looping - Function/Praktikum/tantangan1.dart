double hitungTotalPembelian(double Buku, double Pensil, double Tas) {
  double totalPembelian = Buku + Pensil + Tas;
  return totalPembelian;
}

double hitungDiskon(double totalPembelian, double persentaseDiskon) {
  double diskon = totalPembelian * (persentaseDiskon / 100);
  return diskon;
}

double hitungTotalSetelahDiskon(double totalPembelian, double diskon) {
  double totalSetelahDiskon = totalPembelian - diskon;
  return totalSetelahDiskon;
}

void main() {
  double Buku = 10000;
  double Pensil = 5000;
  double Tas = 100000;

  double totalPembelian = hitungTotalPembelian(Buku, Pensil, Tas);
  print('Total pembelian sebelum diskon: $totalPembelian');

  double persentaseDiskon = 10;
  double diskon = hitungDiskon(totalPembelian, persentaseDiskon);
  print('Diskon: $diskon');

  double totalSetelahDiskon = hitungTotalSetelahDiskon(totalPembelian, diskon);
  print('Total pembelian setelah diskon: $totalSetelahDiskon');
}
