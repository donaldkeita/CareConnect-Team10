import '../data/careconnect_database.dart';
import '../models/message.dart';

class MessageService {
  MessageService._();

  static const providers = <String>[
    'Dr. Sarah Chen',
    'Dr. Marcus Webb',
    'Northside Medical Center',
  ];

  static Future<void> initialize() => CareConnectDatabase.initialize();

  static Future<List<CareMessage>> getMessages() => CareConnectDatabase.getMessages();

  static Future<void> sendMessage({
    required String provider,
    required String subject,
    required String body,
  }) {
    return CareConnectDatabase.insertMessage(
      provider: provider,
      subject: subject,
      body: body,
    );
  }

  static bool canSend({
    required String? provider,
    required String subject,
    required String body,
  }) {
    return provider != null && subject.trim().isNotEmpty && body.trim().isNotEmpty;
  }
}
