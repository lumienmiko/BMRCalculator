# BMR Calculator

Aplikasi Flutter untuk menghitung **BMR (Basal Metabolic Rate)** dan kebutuhan kalori harian berdasarkan tingkat aktivitas. Project ini merupakan pengembangan dari aplikasi BMI Calculator, dengan referensi perhitungan dari [calculator.net/bmr-calculator](https://www.calculator.net/bmr-calculator.html).

## Anggota Kelompok

| No | Nama | NIM |
|----|------|-----|
| 1 | Maulana Mikola Achmad | K3524028 |
| 2 | Estu Setyoadi Galih R | K3524050 |
| 3 | Hammam Dhiyaulhaq     | K3524056 |

## Deskripsi

BMR adalah jumlah energi (kalori) yang dibutuhkan tubuh saat beristirahat total selama satu hari, yaitu untuk bernapas, memompa darah, dan menjaga suhu tubuh. Dari nilai BMR, aplikasi juga menghitung perkiraan kalori yang dibutuhkan per hari sesuai tingkat aktivitas fisik.

### Fitur

- Input jenis kelamin, tinggi badan (slider), berat badan, dan umur (tombol - / +)
- Pilihan 3 rumus BMR: **Mifflin-St Jeor** (default), **Revised Harris-Benedict**, dan **Katch-McArdle**
- Input persentase lemak tubuh (body fat) yang hanya muncul saat rumus Katch-McArdle dipilih
- Hasil BMR dalam Calories/day beserta konversinya ke kilojoule
- Tabel kebutuhan kalori harian untuk 6 tingkat aktivitas

### Rumus

W = berat (kg), H = tinggi (cm), A = umur (tahun), F = body fat (desimal)

| Rumus | Pria | Wanita |
|-------|------|--------|
| Mifflin-St Jeor | 10W + 6.25H − 5A + 5 | 10W + 6.25H − 5A − 161 |
| Revised Harris-Benedict | 13.397W + 4.799H − 5.677A + 88.362 | 9.247W + 3.098H − 4.330A + 447.593 |
| Katch-McArdle | 370 + 21.6(1 − F)W | 370 + 21.6(1 − F)W |

Kebutuhan kalori harian = BMR × faktor aktivitas:

| Tingkat aktivitas | Faktor |
|-------------------|--------|
| Sedentary: little or no exercise | 1.2 |
| Exercise 1-3 times/week | 1.375 |
| Exercise 4-5 times/week | 1.465 |
| Daily exercise or intense exercise 3-4 times/week | 1.55 |
| Intense exercise 6-7 times/week | 1.725 |
| Very intense exercise daily, or physical job | 1.9 |

### Alur Program

1. `main.dart` menjalankan aplikasi dan membuka `InputPage`.
2. Di `InputPage`, user mengisi data. Setiap perubahan disimpan di state lalu layar diperbarui dengan `setState()`.
3. Saat tombol **CALCULATE** ditekan, data dikirim ke class `BmrCalculator` (`calculator.dart`) untuk dihitung.
4. Hasil BMR dikirim ke `ResultPage` melalui `Navigator.push`.
5. `ResultPage` menampilkan BMR dan menghitung kebutuhan kalori untuk setiap tingkat aktivitas.
6. Tombol **RE-CALCULATE** kembali ke `InputPage`.

### Struktur Folder

```
lib/
├── main.dart                  # titik awal aplikasi & tema
├── calculator.dart            # logika rumus BMR & tingkat aktivitas
├── constants.dart             # warna, gaya teks, batas input
├── components/
│   ├── bottom_button.dart     # tombol CALCULATE / RE-CALCULATE
│   ├── counter_card.dart      # kartu berat & umur (tombol - / +)
│   ├── custom_card.dart       # kartu wadah input
│   ├── icon_card.dart         # isi kartu gender
│   └── round_icon_button.dart # tombol bulat - / +
└── pages/
    ├── input_page.dart        # halaman input data
    └── result_page.dart       # halaman hasil
```

## Screenshot

Screenshots ada di folder screenshots

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

Menjalankan test:

```bash
flutter test
```
