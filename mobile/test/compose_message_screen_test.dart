import 'package:care_connect/screens/compose_message_screen.dart';
import 'package:care_connect/services/message_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ComposeMessageScreen', () {
    testWidgets('requires all fields before sending', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: ComposeMessageScreen()),
      );

      await tester.tap(find.text('Send Message'));
      await tester.pump();

      expect(find.text('Complete all fields before sending.'), findsOneWidget);
      expect(find.text('New Message'), findsOneWidget);
    });

    testWidgets('allows selecting a provider and entering message fields', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: ComposeMessageScreen()),
      );

      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dr. Marcus Webb'));
      await tester.enterText(
        find.byType(TextField).at(0),
        'Prescription question',
      );
      await tester.enterText(
        find.byType(TextField).at(1),
        'Should I take this with food?',
      );

      expect(find.text('Dr. Marcus Webb'), findsAtLeastNWidgets(1));
      expect(find.text('Prescription question'), findsOneWidget);
      expect(find.text('Should I take this with food?'), findsOneWidget);
    });
  });

  group('MessageService.canSend', () {
    test('accepts complete message fields', () {
      expect(
        MessageService.canSend(
          provider: 'Dr. Sarah Chen',
          subject: 'Question',
          body: 'Could you review my prescription?',
        ),
        isTrue,
      );
    });

    test('rejects missing providers and whitespace-only fields', () {
      expect(
        MessageService.canSend(
          provider: null,
          subject: 'Question',
          body: 'Message body',
        ),
        isFalse,
      );
      expect(
        MessageService.canSend(
          provider: 'Dr. Sarah Chen',
          subject: '  ',
          body: '\n',
        ),
        isFalse,
      );
    });
  });
}