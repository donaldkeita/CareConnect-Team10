import 'package:flutter/material.dart';

import '../models/message.dart';
import '../services/message_service.dart';
import 'compose_message_screen.dart';
import 'reply_message_screen.dart';
import '../widgets/bottom_nav.dart';

const _navy = Color(0xFF0E456A);
const _muted = Color(0xFF6D829C);
const _line = Color(0xFFD8E1EA);

class InboxScreen extends StatefulWidget {
  final Future<List<CareMessage>> Function()? loadMessages;

  const InboxScreen({super.key, this.loadMessages});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<CareMessage> _messages = const [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final messages = await (widget.loadMessages ?? MessageService.getMessages)();
    if (mounted) {
      setState(() => _messages = messages);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const CareBottomNav(currentIndex: 3),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 28, 24, 26),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Inbox', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: _navy)), const SizedBox(height: 8), Text('${_messages.where((message) => message.unread).length} unread', style: const TextStyle(fontSize: 20, color: _muted))])),
                  FilledButton.icon(onPressed: _compose, icon: const Icon(Icons.add, size: 22), label: const Text('New', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)), style: FilledButton.styleFrom(backgroundColor: _navy, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)))),
                ],
              ),
            ),
            const Divider(height: 1, color: _line),
            Expanded(child: ListView.separated(itemCount: _messages.length, separatorBuilder: (_, index) => const Divider(height: 1, color: _line), itemBuilder: (context, index) => _MessageTile(message: _messages[index], onTap: () => _reply(_messages[index])))),
          ],
        ),
      ),
    );
  }

  Future<void> _compose() async {
    await Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const ComposeMessageScreen()));
    _loadMessages();
  }

  void _reply(CareMessage message) => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => ReplyMessageScreen(message: message)));
}

class _MessageTile extends StatelessWidget {
  final CareMessage message;
  final VoidCallback onTap;

  const _MessageTile({required this.message, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _Avatar(initials: message.initials),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Expanded(child: Text(message.sender, style: const TextStyle(fontWeight: FontWeight.bold, color: _navy, fontSize: 16))), Text(message.age, style: const TextStyle(color: _muted, fontSize: 13)), if (message.unread) ...[const SizedBox(width: 8), const _UnreadDot()]]),
            const SizedBox(height: 5),
            Text(message.subject, style: const TextStyle(color: _muted, fontSize: 15)),
            const SizedBox(height: 7),
            Text(message.preview, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: _muted, fontSize: 15)),
          ])),
        ]),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String initials;
  const _Avatar({required this.initials});
  @override
  Widget build(BuildContext context) => CircleAvatar(radius: 23, backgroundColor: _navy, child: Text(initials, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)));
}

class _UnreadDot extends StatelessWidget {
  const _UnreadDot();
  @override
  Widget build(BuildContext context) => const DecoratedBox(decoration: BoxDecoration(color: Color(0xFF2F74F5), shape: BoxShape.circle), child: SizedBox(width: 8, height: 8));
}
