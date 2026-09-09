import 'package:flutter/material.dart';

import '../services/message_service.dart';

const _composeNavy = Color(0xFF0E456A);
const _composeMuted = Color(0xFF6D829C);
const _composeLine = Color(0xFFD8E1EA);
const _composeSurface = Color(0xFFF7F9FC);

class ComposeMessageScreen extends StatefulWidget {
  const ComposeMessageScreen({super.key});

  @override
  State<ComposeMessageScreen> createState() => _ComposeMessageScreenState();
}

class _ComposeMessageScreenState extends State<ComposeMessageScreen> {
  final _subject = TextEditingController();
  final _body = TextEditingController();
  String? _provider;

  @override
  void dispose() {
    _subject.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ComposeScaffold(
      title: 'New Message',
      onSend: _send,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _FieldLabel('TO'),
          DropdownButtonFormField<String>(
            initialValue: _provider,
            hint: const Text('Select provider...'),
            items: MessageService.providers.map((provider) => DropdownMenuItem(value: provider, child: Text(provider))).toList(),
            onChanged: (value) => setState(() => _provider = value),
            decoration: _decoration(),
          ),
          const SizedBox(height: 20),
          const _FieldLabel('SUBJECT'),
          TextField(controller: _subject, decoration: _decoration(hint: 'What is this about?')),
          const SizedBox(height: 20),
          const _FieldLabel('MESSAGE'),
          Expanded(child: TextField(controller: _body, expands: true, maxLines: null, minLines: null, textAlignVertical: TextAlignVertical.top, decoration: _decoration(hint: 'Write your message...'))),
        ],
      ),
    );
  }

  Future<void> _send() async {
    if (!MessageService.canSend(provider: _provider, subject: _subject.text, body: _body.text)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Complete all fields before sending.')));
      return;
    }
    await MessageService.sendMessage(provider: _provider!, subject: _subject.text, body: _body.text);
    if (mounted) {
      Navigator.pop(context);
    }
  }
}

class _ComposeScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback onSend;

  const _ComposeScaffold({required this.title, required this.child, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _composeSurface,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(children: [
                TextButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.chevron_left), label: const Text('Back', style: TextStyle(fontSize: 18))),
                Expanded(child: Center(child: Text(title, style: const TextStyle(color: _composeNavy, fontSize: 20, fontWeight: FontWeight.bold)))),
                TextButton(onPressed: onSend, child: const Text('Send', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              ]),
            ),
            const Divider(height: 1, color: _composeLine),
            Expanded(child: Padding(padding: const EdgeInsets.fromLTRB(24, 22, 24, 16), child: child)),
            _SendBar(onSend: onSend),
          ],
        ),
      ),
    );
  }
}

class _SendBar extends StatelessWidget {
  final VoidCallback onSend;
  const _SendBar({required this.onSend});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 18),
        decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: _composeLine))),
        child: SizedBox(width: double.infinity, height: 64, child: FilledButton.icon(onPressed: onSend, icon: const Icon(Icons.send_outlined), label: const Text('Send Message', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), style: FilledButton.styleFrom(backgroundColor: _composeNavy, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))))),
      );
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel(this.label);
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(label, style: const TextStyle(color: _composeMuted, fontSize: 14, fontWeight: FontWeight.w600)));
}

InputDecoration _decoration({String? hint}) => InputDecoration(hintText: hint, hintStyle: const TextStyle(color: _composeMuted), filled: true, fillColor: _composeSurface, contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16), border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: _composeMuted, width: 1.4)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: _composeMuted, width: 1.4)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: const BorderSide(color: _composeNavy, width: 2)));
