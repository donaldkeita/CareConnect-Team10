import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CareBottomNav(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(28, 24, 28, 30),
                color: const Color(0xFF24466F),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D6BFF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.shield_outlined,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'CareConnect',
                          style: TextStyle(
                            color: Color(0xFFD4DEED),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.info_outline),
                          label: const Text('Highlights'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF486486),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(140, 56),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Good morning,\nJordan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Mon, Aug 31',
                      style: TextStyle(
                        color: Color(0xFFC7D2E2),
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 28),

                    Row(
                      children: [
                        Expanded(
                          child: _summaryCard(
                            '3',
                            'Appointments',
                            const Color(0xFF506D91),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            '4',
                            'Meds',
                            const Color(0xFFD55229),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _summaryCard(
                            '2',
                            'Unread',
                            const Color(0xFF2E62D8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F6FF),
                        border: Border.all(
                          color: const Color(0xFFB9D4FF),
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                color: Color(0xFF2864E8),
                                size: 30,
                              ),
                              SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  '2 appointments in the next 24 hours',
                                  style: TextStyle(
                                    color: Color(0xFF1E4FC4),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          _appointmentMiniCard(
                            'Dr. Sarah Chen',
                            '12:20 AM · ~4h away',
                            'In-Person',
                          ),

                          const SizedBox(height: 12),

                          _appointmentMiniCard(
                            'Dr. Marcus Webb',
                            '6:20 PM · ~22h away',
                            'Telehealth',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF7ED),
                        border: Border.all(
                          color: const Color(0xFFFFC58D),
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Color(0xFFFF5A1F),
                                size: 30,
                              ),
                              SizedBox(width: 14),
                              Text(
                                '2 missed doses today',
                                style: TextStyle(
                                  color: Color(0xFF9C3417),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          _medMiniCard(
                            'Lisinopril 10 mg',
                            '8:00 AM · Once daily',
                          ),

                          const SizedBox(height: 12),

                          _medMiniCard(
                            'Metformin 500 mg',
                            '8:00 AM, 8:00 PM · Twice daily',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard(
    String number,
    String label,
    Color color,
  ) {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _appointmentMiniCard(
    String doctor,
    String time,
    String type,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD6E4FA),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFF60738F),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Chip(
            label: Text(type),
          ),
        ],
      ),
    );
  }

  Widget _medMiniCard(
    String name,
    String schedule,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFFFD5B1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  schedule,
                  style: const TextStyle(
                    color: Color(0xFF60738F),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Chip(
            label: Text(
              'Missed',
              style: TextStyle(
                color: Color(0xFFBE1E2D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}