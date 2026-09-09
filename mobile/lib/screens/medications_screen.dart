import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class MedicationsScreen extends StatelessWidget {
  const MedicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF24466F),
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medications',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Your active prescriptions',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Semantics(
              button: true,
              label: 'Add a new medication',
              child: ElevatedButton.icon(
                onPressed: _openAddMedicationScreen,
                icon: const Icon(Icons.add),
                label: const Text('Add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF173B68),
                ),
              ),
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double horizontalPadding =
                constraints.maxWidth > 700 ? 80 : 16;

            return ListView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                20,
                horizontalPadding,
                24,
              ),
              children: [
                Text(
                  '${_medications.length} active medications',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 16),

                ..._medications.map(
                  (medication) => _MedicationCard(
                    medication: medication,
                  ),
                ),

                const SizedBox(height: 8),

                Semantics(
                  button: true,
                  label: 'Add medication',
                  child: SizedBox(
                    height: 64,
                    child: ElevatedButton.icon(
                      onPressed: _openAddMedicationScreen,
                      icon: const Icon(Icons.add),
                      label: const Text(
                        'Add Medication',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF173B68),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF1F8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Color(0xFF173B68),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Need help managing your medications? '
                          'Contact your care team for assistance.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF173B68),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),

      bottomNavigationBar: CareBottomNav(currentIndex: 2),
    );
  }
}

class _MedicationCard extends StatelessWidget {
  final Map<String, String> medication;

  const _MedicationCard({
    required this.medication,
  });

  @override
  Widget build(BuildContext context) {
    final bool missed = medication['status'] == 'Missed';

    return Semantics(
      container: true,
      label:
          '${medication['name']}, ${medication['dosage']}, '
          '${medication['frequency']}',
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF1F8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.medication_outlined,
                      color: Color(0xFF173B68),
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medication['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF173B68),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          medication['dosage'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: missed
                          ? const Color(0xFFFFE7E7)
                          : const Color(0xFFE7F6EC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      medication['status'] ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: missed
                            ? const Color(0xFFB42318)
                            : const Color(0xFF237A45),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              _InfoRow(
                icon: Icons.schedule,
                text: medication['frequency'] ?? '',
              ),

              if ((medication['instructions'] ?? '').isNotEmpty) ...[
                const SizedBox(height: 10),
                _InfoRow(
                  icon: Icons.notes,
                  text: medication['instructions'] ?? '',
                ),
              ],

              const SizedBox(height: 10),

              _InfoRow(
                icon: Icons.person_outline,
                text: medication['provider'] ?? '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF64748B),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF475569),
            ),
          ),
        ),
      ],
    );
  }
}