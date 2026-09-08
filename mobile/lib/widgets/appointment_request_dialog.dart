import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AppointmentRequestDialog extends StatefulWidget {
  const AppointmentRequestDialog({super.key});

  @override
  State<AppointmentRequestDialog> createState() =>
      _AppointmentRequestDialogState();
}

class _AppointmentRequestDialogState extends State<AppointmentRequestDialog> {
  final _formKey = GlobalKey<FormState>();
  final _summaryController = TextEditingController();
  String? _selectedProvider;
  DateTime? _preferredDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? _attachmentName;
  String? _dateError;
  String? _startTimeError;
  String? _endTimeError;

  @override
  void dispose() {
    _summaryController.dispose();
    super.dispose();
  }

  Future<void> _selectPreferredDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _preferredDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedDate != null) {
      setState(() => _preferredDate = selectedDate);
    }
  }

  Future<void> _selectTime({required bool isStartTime}) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? (_startTime ?? const TimeOfDay(hour: 9, minute: 0))
          : (_endTime ?? const TimeOfDay(hour: 10, minute: 0)),
    );
    if (selectedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = selectedTime;
        } else {
          _endTime = selectedTime;
        }
      });
    }
  }

  Future<void> _selectAttachment() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'doc', 'docx'],
    );
    if (result != null && result.files.single.name.isNotEmpty) {
      setState(() => _attachmentName = result.files.single.name);
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select date';
    return '${date.month}/${date.day}/${date.year}';
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return 'Select time';
    return time.format(context);
  }

  Widget _labeledControl(String label, Widget control) {
    return Semantics(
      label: label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          control,
        ],
      ),
    );
  }

  Widget _controlWithError(Widget control, String? errorMessage) {
    if (errorMessage == null) return control;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        control,
        Padding(
          padding: const EdgeInsets.only(left: 12, top: 4),
          child: Text(
            errorMessage,
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  bool _validateRequiredFields() {
    final isProviderValid = _formKey.currentState?.validate() ?? false;

    // Date and time controls are buttons, so they need manual validation
    // alongside the provider field managed by FormField.
    setState(() {
      _dateError = _preferredDate == null ? 'Select a preferred date' : null;
      _startTimeError = _startTime == null ? 'Select a start time' : null;
      _endTimeError = _endTime == null ? 'Select an end time' : null;
    });

    return isProviderValid &&
        _dateError == null &&
        _startTimeError == null &&
        _endTimeError == null;
  }

  void _submitRequest() {
    if (_validateRequiredFields()) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Request an appointment'),
      content: SingleChildScrollView(
        child: SizedBox(
          width: 480,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  label: 'Medical provider, required',
                  child: DropdownButtonFormField<String>(
                    initialValue: _selectedProvider,
                    decoration: const InputDecoration(
                      labelText: 'Medical provider (required)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Select a medical provider'
                        : null,
                    items: const [
                      DropdownMenuItem(
                        value: 'Dr. Sarah Chen',
                        child: Text('Dr. Sarah Chen · Primary Care'),
                      ),
                      DropdownMenuItem(
                        value: 'Dr. Marcus Webb',
                        child: Text('Dr. Marcus Webb · Cardiology'),
                      ),
                      DropdownMenuItem(
                        value: 'Dr. Priya Nair',
                        child: Text('Dr. Priya Nair · Endocrinology'),
                      ),
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedProvider = value),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Preferred date and time range',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final dateButton = Semantics(
                      button: true,
                      label:
                          'Preferred date, required: ${_formatDate(_preferredDate)}',
                      child: OutlinedButton.icon(
                        onPressed: _selectPreferredDate,
                        icon: const Icon(Icons.calendar_today_outlined),
                        label: Text(_formatDate(_preferredDate)),
                      ),
                    );
                    final startTimeButton = Semantics(
                      button: true,
                      label: 'Start time, required: ${_formatTime(_startTime)}',
                      child: OutlinedButton(
                        onPressed: () => _selectTime(isStartTime: true),
                        child: Text(_formatTime(_startTime)),
                      ),
                    );
                    final endTimeButton = Semantics(
                      button: true,
                      label: 'End time, required: ${_formatTime(_endTime)}',
                      child: OutlinedButton(
                        onPressed: () => _selectTime(isStartTime: false),
                        child: Text(_formatTime(_endTime)),
                      ),
                    );

                    if (constraints.maxWidth < 420) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _labeledControl(
                            'Preferred date (required)',
                            _controlWithError(dateButton, _dateError),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: _labeledControl(
                                  'Start time (required)',
                                  _controlWithError(
                                    startTimeButton,
                                    _startTimeError,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Text('to'),
                              ),
                              Expanded(
                                child: _labeledControl(
                                  'End time (required)',
                                  _controlWithError(
                                    endTimeButton,
                                    _endTimeError,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: _labeledControl(
                            'Preferred date (required)',
                            _controlWithError(dateButton, _dateError),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _labeledControl(
                            'Start time (required)',
                            _controlWithError(startTimeButton, _startTimeError),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Text('to'),
                        ),
                        Expanded(
                          child: _labeledControl(
                            'End time (required)',
                            _controlWithError(endTimeButton, _endTimeError),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 18),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final summaryField = Semantics(
                      textField: true,
                      label: 'Additional information, optional',
                      child: TextField(
                        controller: _summaryController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Additional information (optional)',
                          hintText:
                              'Tell us anything the care team should know',
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    );
                    final attachmentButton = Semantics(
                      button: true,
                      label: 'Attach an optional document',
                      child: OutlinedButton.icon(
                        onPressed: _selectAttachment,
                        icon: const Icon(Icons.attach_file),
                        label: const Text('Attach document (optional)'),
                      ),
                    );

                    if (constraints.maxWidth < 420) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          summaryField,
                          const SizedBox(height: 8),
                          attachmentButton,
                        ],
                      );
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: summaryField),
                        const SizedBox(width: 12),
                        attachmentButton,
                      ],
                    );
                  },
                ),
                if (_attachmentName != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.description_outlined, size: 18),
                      const SizedBox(width: 6),
                      Expanded(child: Text(_attachmentName!)),
                      Semantics(
                        button: true,
                        label: 'Remove attached document',
                        child: IconButton(
                          onPressed: () =>
                              setState(() => _attachmentName = null),
                          tooltip: 'Remove attachment',
                          icon: const Icon(Icons.close, size: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      actions: [
        Semantics(
          button: true,
          label: 'Cancel appointment request',
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ),
        Semantics(
          button: true,
          label: 'Submit appointment request',
          child: FilledButton(
            onPressed: _submitRequest,
            child: const Text('Submit request'),
          ),
        ),
      ],
    );
  }
}
