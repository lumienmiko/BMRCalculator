// =============================================================================
// calculator.dart
// -----------------------------------------------------------------------------
// Berisi seluruh LOGIKA PERHITUNGAN aplikasi (tanpa tampilan / UI).
//
// BMR (Basal Metabolic Rate) = jumlah kalori yang dibakar tubuh dalam
// keadaan istirahat total selama satu hari (untuk bernapas, detak jantung,
// menjaga suhu tubuh, dll).
//
// Rumus mengikuti referensi https://www.calculator.net/bmr-calculator.html
// Variabel: W = berat (kg), H = tinggi (cm), A = umur (tahun),
//           F = persentase lemak tubuh (body fat).
// =============================================================================

import 'constants.dart';

/// Pilihan rumus BMR yang bisa dipakai user.
/// Setiap rumus punya [label] (nama) dan [hint] (keterangan singkat)
/// yang ditampilkan di layar.
enum BmrFormula {
  mifflinStJeor(
    'Mifflin-St Jeor',
    'Default. Considered the most accurate for most people.',
  ),
  harrisBenedict(
    'Revised Harris-Benedict',
    'Classic formula, revised in 1984.',
  ),
  katchMcArdle(
    'Katch-McArdle',
    'Uses body fat %. Better for lean people who know their body fat.',
  );

  const BmrFormula(this.label, this.hint);
  final String label;
  final String hint;
}

/// Tingkat aktivitas harian beserta faktor pengali (multiplier).
/// Kebutuhan kalori harian = BMR x multiplier.
/// Nilai multiplier sama dengan yang dipakai calculator.net (1.2 - 1.9).
enum ActivityLevel {
  sedentary('Sedentary', 'Little or no exercise', 1.2),
  light('Light', 'Exercise 1-3 times/week', 1.375),
  moderate('Moderate', 'Exercise 4-5 times/week', 1.465),
  active('Active', 'Daily exercise or intense exercise 3-4 times/week', 1.55),
  veryActive('Very Active', 'Intense exercise 6-7 times/week', 1.725),
  extraActive('Extra Active', 'Very intense exercise daily, or physical job', 1.9);

  const ActivityLevel(this.title, this.description, this.multiplier);
  final String title;
  final String description;
  final double multiplier;
}

/// Class yang menerima data dari halaman input,
/// lalu menghitung BMR dan kebutuhan kalori harian.
class BmrCalculator {
  BmrCalculator({
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
    this.formula = BmrFormula.mifflinStJeor,
    this.bodyFat = 20,
  });

  final int height; // tinggi badan (cm)
  final int weight; // berat badan (kg)
  final int age; // umur (tahun)
  final Gender gender; // jenis kelamin
  final BmrFormula formula; // rumus yang dipilih user
  final int bodyFat; // lemak tubuh (%), hanya dipakai rumus Katch-McArdle

  /// Menghitung BMR (kalori/hari) sesuai rumus yang dipilih.
  double calculateBMR() {
    // Ubah ke double supaya hasil perhitungan tidak terpotong.
    final double w = weight.toDouble();
    final double h = height.toDouble();
    final double a = age.toDouble();

    // Alur: cek rumus yang dipilih -> cek gender -> hitung.
    switch (formula) {
      case BmrFormula.mifflinStJeor:
        // Pria   : 10W + 6.25H - 5A + 5
        // Wanita : 10W + 6.25H - 5A - 161
        final double base = 10 * w + 6.25 * h - 5 * a;
        return gender == Gender.male ? base + 5 : base - 161;

      case BmrFormula.harrisBenedict:
        // Pria   : 13.397W + 4.799H - 5.677A + 88.362
        // Wanita : 9.247W + 3.098H - 4.330A + 447.593
        if (gender == Gender.male) {
          return 13.397 * w + 4.799 * h - 5.677 * a + 88.362;
        }
        return 9.247 * w + 3.098 * h - 4.330 * a + 447.593;

      case BmrFormula.katchMcArdle:
        // 370 + 21.6 x (1 - F) x W
        // F dalam bentuk desimal, jadi persen dibagi 100 dulu (20% -> 0.2).
        // Rumus ini tidak memakai gender, umur, maupun tinggi badan.
        final double f = bodyFat / 100;
        return 370 + 21.6 * (1 - f) * w;
    }
  }

  /// Menghitung kebutuhan kalori harian untuk satu tingkat aktivitas.
  double dailyCalories(ActivityLevel level) {
    return calculateBMR() * level.multiplier;
  }
}

/// Mengubah angka menjadi teks bulat dengan pemisah ribuan.
/// Contoh: 1716.6 -> "1,717"
String formatCalories(double value) {
  final String digits = value.round().toString();
  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < digits.length; i++) {
    // Sisipkan koma setiap 3 digit dari belakang.
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(digits[i]);
  }
  return buffer.toString();
}
