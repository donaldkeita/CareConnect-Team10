import 'package:flutter/material.dart';

import '../models/message.dart';
import '../services/message_service.dart';

const _replyNavy = Color(0xFF0E456A);
const _replyMuted = Color(0xFF6D829C);
const _replyLine = Color(0xFFD8E1EA);
const _replySurface = Color(0xFFF7F9FC);

class ReplyMessageScreen extends StatefulWidget {
  final CareMessage message;

  const ReplyMessageScreen({super.key, required this.message});

  @override
  State<ReplyMessageScreen> createState() => _ReplyMessageScreenState();
}

class _ReplyMessageScreenState extends State<ReplyMessageScreen> {
  final _body = TextEditingController();
  late final _subject = TextEditingController(text: 'Re: ${widget.message.subject}');

  @override
  void dispose() {
    _body.dispose();
    _subject.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _replySurface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(children: [
                TextButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.chevron_left), label: const Text('Back', style: TextStyle(fontSize: 18))),
                const Expanded(child: Center(child: Text('Reply', style: TextStyle(color: _replyNavy, fontSize: 20, fontWeight: FontWeight.bold)))),
                TextButton(onPressed: _send, child: const Text('Send', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              ]),
            ),
            const Divider(height: 1, color: _replyLine),
            Expanded(child: Padding(padding: const EdgeInsets.fromLTRB(24, 22, 24, 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const _FieldLabel('TO'),
              _Recipient(message: widget.message),
              const SizedBox(height: 20),
              const _FieldLabel('SUBJECT'),
              TextField(controller: _subject, decoration: _decoration()),
              const SizedBox(height: 20),
              const _FieldLabel('MESSAGE'),
              _Quote(message: widget.message),
              const SizedBox(height: 14),
              Expanded(child: TextField(controller: _body, expands: true, maxLines: null, minLines: null, textAlignVertical: TextAlignVertical.top, decoration: _decoration(hint: 'Write your message...'))),
            ]))),
            Container(padding: const EdgeInsets.fromLTRB(24, 16, 24, 18), decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: _replyLine))), child: SizedBox(width: double.infinity, height: 64, child: FilledButton.icon(onPressed: _send, icon: const Icon(Icons.send_outlined), label: const Text('Send Message', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), style: FilledButton.styleFrom(backgroundColor: _replyNavy, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))))))
          ],
        ),
      ),
    );
  }

  Future<void> _send() async {
    if (!MessageService.canSend(provider: widget.message.sender, subject: _subject.text, body: _body.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Write a message before sending.')));
      return;
    }
    await MessageService.sendMessage(provider: widget.message.sender, subject: _subject.text, body: _body.text);
    if (mounted) {
      Navigator.pop(context);
    }
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel(this.label);
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(label, style: const TextStyle(color: _replyMuted, fontSize: 14, fontWeight: FontWeight.w600)));
}

InputDecoration _decoration({String? hint}) => InputDecoration(hintText: hint, hintStyle: const TextStyle(color: _replyMuted), filled: true, fillColor: _replySurface, contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16), border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: _replyMuted, width: 1.4)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: _replyMuted, width: 1.4)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: _replyNavy, width: 2)));

class _Avatar extends StatelessWidget {
  final String initials;
  const _Avatar({required this.initials});
  @override
  Widget build(BuildContext context) => CircleAvatar(radius: 23, backgroundColor: _replyNavy, child: Text(initials, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)));
}

class _Recipient extends StatelessWidget {
  final CareMessage message;
  const _Recipient({required this.message});
  @override
  Widget build(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFFEFF3F9), borderRadius: BorderRadius.circular(16)), child: Row(children: [_Avatar(initials: message.initials), const SizedBox(width: 12), Text(message.sender, style: const TextStyle(color: _replyNavy, fontSize: 16, fontWeight: FontWeight.w600)), const SizedBox(width: 8), Expanded(child: Text('· ${message.role}', overflow: TextOverflow.ellipsis, style: const TextStyle(color: _replyMuted, fontSize: 14)))]));
}

class _Quote extends StatelessWidget {
  final CareMessage message;
  const _Quote({required this.message});
  @override
  Widget build(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFEFF3F9), borderRadius: BorderRadius.circular(16)), child: Text('${message.sender} wrote:\n${message.quotedMessage}', style: const TextStyle(color: _replyMuted, height: 1.5)));
}
