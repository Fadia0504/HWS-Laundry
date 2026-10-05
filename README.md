# Bagian A - Dokumen Analisis

## 1. Problem Statement

Biaya laundry dihitung dari berat cucian dengan tarif Rp7.000/kg. Cucian di bawah 2 kg tetap dihitung 2 kg, dan layanan express dikenai tambahan 50%.

## 2. Actor

**Pelanggan**

Pelanggan berinteraksi dengan sistem untuk memasukkan berat cucian dan memilih jenis layanan.

## 3. Input & Output

### Input

1. Berat cucian (kg)
2. Jenis layanan (reguler / express)

### Output

1. Berat yang dihitung
2. Total biaya laundry

## 4. Functional Requirement

| Kode | Functional Requirement |
|---|---|
| FR-01 | Sistem dapat menentukan berat yang dihitung dari berat cucian. |
| FR-02 | Sistem dapat menghitung biaya dasar berdasarkan tarif per kg. |
| FR-03 | Sistem dapat menambahkan biaya layanan express. |
| FR-04 | Sistem dapat menampilkan total biaya pelanggan. |

## 5. Business Rules

| Kode | Business Rule |
|---|---|
| BR-01 | Tarif Rp7.000 per kg. |
| BR-02 | Berat di bawah 2 kg dihitung 2 kg. |
| BR-03 | Layanan express dikenai tambahan 50%. |

## 6. Decomposition

```text
laundry
├── tentukanBeratHitung
├── hitungBiayaDasar
├── hitungBiayaTotal
│   └── tambahan express 50%
└── prosesOrder
```

## 7. Pattern Recognition

- **Pengecekan kondisi**
  Sistem mengecek apakah berat di bawah 2 kg dan apakah layanan yang dipilih express.

- **Perhitungan berulang**
  Biaya selalu dihitung dari berat yang dihitung dikali tarif per kg.

- **Penambahan persentase**
  Layanan express selalu menambah 50% dari biaya dasar.

## 8. Abstraction

```text
laundry
├── beratCucian
├── beratHitung
├── tarifPerKg
├── jenisLayanan
└── totalBiaya
```

Data utama yang digunakan:

- **Berat cucian** : berat asli cucian dari pelanggan.
- **Berat hitung** : berat yang dipakai untuk menghitung (minimal 2 kg).
- **Tarif per kg** : Rp7.000.
- **Jenis layanan** : reguler atau express.
- **Total biaya** : hasil akhir yang harus dibayar pelanggan.

Jenis layanan:

```text
JenisLayanan
├── reguler
└── express
```

---

# Bagian B - Program Dart (`tugas.dart`)

```dart
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
  // Skenario 1: 1.5 kg reguler (di bawah 2 kg)
  // expected: Berat 1.5 kg (reguler), dihitung 2.0 kg, total Rp14000
  print("1: ${prosesOrder(1.5, JenisLayanan.reguler)}");

  // Skenario 2: 3 kg reguler
  // expected: Berat 3.0 kg (reguler), dihitung 3.0 kg, total Rp21000
  print("2: ${prosesOrder(3, JenisLayanan.reguler)}");

  // Skenario 3: tepat 2 kg reguler (batas)
  // expected: Berat 2.0 kg (reguler), dihitung 2.0 kg, total Rp14000
  print("3: ${prosesOrder(2, JenisLayanan.reguler)}");

  // Skenario 4: 1 kg express (di bawah 2 kg + express)
  // expected: Berat 1.0 kg (express), dihitung 2.0 kg, total Rp21000
  print("4: ${prosesOrder(1, JenisLayanan.express)}");

  // Skenario 5: 4 kg express
  // expected: Berat 4.0 kg (express), dihitung 4.0 kg, total Rp42000
  print("5: ${prosesOrder(4, JenisLayanan.express)}");
}
```

# Bagian C - Tabel Traceability

| Business Rule | Function | Skenario |
|---|---|---|
| BR-01 tarif Rp7.000/kg | `hitungBiayaDasar` | S2, S3, S5 |
| BR-02 di bawah 2 kg dihitung 2 kg | `tentukanBeratHitung` | S1, S3, S4 |
| BR-03 express +50% | `hitungBiayaTotal` | S4, S5 |
