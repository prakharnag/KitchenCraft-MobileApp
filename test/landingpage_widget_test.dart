// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:mp5/main.dart';
import 'package:mp5/views/landingpage.dart';

void main() {
  group('LandingPage tests', () {
    testWidgets('LandingPage displays title and button correctly',
        (WidgetTester tester) async {
      // Pump the widget
      await tester.pumpWidget(const MaterialApp(home: LandingPage()));

      // Verify AppBar title
      expect(find.text('KitchenCraft'), findsOneWidget);

      expect(find.widgetWithText(ElevatedButton, 'Click to begin'), findsOneWidget);
    });

    testWidgets('Button navigates to HomePage on tap',
        (WidgetTester tester) async {

      await tester.pumpWidget(const MaterialApp(home: LandingPage()));

      // Find the button
      final buttonFinder = find.widgetWithText(ElevatedButton, 'Click to begin');

      // Tap the button
      await tester.tap(buttonFinder);

      // Pump again to rebuild widgets after navigation
      await tester.pumpAndSettle();

      // Verify that HomePage is now displayed
      expect(find.text('Welcome to your Kitchen'), findsOneWidget); // Replace with expected widget on HomePage
    });
  });
}