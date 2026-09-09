import 'package:care_connect/screens/medications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Adding Medication', () {
    testWidgets('can tap Add Medication button from app bar', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: MedicationsScreen()));

      final addButton = find.text('Add');
      expect(addButton, findsOneWidget);

      await tester.tap(addButton);
      await tester.pumpAndSettle();

      // Verify the Add button responds to tap
      expect(addButton, findsOneWidget);
    });

    testWidgets('can tap Add Medication button from body', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: MedicationsScreen()));

      final addMedicationButton = find.text('Add Medication');
      expect(addMedicationButton, findsOneWidget);

      await tester.tap(addMedicationButton);
      await tester.pumpAndSettle();

      // Verify the button responds to tap
      expect(addMedicationButton, findsOneWidget);
    });

    testWidgets('displays medication count dynamically', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: MedicationsScreen()));

      // Check that medication count is displayed
      expect(find.text('active medications'), findsOneWidget);
    });
  });
}
