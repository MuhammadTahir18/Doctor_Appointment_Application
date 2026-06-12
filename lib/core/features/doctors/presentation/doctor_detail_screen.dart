import 'package:flutter/material.dart';
import '../../appointments/presentation/book_appointment_screen.dart';
import '../../chat/presentation/chat_screen.dart';
import '../data/doctor_model.dart';

class DoctorDetailScreen extends StatelessWidget {
  final DoctorModel doctor;
  const DoctorDetailScreen({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          // Top blue header
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color(0xFF2563EB),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF2563EB),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // Doctor image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        doctor.image,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: const Icon(Icons.person,
                              color: Colors.white, size: 50),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(doctor.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    Text(doctor.specialty,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        )),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Stats row
                  Row(
                    children: [
                      _StatCard(
                        icon: Icons.star,
                        iconColor: Colors.amber,
                        value: '${doctor.rating}',
                        label: 'Rating',
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        icon: Icons.work_outline,
                        iconColor: const Color(0xFF2563EB),
                        value: '${doctor.experience} yr',
                        label: 'Experience',
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        icon: Icons.attach_money,
                        iconColor: Colors.green,
                        value: 'Rs.${doctor.fee}',
                        label: 'Fee',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // About
                  const Text('About Doctor',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      )),
                  const SizedBox(height: 8),
                  Text(doctor.about,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.6,
                      )),

                  const SizedBox(height: 24),

                  // Location
                  const Text('Location',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      )),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Color(0xFF2563EB), size: 18),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(doctor.address,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            )),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Availability
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: doctor.isAvailable
                              ? Colors.green
                              : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        doctor.isAvailable
                            ? 'Available Today'
                            : 'Not Available',
                        style: TextStyle(
                          color: doctor.isAvailable
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2563EB)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatScreen(doctor: doctor),
                          ),
                        );
                      },
                      icon: const Icon(Icons.chat_outlined, color: Color(0xFF2563EB)),
                      label: const Text('Chat with Doctor',
                          style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),

                  const SizedBox(height: 12),
                  // Book Appointment Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: doctor.isAvailable
                            ? const Color(0xFF2563EB)
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: doctor.isAvailable ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookAppointmentScreen(
                              doctor: doctor,
                            ),
                          ),
                        );
                      } : null,

                      child: const Text(
                        'Book Appointment',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(height: 6),
            Text(value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                )),
            Text(label,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }
}