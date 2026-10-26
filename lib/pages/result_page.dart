// =============================================================================
// result_page.dart
// -----------------------------------------------------------------------------
// Halaman kedua: menampilkan hasil perhitungan.
//
// Alur halaman ini:
//   1. Menerima nilai BMR dan rumus yang dipakai dari InputPage.
//   2. Menampilkan BMR (Calories/day) dan konversinya ke kilojoule.
//   3. Untuk setiap tingkat aktivitas (enum ActivityLevel), menghitung
//      kebutuhan kalori harian = BMR x multiplier, lalu menampilkannya
//      dalam bentuk tabel.
//   4. Tombol RE-CALCULATE menutup halaman ini dan kembali ke InputPage
//      (data yang tadi diisi masih tersimpan).
// =============================================================================

import 'package:flutter/material.dart';
import 'package:bmr_calculator/calculator.dart';
import 'package:bmr_calculator/constants.dart';
import 'package:bmr_calculator/components/bottom_button.dart';
import 'package:bmr_calculator/components/custom_card.dart';

/// 1 kilokalori (Calorie) = 4.1868 kilojoule
const double kcalToKj = 4.1868;

class ResultPage extends StatelessWidget {
  const ResultPage({
    super.key,
    required this.bmr,
    required this.formula,
  });

  final double bmr; // hasil BMR dari InputPage (kalori/hari)
  final BmrFormula formula; // rumus yang dipakai

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMR CALCULATOR'),
      ),
      bottomNavigationBar: BottomButton(
        buttonTitle: 'RE-CALCULATE',
        onTap: () {
          // Kembali ke halaman sebelumnya (InputPage)
          Navigator.pop(context);
        },
      ),
      // ListView supaya tabel aktivitas bisa di-scroll
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
            child: Text(
              'Your Result',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildBmrCard(),
          _buildActivityCard(),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Kartu 1: nilai BMR
  // ---------------------------------------------------------------------------
  Widget _buildBmrCard() {
    return CustomCard(
      color: activeCardColor,
      cardChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
        child: Column(
          children: [
            const Text('BMR', style: resultTextStyle),
            // formatCalories membulatkan dan memberi koma ribuan, mis. 1,480
            Text(formatCalories(bmr), style: bmrTextStyle),
            const Text('Calories/day', style: labelTextStyle),
            const SizedBox(height: 10.0),
            Text(
              '≈ ${formatCalories(bmr * kcalToKj)} kJ/day',
              style: smallLabelTextStyle,
            ),
            const SizedBox(height: 4.0),
            Text(
              'Formula: ${formula.label}',
              style: smallLabelTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Kartu 2: kebutuhan kalori harian per tingkat aktivitas
  // ---------------------------------------------------------------------------
  Widget _buildActivityCard() {
    return CustomCard(
      color: activeCardColor,
      cardChild: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'DAILY CALORIE NEEDS',
              textAlign: TextAlign.center,
              style: labelTextStyle,
            ),
            const Text(
              'based on activity level',
              textAlign: TextAlign.center,
              style: smallLabelTextStyle,
            ),
            const SizedBox(height: 10.0),
            // Ulangi untuk setiap tingkat aktivitas (6 baris)
            for (final ActivityLevel level in ActivityLevel.values)
              _buildActivityRow(level),
            const SizedBox(height: 10.0),
            // Penjelasan istilah, sama seperti di calculator.net
            const Text(
              'Exercise: 15-30 minutes of elevated heart rate activity.\n'
              'Intense exercise: 45-120 minutes of elevated heart rate activity.\n'
              'Very intense exercise: 2+ hours of elevated heart rate activity.',
              style: smallLabelTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  /// Satu baris tabel: nama aktivitas + keterangan di kiri, kalori di kanan.
  Widget _buildActivityRow(ActivityLevel level) {
    // Kebutuhan kalori = BMR x faktor aktivitas
    final double calories = bmr * level.multiplier;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF2C2E45)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  level.title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(level.description, style: smallLabelTextStyle),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            formatCalories(calories),
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF24D876),
            ),
          ),
        ],
      ),
    );
  }
}
