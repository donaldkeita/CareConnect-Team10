import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/appointments_screen.dart';
import 'screens/medications_screen.dart';
import 'screens/inbox_screen.dart';
import 'services/message_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MessageService.initialize();
  runApp(const CareConnectApp());
}

class CareConnectApp extends StatelessWidget {
  const CareConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CareConnect',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF24466F),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/appointments': (context) => AppointmentsScreen(),
        '/medications': (context) => MedicationsScreen(),
        '/inbox': (context) => InboxScreen(),
      },
    );
  }
}