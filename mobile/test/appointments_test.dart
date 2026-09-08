import 'package:care_connect/models/appointment.dart';
import 'package:care_connect/screens/appointments_screen.dart';
import 'package:care_connect/services/appointment_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Appointment model', () {
    test('stores provider, schedule, location, and appointment type', () {
      const appointment = Appointment(
        providerName: 'Dr. Test Provider',
        specialty: 'Primary Care',
        dateLabel: 'Mon, Sep 7 · 9:00 AM',
        location: 'CareConnect Clinic',
        timeAway: '~1h away',
        isTelehealth: false,
      );

      expect(appointment.providerName, 'Dr. Test Provider');
      expect(appointment.specialty, 'Primary Care');
      expect(appointment.dateLabel, 'Mon, Sep 7 · 9:00 AM');
      expect(appointment.location, 'CareConnect Clinic');
      expect(appointment.timeAway, '~1h away');
      expect(appointment.isTelehealth, isFalse);
    });

    test('supports appointments without a countdown label', () {
      const appointment = Appointment(
        providerName: 'Dr. Test Provider',
        specialty: 'Cardiology',
        dateLabel: 'Fri, Sep 11 · 2:00 PM',
        location: 'Telehealth - Video Call',
        isTelehealth: true,
      );

      expect(appointment.timeAway, isNull);
      expect(appointment.isTelehealth, isTrue);
    });
  });

  group('AppointmentService', () {
    test('returns the configured upcoming appointments in display order', () {
      final appointments = const AppointmentService().getUpcomingAppointments();

      expect(appointments, hasLength(3));
      expect(appointments.map((appointment) => appointment.providerName), [
        'Dr. Sarah Chen',
        'Dr. Marcus Webb',
        'Dr. Priya Nair',
      ]);
      expect(
        appointments.where((appointment) => appointment.isTelehealth),
        hasLength(1),
      );
    });

    test('calculates the number of telehealth appointments', () {
      final appointments = const AppointmentService().getUpcomingAppointments();

      final telehealthCount =
          appointments.where((appointment) => appointment.isTelehealth).length;

      expect(telehealthCount, 1);
    });
  });

  group('AppointmentsScreen', () {
    testWidgets('shows every upcoming appointment and its actions', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: AppointmentsScreen()));

      expect(find.text('Appointments'), findsOneWidget);
      expect(find.text('Dr. Sarah Chen'), findsOneWidget);
      expect(find.text('Dr. Marcus Webb'), findsOneWidget);
      expect(find.text('Dr. Priya Nair'), findsOneWidget);
      expect(find.text('Join'), findsOneWidget);
    });

    testWidgets('stacks the request action on a narrow phone layout', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(MaterialApp(home: AppointmentsScreen()));

      final title = tester.getTopLeft(find.text('Appointments'));
      final requestButton = tester.getTopLeft(find.text('Request Appointment'));

      expect(requestButton.dy, greaterThan(title.dy));
      expect(
        find.bySemanticsLabel('Request a new appointment'),
        findsOneWidget,
      );
    });

    testWidgets('navigates to Home when the Home navigation button is pressed', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/appointments',
          routes: {
            '/': (context) => const Scaffold(body: Text('Home screen')),
            '/appointments': (context) => AppointmentsScreen(),
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
