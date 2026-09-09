import 'package:care_connect/models/message.dart';
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

  group('ReplyMessageScreen', () {
    testWidgets('prefills recipient context and requires a reply body', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: ReplyMessageScreen(message: message)),
      );

      expect(find.text(message.sender), findsOneWidget);
      expect(find.text('Re: ${message.subject}'), findsOneWidget);
      expect(
        find.text('${message.sender} wrote:\n${message.quotedMessage}'),
        findsOneWidget,
      );

      await tester.tap(find.text('Send Message'));
      await tester.pump();

      expect(find.text('Write a message before sending.'), findsOneWidget);
      expect(find.text('Reply'), findsOneWidget);
    });
  });
}