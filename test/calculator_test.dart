// Unit test untuk memastikan rumus BMR di calculator.dart benar.
// Jalankan dengan: flutter test

import 'package:flutter_test/flutter_test.dart';
import 'package:bmr_calculator/calculator.dart';
import 'package:bmr_calculator/constants.dart';

void main() {
  // Data contoh: umur 25, tinggi 160 cm, berat 60 kg
  BmrCalculator make(Gender gender, BmrFormula formula, {int bodyFat = 20}) {
    return BmrCalculator(
      height: 160,
      weight: 60,
      age: 25,
      gender: gender,
      formula: formula,
      bodyFat: bodyFat,
    );
  }

  test('Mifflin-St Jeor pria & wanita', () {
    expect(make(Gender.male, BmrFormula.mifflinStJeor).calculateBMR(), 1480);
    expect(make(Gender.female, BmrFormula.mifflinStJeor).calculateBMR(), 1314);
  });

  test('Revised Harris-Benedict pria & wanita', () {
    expect(
      make(Gender.male, BmrFormula.harrisBenedict).calculateBMR(),
      closeTo(1518.097, 0.001),
    );
    expect(
      make(Gender.female, BmrFormula.harrisBenedict).calculateBMR(),
      closeTo(1389.843, 0.001),
    );
  });

  test('Katch-McArdle memakai body fat', () {
    expect(
      make(Gender.male, BmrFormula.katchMcArdle, bodyFat: 20).calculateBMR(),
      closeTo(1406.8, 0.001),
    );
  });

  test('Kebutuhan kalori = BMR x multiplier', () {
    final calc = make(Gender.male, BmrFormula.mifflinStJeor);
    expect(calc.dailyCalories(ActivityLevel.sedentary), closeTo(1776, 0.001));
    expect(calc.dailyCalories(ActivityLevel.extraActive), closeTo(2812, 0.001));
  });

  test('Format angka dengan koma ribuan', () {
    expect(formatCalories(1716.95), '1,717');
    expect(formatCalories(980.2), '980');
  });
}
