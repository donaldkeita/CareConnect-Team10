import 'package:care_connect/models/message.dart';
import 'package:care_connect/screens/inbox_screen.dart';
import 'package:care_connect/screens/reply_message_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const message = CareMessage(
    sender: 'Dr. Sarah Chen',
    initials: 'SC',
    role: 'Primary Care Physician',
    subject: 'Your recent lab results',
    preview: 'Your CBC and metabolic panel results are in.',
    age: '2h ago',
    quotedMessage: 'Overall things look good.',
    unread: true,
  );

  group('InboxScreen', () {
    testWidgets('loads messages and displays the unread count', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: InboxScreen(loadMessages: () async => const [message]),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Inbox'), findsAtLeastNWidgets(1));
      expect(find.text('1 unread'), findsOneWidget);
      expect(find.text(message.sender), findsOneWidget);
      expect(find.text(message.subject), findsOneWidget);
      expect(find.text(message.preview), findsOneWidget);
    });

    testWidgets('opens the reply screen for a selected message', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: InboxScreen(loadMessages: () async => const [message]),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(message.subject));
      await tester.pumpAndSettle();

      expect(find.byType(ReplyMessageScreen), findsOneWidget);
      expect(find.text('Re: ${message.subject}'), findsOneWidget);
    });
  });
}