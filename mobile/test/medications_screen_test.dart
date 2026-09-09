import 'package:care_connect/screens/home_screen.dart';
import 'package:care_connect/screens/medications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MedicationsScreen', () {
    testWidgets('displays all active medications', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: MedicationsScreen()));

      expect(find.text('Medications'), findsOneWidget);
      expect(find.text('Your active prescriptions'), findsOneWidget);
      expect(find.byIcon(Icons.medication_outlined), findsWidgets);
    });

    testWidgets('shows Add Medication button in app bar', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: MedicationsScreen()));

      expect(find.text('Add'), findsOneWidget);
      expect(
        find.bySemanticsLabel('Add a new medication'),
        findsOneWidget,
      );
    });

    testWidgets('displays Add Medication button in body', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: MedicationsScreen()));

      expect(find.text('Add Medication'), findsOneWidget);
      expect(
        find.bySemanticsLabel('Add medication'),
        findsOneWidget,
      );
    });

    testWidgets('displays help message for medication management', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: MedicationsScreen()));

      expect(find.text('Need help managing your medications?'), findsOneWidget);
      expect(find.text('Contact your care team for assistance.'),
          findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('navigates to Home when Home navigation button is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/medications',
          routes: {
            '/': (context) => const Scaffold(body: Text('Home screen')),
            '/medications': (context) => MedicationsScreen(),
          },
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.home_outlined));
      await tester.pumpAndSettle();

      expect(find.text('Home screen'), findsOneWidget);
    });
  });
}
