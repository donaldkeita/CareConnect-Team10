import '../models/appointment.dart';

class AppointmentService {
  const AppointmentService();

  List<Appointment> getUpcomingAppointments() {
    return const [
      Appointment(
        providerName: 'Dr. Sarah Chen',
        specialty: 'Primary Care',
        dateLabel: 'Tue, Sep 1 · 12:20 AM',
        location: 'Northside Medical Center, Suite 210',
        timeAway: '~4h away',
        isTelehealth: false,
      ),
      Appointment(
        providerName: 'Dr. Marcus Webb',
        specialty: 'Cardiology',
        dateLabel: 'Tue, Sep 1 · 6:20 PM',
        location: 'Telehealth - Video Call',
        timeAway: '~22h away',
        isTelehealth: true,
      ),
      Appointment(
        providerName: 'Dr. Priya Nair',
        specialty: 'Endocrinology',
        dateLabel: 'Sat, Sep 5 · 8:20 PM',
        location: 'Westfield Health Pavilion, Room 114',
        isTelehealth: false,
      ),
    ];
  }
}
