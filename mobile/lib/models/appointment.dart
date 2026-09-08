class Appointment {
  final String providerName;
  final String specialty;
  final String dateLabel;
  final String location;
  final String? timeAway;
  final bool isTelehealth;

  const Appointment({
    required this.providerName,
    required this.specialty,
    required this.dateLabel,
    required this.location,
    this.timeAway,
    required this.isTelehealth,
  });
}
