import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class AppointmentsScreen extends StatelessWidget {
  AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CareBottomNav(currentIndex: 1),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 28, 28, 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Appointments',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                        label: const Text('Request'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF24466F),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(145, 58),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 22),

                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2F8),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF24466F),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Text(
                              'Upcoming',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            'Past',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF60738F),
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
                    _appointmentCard(
                      doctor: 'Dr. Sarah Chen',
                      specialty: 'Primary Care',
                      date: 'Tue, Sep 1 · 12:20 AM',
                      location:
                          'Northside Medical Center, Suite 210',
                      timeAway: '~4h away',
                      telehealth: false,
                    ),

                    const SizedBox(height: 18),

                    _appointmentCard(
                      doctor: 'Dr. Marcus Webb',
                      specialty: 'Cardiology',
                      date: 'Tue, Sep 1 · 6:20 PM',
                      location: 'Telehealth - Video Call',
                      timeAway: '~22h away',
                      telehealth: true,
                    ),

                    const SizedBox(height: 18),

                    _appointmentCard(
                      doctor: 'Dr. Priya Nair',
                      specialty: 'Endocrinology',
                      date: 'Sat, Sep 5 · 8:20 PM',
                      location:
                          'Westfield Health Pavilion, Room 114',
                      telehealth: false,
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

  Widget _appointmentCard({
    required String doctor,
    required String specialty,
    required String date,
    required String location,
    String? timeAway,
    required bool telehealth,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFBDD7FF),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (timeAway != null) ...[
            Text(
              '• $timeAway',
              style: const TextStyle(
                color: Color(0xFF2E64E8),
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 14),
          ],

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F6FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  telehealth
                      ? Icons.videocam_outlined
                      : Icons.calendar_month_outlined,
                  color: const Color(0xFF2962E8),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      specialty,
                      style: const TextStyle(
                        color: Color(0xFF60738F),
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      '◷ $date',
                      style: const TextStyle(
                        color: Color(0xFF60738F),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      '⌖ $location',
                      style: const TextStyle(
                        color: Color(0xFF60738F),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: const Text('Reschedule'),
              ),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Cancel'),
              ),
              if (telehealth)
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.videocam_outlined,
                  ),
                  label: const Text('Join'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}