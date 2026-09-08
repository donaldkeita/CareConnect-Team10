import 'package:care_connect/screens/appointments_screen.dart';
import 'package:care_connect/widgets/appointment_request_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> openRequestDialog(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AppointmentsScreen()));
    await tester.tap(find.text('Request Appointment'));
    await tester.pumpAndSettle();
  }

  group('AppointmentRequestDialog', () {
    testWidgets('is opened by the request appointment action', (tester) async {
      await openRequestDialog(tester);

      expect(find.byType(AppointmentRequestDialog), findsOneWidget);
      expect(find.text('Request an appointment'), findsOneWidget);
    });

    testWidgets('requires provider, date, and complete time range', (
      tester,
    ) async {
      await openRequestDialog(tester);

      await tester.tap(find.text('Submit request'));
      await tester.pump();

      expect(find.text('Select a medical provider'), findsOneWidget);
      expect(find.text('Select a preferred date'), findsOneWidget);
      expect(find.text('Select a start time'), findsOneWidget);
      expect(find.text('Select an end time'), findsOneWidget);
      expect(find.text('Additional information (optional)'), findsOneWidget);
    });

    testWidgets('provider selection updates the form state', (tester) async {
      await openRequestDialog(tester);

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dr. Marcus Webb · Cardiology'));
      await tester.pumpAndSettle();

      expect(find.text('Dr. Marcus Webb · Cardiology'), findsOneWidget);
      await tester.tap(find.text('Submit request'));
      await tester.pump();
      expect(find.text('Select a medical provider'), findsNothing);
    });

    testWidgets('accepts optional summary text input', (tester) async {
      await openRequestDialog(tester);

      await tester.enterText(
        find.bySemanticsLabel('Additional information, optional'),
        'Recurring headache for the past week.',
      );

      expect(find.text('Recurring headache for the past week.'), findsOneWidget);
    });

    testWidgets('cancel button closes the request dialog', (tester) async {
      await openRequestDialog(tester);

      await tester.tap(
        find.bySemanticsLabel('Cancel appointment request'),
      );
      await tester.pumpAndSettle();

      expect(find.byType(AppointmentRequestDialog), findsNothing);
      expect(find.text('Appointments'), findsOneWidget);
    });

    testWidgets('summary and document upload are optional and labeled', (
      tester,
    ) async {
      await openRequestDialog(tester);

      expect(
        find.bySemanticsLabel('Additional information, optional'),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel('Attach an optional document'),
        findsOneWidget,
      );
      expect(find.text('Attach document (optional)'), findsOneWidget);
    });

    testWidgets('required controls expose accessible labels', (tester) async {
      await openRequestDialog(tester);

      expect(
        find.bySemanticsLabel(
          RegExp(r'Medical provider, required'),
          skipOffstage: false,
        ),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel(
          RegExp(r'Preferred date, required:'),
          skipOffstage: false,
        ),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel(
          RegExp(r'Start time, required:'),
          skipOffstage: false,
        ),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel(
          RegExp(r'End time, required:'),
          skipOffstage: false,
        ),
        findsOneWidget,
      );
    });
  });
}
