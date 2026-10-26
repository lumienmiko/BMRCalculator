// =============================================================================
// input_page.dart
// -----------------------------------------------------------------------------
// Halaman pertama: tempat user mengisi data untuk menghitung BMR.
//
// Alur halaman ini:
//   1. User memilih gender (kartu MALE / FEMALE).
//   2. User menggeser slider tinggi badan.
//   3. User mengatur berat badan dan umur dengan tombol - / +.
//   4. User memilih rumus BMR. Kalau memilih Katch-McArdle, muncul slider
//      body fat (lemak tubuh %).
//   5. Setiap perubahan disimpan di variabel state lalu setState() dipanggil
//      supaya layar digambar ulang dengan nilai terbaru.
//   6. Tombol CALCULATE membuat objek BmrCalculator, menghitung BMR,
//      lalu membuka ResultPage dengan membawa hasilnya.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmr_calculator/calculator.dart';
import 'package:bmr_calculator/constants.dart';
import 'package:bmr_calculator/components/bottom_button.dart';
import 'package:bmr_calculator/components/counter_card.dart';
import 'package:bmr_calculator/components/custom_card.dart';
import 'package:bmr_calculator/components/icon_card.dart';
import 'package:bmr_calculator/pages/result_page.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  // ---------- State: nilai yang sedang diisi user (dengan nilai awal) ----------
  Gender selectedGender = Gender.male;
  int height = 160; // cm
  int weight = 60; // kg
  int age = 25; // tahun
  BmrFormula selectedFormula = BmrFormula.mifflinStJeor;
  int bodyFat = 20; // %

  /// Dipanggil saat tombol CALCULATE ditekan.
  void _calculate() {
    // 1. Kirim semua input ke class kalkulator
    final BmrCalculator calc = BmrCalculator(
      height: height,
      weight: weight,
      age: age,
      gender: selectedGender,
      formula: selectedFormula,
      bodyFat: bodyFat,
    );

    // 2. Hitung BMR
    final double bmr = calc.calculateBMR();

    // 3. Pindah ke halaman hasil sambil membawa nilai BMR dan rumus
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          bmr: bmr,
          formula: selectedFormula,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMR CALCULATOR'),
      ),
      // Tombol CALCULATE selalu menempel di bawah layar
      bottomNavigationBar: BottomButton(
        buttonTitle: 'CALCULATE',
        onTap: _calculate,
      ),
      // SliderTheme di sini berlaku untuk SEMUA slider di halaman ini
      body: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: Colors.white,
          inactiveTrackColor: greyColor,
          thumbColor: accentColor,
          overlayColor: const Color(0x29EB1555),
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15.0),
          overlayShape: const RoundSliderOverlayShape(overlayRadius: 30.0),
        ),
        // Bisa di-scroll supaya tidak overflow di HP berlayar kecil
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildGenderRow(),
              _buildHeightCard(),
              _buildWeightAgeRow(),
              _buildFormulaCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bagian 1: pilihan gender
  // ---------------------------------------------------------------------------
  Widget _buildGenderRow() {
    return SizedBox(
      height: 160.0,
      child: Row(
        children: [
          Expanded(
            child: CustomCard(
              // Kartu yang dipilih warnanya lebih terang
              color: selectedGender == Gender.male
                  ? activeCardColor
                  : inactiveCardColor,
              cardChild: const IconCard(
                cardIcon: FontAwesomeIcons.mars,
                caption: 'MALE',
              ),
              onPress: () {
                setState(() {
                  selectedGender = Gender.male;
                });
              },
            ),
          ),
          Expanded(
            child: CustomCard(
              color: selectedGender == Gender.female
                  ? activeCardColor
                  : inactiveCardColor,
              cardChild: const IconCard(
                cardIcon: FontAwesomeIcons.venus,
                caption: 'FEMALE',
              ),
              onPress: () {
                setState(() {
                  selectedGender = Gender.female;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bagian 2: tinggi badan (slider)
  // ---------------------------------------------------------------------------
  Widget _buildHeightCard() {
    return SizedBox(
      height: 170.0,
      child: CustomCard(
        color: activeCardColor,
        cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('HEIGHT', style: labelTextStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(height.toString(), style: numberTextStyle),
                const SizedBox(width: 4.0),
                const Text('cm', style: labelTextStyle),
              ],
            ),
            Slider(
              value: height.toDouble(),
              min: minHeight,
              max: maxHeight,
              onChanged: (double value) {
                // Nilai slider berupa desimal, dibulatkan jadi cm
                setState(() {
                  height = value.round();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bagian 3: berat badan dan umur (tombol - / +)
  // ---------------------------------------------------------------------------
  Widget _buildWeightAgeRow() {
    return SizedBox(
      height: 170.0,
      child: Row(
        children: [
          Expanded(
            child: CustomCard(
              color: activeCardColor,
              cardChild: CounterCard(
                label: 'WEIGHT',
                value: weight,
                unit: 'kg',
                // Nilai hanya berubah kalau masih di dalam batas
                onMinus: () {
                  setState(() {
                    if (weight > minWeight) weight--;
                  });
                },
                onPlus: () {
                  setState(() {
                    if (weight < maxWeight) weight++;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: CustomCard(
              color: activeCardColor,
              cardChild: CounterCard(
                label: 'AGE',
                value: age,
                unit: 'yr',
                onMinus: () {
                  setState(() {
                    if (age > minAge) age--;
                  });
                },
                onPlus: () {
                  setState(() {
                    if (age < maxAge) age++;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bagian 4: pilihan rumus (+ slider body fat untuk Katch-McArdle)
  // ---------------------------------------------------------------------------
  Widget _buildFormulaCard() {
    return CustomCard(
      color: activeCardColor,
      cardChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('FORMULA', style: labelTextStyle),
            const SizedBox(height: 10.0),
            // Satu chip untuk setiap rumus di enum BmrFormula
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8.0,
              runSpacing: 8.0,
              children: BmrFormula.values.map((formula) {
                return ChoiceChip(
                  label: Text(formula.label),
                  selected: selectedFormula == formula,
                  selectedColor: accentColor,
                  showCheckmark: false,
                  onSelected: (_) {
                    setState(() {
                      selectedFormula = formula;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            // Keterangan singkat rumus yang sedang dipilih
            Text(
              selectedFormula.hint,
              textAlign: TextAlign.center,
              style: smallLabelTextStyle,
            ),
            // Slider body fat HANYA muncul kalau rumus Katch-McArdle dipilih
            if (selectedFormula == BmrFormula.katchMcArdle) ...[
              const SizedBox(height: 15.0),
              const Text('BODY FAT', style: labelTextStyle),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(bodyFat.toString(), style: numberTextStyle),
                  const SizedBox(width: 4.0),
                  const Text('%', style: labelTextStyle),
                ],
              ),
              Slider(
                value: bodyFat.toDouble(),
                min: minBodyFat,
                max: maxBodyFat,
                onChanged: (double value) {
                  setState(() {
                    bodyFat = value.round();
                  });
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
