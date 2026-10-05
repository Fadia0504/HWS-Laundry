// jenis layanan laundry
enum JenisLayanan { reguler, express }

// berat di bawah 2 kg dihitung 2 kg
double tentukanBeratHitung(double berat) {
  if (berat < 2) {
    return 2;
  }
  return berat;
}

// tarif Rp7.000 per kg
double hitungBiayaDasar(double berat) {
  return tentukanBeratHitung(berat) * 7000;
}

// layanan express tambahan 50%
double hitungBiayaTotal(double berat, JenisLayanan layanan) {
  double biaya = hitungBiayaDasar(berat);
  if (layanan == JenisLayanan.express) {
    biaya = biaya + (biaya * 0.5);
  }
  return biaya;
}

// menampilkan hasil order
String prosesOrder(double berat, JenisLayanan layanan) {
  double beratHitung = tentukanBeratHitung(berat);
  double total = hitungBiayaTotal(berat, layanan);
  return "Berat $berat kg (${layanan.name}), dihitung $beratHitung kg, total Rp${total.toStringAsFixed(0)}";
}

void main() {
  print("1: ${prosesOrder(1.5, JenisLayanan.reguler)}");
  print("2: ${prosesOrder(3, JenisLayanan.reguler)}");
  print("3: ${prosesOrder(2, JenisLayanan.reguler)}");
  print("4: ${prosesOrder(1, JenisLayanan.express)}");
  print("5: ${prosesOrder(4, JenisLayanan.express)}");
}