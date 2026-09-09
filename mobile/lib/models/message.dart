class CareMessage {
  final int? id;
  final String sender;
  final String initials;
  final String role;
  final String subject;
  final String preview;
  final String age;
  final String quotedMessage;
  final bool unread;

  const CareMessage({
    this.id,
    required this.sender,
    required this.initials,
    required this.role,
    required this.subject,
    required this.preview,
    required this.age,
    required this.quotedMessage,
    required this.unread,
  });

}