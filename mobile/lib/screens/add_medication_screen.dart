import 'package:flutter/material.dart';

class AddMedicationScreen extends StatefulWidget {
  const AddMedicationScreen({super.key});

  @override
  State<AddMedicationScreen> createState() => _AddMedicationScreenState();
}

class _AddMedicationScreenState extends State<AddMedicationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  final TextEditingController _instructionsController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _frequencyController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  void _saveMedication() {
    if (_formKey.currentState!.validate()) {
      final medication = {
        'name': _nameController.text.trim(),
        'dosage': _dosageController.text.trim(),
        'frequency': _frequencyController.text.trim(),
        'instructions': _instructionsController.text.trim(),
      };

      Navigator.pop(context, medication);
    }
  }

  InputDecoration _fieldDecoration({
    required String label,
    required IconData icon,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF24466F),
        foregroundColor: Colors.white,
        title: const Text(
          'Add Medication',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Medication Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF173B68),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Enter the information for the medication you would like to add.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 28),

                Semantics(
                  label: 'Medication name input',
                  textField: true,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: _fieldDecoration(
                      label: 'Medication Name',
                      icon: Icons.medication_outlined,
                      hint: 'Example: Lisinopril',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a medication name';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Semantics(
                  label: 'Medication dosage input',
                  textField: true,
                  child: TextFormField(
                    controller: _dosageController,
                    decoration: _fieldDecoration(
                      label: 'Dosage',
                      icon: Icons.scale_outlined,
                      hint: 'Example: 10 mg',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a dosage';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Semantics(
                  label: 'Medication frequency input',
                  textField: true,
                  child: TextFormField(
                    controller: _frequencyController,
                    decoration: _fieldDecoration(
                      label: 'Frequency',
                      icon: Icons.schedule,
                      hint: 'Example: Once daily',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a frequency';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Semantics(
                  label: 'Medication instructions input',
                  textField: true,
                  child: TextFormField(
                    controller: _instructionsController,
                    maxLines: 3,
                    decoration: _fieldDecoration(
                      label: 'Instructions',
                      icon: Icons.notes,
                      hint: 'Example: Take with food',
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Semantics(
                  button: true,
                  label: 'Save medication',
                  child: SizedBox(
                    height: 64,
                    child: ElevatedButton.icon(
                      onPressed: _saveMedication,
                      icon: const Icon(Icons.check),
                      label: const Text(
                        'Save Medication',
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

                const SizedBox(height: 12),

                Semantics(
                  button: true,
                  label: 'Cancel adding medication',
                  child: SizedBox(
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}