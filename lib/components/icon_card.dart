import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmr_calculator/constants.dart';

class IconCard extends StatelessWidget {
  const IconCard({super.key, required this.cardIcon, required this.caption});

  // font_awesome_flutter versi 11 memakai tipe FaIconData (bukan IconData)
  final FaIconData cardIcon;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Ikon Font Awesome wajib ditampilkan dengan FaIcon
        FaIcon(
          cardIcon,
          size: 70.0,
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          caption,
          style: labelTextStyle,
        ),
      ],
    );
  }
}
