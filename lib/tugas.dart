// berat di bawah 2 kg dihitung 2 kg
double tentukanBeratHitung(double berat) {
  if (berat < 2) {
    return 2;
  }
  return berat;
}

// BR-01: tarif Rp7.000 per kg
double hitungBiayaDasar(double berat) {
  return tentukanBeratHitung(berat) * 7000;
}

// BR-03: layanan express tambahan 50%
double hitungBiayaTotal(double berat, String layanan) {
  double biaya = hitungBiayaDasar(berat);
  if (layanan == "express") {
    biaya = biaya + (biaya * 0.5);
  }
  return biaya;
}

// menampilkan hasil order
String prosesOrder(double berat, String layanan) {
  double beratHitung = tentukanBeratHitung(berat);
  double total = hitungBiayaTotal(berat, layanan);
  return "Berat $berat kg ($layanan), dihitung $beratHitung kg, total Rp${total.toStringAsFixed(0)}";
}

void main() {
  // Skenario 1: 1.5 kg reguler (di bawah 2 kg)
  // expected: Berat 1.5 kg (reguler), dihitung 2.0 kg, total Rp14000
  print("1: ${prosesOrder(1.5, "reguler")}");

  // Skenario 2: 3 kg reguler
  // expected: Berat 3.0 kg (reguler), dihitung 3.0 kg, total Rp21000
  print("2: ${prosesOrder(3, "reguler")}");

  // Skenario 3: tepat 2 kg reguler (batas)
  // expected: Berat 2.0 kg (reguler), dihitung 2.0 kg, total Rp14000
  print("3: ${prosesOrder(2, "reguler")}");

  // Skenario 4: 1 kg express (di bawah 2 kg + express)
  // expected: Berat 1.0 kg (express), dihitung 2.0 kg, total Rp21000
  print("4: ${prosesOrder(1, "express")}");

  // Skenario 5: 4 kg express
  // expected: Berat 4.0 kg (express), dihitung 4.0 kg, total Rp42000
  print("5: ${prosesOrder(4, "express")}");
} 