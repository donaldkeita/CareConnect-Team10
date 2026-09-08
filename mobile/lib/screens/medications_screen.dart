import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CareBottomNav(currentIndex: 2),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(28, 28, 28, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medications',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your active prescriptions',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF60738F),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _medicationCard(
                      name: 'Lisinopril',
                      dose: '10 mg',
                      schedule: 'Once daily · 8:00 AM',
                      doctor: 'Chen',
                      refill: 'Sep 14, 2026',
                      missed: true,
                      canMarkTaken: true,
                    ),

                    const SizedBox(height: 18),

                    _medicationCard(
                      name: 'Metformin',
                      dose: '500 mg',
                      schedule:
                          'Twice daily · 8:00 AM, 8:00 PM',
                      doctor: 'Nair',
                      refill: 'Sep 22, 2026',
                      missed: true,
                      canMarkTaken: true,
                    ),

                    const SizedBox(height: 18),

                    _medicationCard(
                      name: 'Atorvastatin',
                      dose: '20 mg',
                      schedule:
                          'Once daily (evening) · 9:00 PM',
                      doctor: 'Webb',
                      refill: 'Oct 3, 2026',
                      missed: false,
                      canMarkTaken: false,
                    ),

                    const SizedBox(height: 18),

                    _medicationCard(
                      name: 'Vitamin D3',
                      dose: '2000 IU',
                      schedule: 'Once daily · 8:00 AM',
                      doctor: 'Chen',
                      refill: 'Nov 1, 2026',
                      missed: false,
                      canMarkTaken: false,
                    ),

                    const SizedBox(height: 18),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFD7E0EC),
                        ),
                        borderRadius:
                            BorderRadius.circular(22),
                      ),
                      child: const Text(
                        'Need to add a medication? Contact your care team.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF60738F),
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _medicationCard({
    required String name,
    required String dose,
    required String schedule,
    required String doctor,
    required String refill,
    required bool missed,
    required bool canMarkTaken,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: missed
              ? const Color(0xFFFFC58D)
              : const Color(0xFFD7E0EC),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: missed
                  ? const Color(0xFFFFF6EB)
                  : const Color(0xFFF0F5FA),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.medication_outlined,
              color: missed
                  ? const Color(0xFFFF5A1F)
                  : const Color(0xFF24466F),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: Color(0xFF131C2E),
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(
                              text: name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' $dose',
                              style: const TextStyle(
                                color: Color(0xFF60738F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Chip(
                      label: Text(
                        missed ? 'Missed' : 'On track',
                        style: TextStyle(
                          color: missed
                              ? const Color(0xFFBE1E2D)
                              : const Color(0xFF137333),
                        ),
                      ),
                    ),
                  ],
                ),

                Text(
                  schedule,
                  style: const TextStyle(
                    color: Color(0xFF60738F),
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'By: $doctor',
                        style: const TextStyle(
                          color: Color(0xFF60738F),
                        ),
                      ),
                    ),

                    Text(
                      'Refill: $refill',
                      style: const TextStyle(
                        color: Color(0xFF60738F),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    if (canMarkTaken)
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.check),
                        label:
                            const Text('Mark taken'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF24466F),
                          foregroundColor: Colors.white,
                          minimumSize:
                              const Size(125, 52),
                        ),
                      ),

                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh),
                      label: const Text('Refill'),
                      style: OutlinedButton.styleFrom(
                        minimumSize:
                            const Size(100, 52),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}