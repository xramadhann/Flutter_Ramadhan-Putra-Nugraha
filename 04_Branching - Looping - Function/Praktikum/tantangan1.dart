double buku = 10000;
double pensil = 5000;
double tas = 100000;

double total_pembelian = buku + pensil + tas;
double diskon = 0.10;
double setelah_diskon = diskon * total_pembelian;
void main() {
  print("Buku : Rp$buku");
  print("Pensil : Rp$pensil");
  print("Tas : Rp$tas");
  print("Total Harga : Rp$total_pembelian");
  print("Total Diskon : $diskon %");
  print("Total Harga Setelah Diskon: Rp$setelah_diskon");
}
