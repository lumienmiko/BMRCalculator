import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmr_calculator/constants.dart';
import 'package:bmr_calculator/components/round_icon_button.dart';

class CounterCard extends StatelessWidget {
  const CounterCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.onMinus,
    required this.onPlus,
  });

  final String label; // judul, contoh: "WEIGHT"
  final int value; // angka yang ditampilkan
  final String unit; // satuan, contoh: "kg"
  final Function() onMinus; // dipanggil saat tombol - ditekan
  final Function() onPlus; // dipanggil saat tombol + ditekan

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: labelTextStyle),
        // Angka dan satuan sejajar di garis bawah huruf
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(value.toString(), style: numberTextStyle),
            const SizedBox(width: 4.0),
            Text(unit, style: labelTextStyle),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundIconButton(
              icon: FontAwesomeIcons.minus,
              onPressed: onMinus,
            ),
            const SizedBox(width: 10.0),
            RoundIconButton(
              icon: FontAwesomeIcons.plus,
              onPressed: onPlus,
            ),
          ],
        ),
      ],
    );
  }
}
