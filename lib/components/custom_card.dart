import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.color,
    this.cardChild,
    this.onPress,
  });

  final Color color; // warna latar kartu
  final Widget? cardChild; // isi kartu
  final Function()? onPress; // aksi saat kartu ditekan 

  @override
  Widget build(BuildContext context) {
    // GestureDetector membuat kartu bisa ditekan (dipakai kartu gender).
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.only(left: 1.0, right: 1.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: cardChild,
      ),
    );
  }
}
