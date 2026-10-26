// Widget test: mensimulasikan user memakai aplikasi.
// Jalankan dengan: flutter test

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmr_calculator/main.dart';

void main() {
  testWidgets('Isi data default -> CALCULATE -> hasil BMR tampil',
      (WidgetTester tester) async {
    // Atur ukuran layar seperti HP (360 x 800)
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const MyApp());

    // Halaman input tampil
    expect(find.text('BMR CALCULATOR'), findsOneWidget);
    expect(find.text('MALE'), findsOneWidget);
    expect(find.text('AGE'), findsOneWidget);

    // Tekan CALCULATE dengan data default (pria, 25 th, 160 cm, 60 kg)
    await tester.tap(find.text('CALCULATE'));
    await tester.pumpAndSettle();

    // Mifflin-St Jeor: 10(60) + 6.25(160) - 5(25) + 5 = 1480
    expect(find.text('Your Result'), findsOneWidget);
    expect(find.text('1,480'), findsOneWidget);
  });
}
