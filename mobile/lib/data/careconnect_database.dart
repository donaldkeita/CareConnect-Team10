import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/message.dart';

class CareConnectDatabase {
  CareConnectDatabase._();

  static const _databaseName = 'care_connect.db';
  static const _databaseVersion = 1;
  static const _messageTable = 'messages';
  static late Database _database;

  static const _seedMessages = <CareMessage>[
    CareMessage(sender: 'Dr. Sarah Chen', initials: 'SC', role: 'Primary Care Physician', subject: 'Your recent lab results', preview: 'Your CBC and metabolic panel results are in. Overall things look ...', age: '2h ago', quotedMessage: 'Hi Jordan,\n\nYour recent lab results are in. Overall things look good.', unread: true),
    CareMessage(sender: 'Northside Medical Center', initials: 'NM', role: 'Care Team', subject: 'Refill reminder: Lisinopril', preview: 'Your prescription for Lisinopril is due for a refill in 14 days...', age: '18h ago', quotedMessage: 'Your prescription for Lisinopril is due for a refill in 14 days.', unread: true),
    CareMessage(sender: 'Dr. Marcus Webb', initials: 'MW', role: 'Specialist', subject: 'Pre-appointment instructions', preview: 'Looking forward to our telehealth visit tomorrow. A few things to p...', age: '2d ago', quotedMessage: 'Looking forward to our telehealth visit tomorrow.', unread: false),
    CareMessage(sender: 'Appointments Team', initials: 'AT', role: 'Care Team', subject: 'Appointment confirmed: Dr. Priya Nair', preview: 'Your appointment with Dr. Priya Nair on September 4th has been c...', age: '4d ago', quotedMessage: 'Your appointment with Dr. Priya Nair on September 4th has been confirmed.', unread: false),
  ];

  static Future<void> initialize() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      version: _databaseVersion,
      onCreate: (database, version) async {
        await database.execute('''
          CREATE TABLE $_messageTable (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            sender TEXT NOT NULL,
            initials TEXT NOT NULL,
            role TEXT NOT NULL,
            subject TEXT NOT NULL,
            preview TEXT NOT NULL,
            age TEXT NOT NULL,
            quoted_message TEXT NOT NULL,
            unread INTEGER NOT NULL
          )
        ''');
        await _seedMessagesInto(database);
      },
    );
  }

  static Future<List<CareMessage>> getMessages() async {
    final rows = await _database.query(_messageTable, orderBy: 'id ASC');
    return rows.map(_messageFromRow).toList();
  }

  static Future<void> insertMessage({
    required String provider,
    required String subject,
    required String body,
  }) async {
    await _database.insert(
      _messageTable,
      _messageToRow(
        CareMessage(
          sender: 'You',
          initials: 'YO',
          role: provider,
          subject: subject.trim(),
          preview: body.trim(),
          age: 'Just now',
          quotedMessage: body.trim(),
          unread: false,
        ),
      )..remove('id'),
    );
  }

  static CareMessage _messageFromRow(Map<String, Object?> row) => CareMessage(
        id: row['id'] as int?,
        sender: row['sender'] as String,
        initials: row['initials'] as String,
        role: row['role'] as String,
        subject: row['subject'] as String,
        preview: row['preview'] as String,
        age: row['age'] as String,
        quotedMessage: row['quoted_message'] as String,
        unread: (row['unread'] as int) == 1,
      );

  static Map<String, Object?> _messageToRow(CareMessage message) => {
        'id': message.id,
        'sender': message.sender,
        'initials': message.initials,
        'role': message.role,
        'subject': message.subject,
        'preview': message.preview,
        'age': message.age,
        'quoted_message': message.quotedMessage,
        'unread': message.unread ? 1 : 0,
      };

  static Future<void> _seedMessagesInto(Database database) async {
    final batch = database.batch();
    for (final message in _seedMessages) {
      batch.insert(_messageTable, _messageToRow(message)..remove('id'));
    }
    await batch.commit(noResult: true);
  }
}
