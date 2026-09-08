import 'package:flutter/material.dart';

import '../models/appointment.dart';
import '../services/appointment_service.dart';
import '../widgets/appointment_request_dialog.dart';
import '../widgets/bottom_nav.dart';

class AppointmentsScreen extends StatelessWidget {
  AppointmentsScreen({super.key})
    : _appointments = const AppointmentService().getUpcomingAppointments();

  final List<Appointment> _appointments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CareBottomNav(currentIndex: 1),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    for (
                      var index = 0;
                      index < _appointments.length;
                      index++
                    ) ...[
                      _buildAppointmentCard(_appointments[index]),
                      if (index < _appointments.length - 1)
                        const SizedBox(height: 18),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final requestButton = Semantics(
            button: true,
            label: 'Request a new appointment',
            child: ElevatedButton.icon(
              onPressed: () => _showRequestDialog(context),
              icon: const Icon(Icons.add),
              label: const Text('Request Appointment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF24466F),
                foregroundColor: Colors.white,
                minimumSize: const Size(210, 58),
              ),
            ),
          );

          return Column(
            children: [
              if (constraints.maxWidth < 520)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Appointments',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    requestButton,
                  ],
                )
              else
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
                    requestButton,
                  ],
                ),
              const SizedBox(height: 22),
              Semantics(
                label: 'Appointment filter, Upcoming selected',
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F8),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _showRequestDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => const AppointmentRequestDialog(),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFBDD7FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (appointment.timeAway != null) ...[
            Text(
              '• ${appointment.timeAway}',
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
                  appointment.isTelehealth
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
                      appointment.providerName,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      appointment.specialty,
                      style: const TextStyle(
                        color: Color(0xFF60738F),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '◷ ${appointment.dateLabel}',
                      style: const TextStyle(color: Color(0xFF60738F)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '⌖ ${appointment.location}',
                      style: const TextStyle(color: Color(0xFF60738F)),
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
              Semantics(
                button: true,
                label:
                    'Reschedule appointment with ${appointment.providerName}',
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Reschedule'),
                ),
              ),
              Semantics(
                button: true,
                label: 'Cancel appointment with ${appointment.providerName}',
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Cancel'),
                ),
              ),
              if (appointment.isTelehealth)
                Semantics(
                  button: true,
                  label:
                      'Join telehealth appointment with ${appointment.providerName}',
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.videocam_outlined),
                    label: const Text('Join'),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
