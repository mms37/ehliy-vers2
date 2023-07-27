// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ehliyet2/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test Ehliyet Sınavı Uygulaması', (WidgetTester tester) async {
    await tester.pumpWidget(EhliyetSorulariUygulamasi());

    // Başlangıçta ilk soru gösterilmeli
    expect(find.text("Soru 1/5"), findsOneWidget);

    // Rastgele bir cevap seçin ve cevaplandi değişkenini true yapın
    await tester.tap(find.text("Evet"));
    await tester.pump();
    expect(find.text("Evet"), findsOneWidget);
    expect(find.text("Hayır"), findsOneWidget);
    expect(find.text("Soru 1/5"), findsOneWidget);

    // İkinci soruya geçin
    await tester.tap(find.text("Geç"));
    await tester.pump();

    // Başlangıçta ikinci soru gösterilmeli
    expect(find.text("Soru 2/5"), findsOneWidget);

    // Rastgele bir cevap seçin ve cevaplandi değişkenini true yapın
    await tester.tap(find.text("Evet"));
    await tester.pump();
    expect(find.text("Evet"), findsOneWidget);
    expect(find.text("Hayır"), findsOneWidget);
    expect(find.text("Soru 2/5"), findsOneWidget);

    // Sonraki soruya geçmek için "Geç" tuşuna basın
    await tester.tap(find.text("Geç"));
    await tester.pump();

    // Aynı işlemi diğer sorular için tekrarlayın
    await tester.tap(find.text("Hayır"));
    await tester.pump();
    expect(find.text("Hayır"), findsOneWidget);
    expect(find.text("Sollama şeridi olmalı"), findsOneWidget);
    expect(find.text("Korna çalmalı"), findsOneWidget);
    expect(find.text("Fazla hızlı olmalı"), findsOneWidget);
    expect(find.text("Soru 3/5"), findsOneWidget);

    await tester.tap(find.text("Geç"));
    await tester.pump();

    await tester.tap(find.text("Sol omuz ve beli kapsayacak şekilde takılır"));
    await tester.pump();
    expect(find.text("Sol omuz ve beli kapsayacak şekilde takılır"), findsOneWidget);
    expect(find.text("Takmaya gerek yok"), findsOneWidget);
    expect(find.text("Soru 4/5"), findsOneWidget);

    await tester.tap(find.text("Geç"));
    await tester.pump();

    await tester.tap(find.text("18"));
    await tester.pump();
    expect(find.text("18"), findsOneWidget);
    expect(find.text("19"), findsOneWidget);
    expect(find.text("Soru 5/5"), findsOneWidget);

    // Sonuc sayfasına geçmek için "Geç" tuşuna basın
    await tester.tap(find.text("Geç"));
    await tester.pump();

    // Sonuc sayfasının gösterildiğini ve "Yeniden Başla" düğmesinin olduğunu kontrol edin
    expect(find.text("Tebrikler!"), findsOneWidget);
    expect(find.text("Yeniden Başla"), findsOneWidget);
  });
}
