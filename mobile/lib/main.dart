import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/appointments_screen.dart';
import 'screens/medications_screen.dart';
import 'screens/add_medication_screen.dart';
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
      title: 'CareConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF173B68),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/appointments': (context) => AppointmentsScreen(),
        flutter-implementation
        '/medications': (context) => const MedicationsScreen(),
        '/add-medication': (context) => const AddMedicationScreen(),
        '/inbox': (context) => InboxScreen(),
        main
      },
    );
  }
}