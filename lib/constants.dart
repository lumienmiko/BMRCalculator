import 'package:flutter/material.dart';

// ---------- Warna ----------
const backgroundColor = Color(0xFF0A0E21); // latar belakang aplikasi
const activeCardColor = Color(0xFF1D1E33); // kartu yang sedang dipilih
const inactiveCardColor = Color(0xFF111328); // kartu yang tidak dipilih
const accentColor = Color(0xFFEB1555); // warna utama (tombol, slider)
const greyColor = Color(0xFF8D8E98); // teks keterangan

// ---------- Ukuran ----------
const bottomContainerHeight = 80.0;
const bottomContainerColor = accentColor;

// ---------- Batas nilai input ----------
// Rentang umur mengikuti calculator.net (15 - 80 tahun).
const minAge = 15;
const maxAge = 80;
const minWeight = 30;
const maxWeight = 250;
const minHeight = 120.0;
const maxHeight = 220.0;
const minBodyFat = 5.0;
const maxBodyFat = 50.0;

/// Jenis kelamin. Dipakai rumus Mifflin-St Jeor dan Harris-Benedict.
enum Gender {
  male,
  female,
}

// ---------- Gaya teks ----------
const labelTextStyle = TextStyle(
  fontSize: 18.0,
  color: greyColor,
);

const smallLabelTextStyle = TextStyle(
  fontSize: 13.0,
  color: greyColor,
);

const numberTextStyle = TextStyle(
  fontSize: 45.0,
  fontWeight: FontWeight.w900,
);

const buttonTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
);

const resultTextStyle = TextStyle(
  color: Color(0xFF24D876),
  fontSize: 22,
  fontWeight: FontWeight.bold,
);

const bmrTextStyle = TextStyle(
  fontSize: 80,
  fontWeight: FontWeight.bold,
);
