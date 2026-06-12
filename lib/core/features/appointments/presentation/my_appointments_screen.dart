import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointment_cubit.dart';
import '../data/appointment_model.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppointmentCubit()..loadMyAppointments(),
      child: const _MyAppointmentsView(),
    );
  }
}

class _MyAppointmentsView extends StatelessWidget {
  const _MyAppointmentsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text('My Appointments',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: BlocBuilder<AppointmentCubit, AppointmentState>(
        builder: (context, state) {

          if (state is AppointmentLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF2563EB)),
            );
          }

          if (state is AppointmentError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(state.message,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          if (state is AppointmentLoaded) {
            if (state.appointments.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_outlined,
                        size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No appointments yet',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        )),
                    SizedBox(height: 8),
                    Text('Book your first appointment',
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.appointments.length,
              itemBuilder: (context, index) {
                return _AppointmentCard(
                  appointment: state.appointments[index],
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  const _AppointmentCard({required this.appointment});

  Color get _statusColor {
    switch (appointment.status) {
      case 'confirmed': return Colors.green;
      case 'cancelled': return Colors.red;
      default: return Colors.orange;
    }
  }

  IconData get _statusIcon {
    switch (appointment.status) {
      case 'confirmed': return Icons.check_circle;
      case 'cancelled': return Icons.cancel;
      default: return Icons.access_time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // Top section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Doctor image
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    appointment.doctorImage,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F1FB),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Icon(Icons.person,
                          color: Color(0xFF2563EB)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Doctor info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appointment.doctorName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          )),
                      const SizedBox(height: 2),
                      Text(appointment.doctorSpecialty,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF2563EB),
                          )),
                    ],
                  ),
                ),

                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_statusIcon, color: _statusColor, size: 12),
                      const SizedBox(width: 4),
                      Text(
                          appointment.status[0].toUpperCase() +
                              appointment.status.substring(1),
                          style: TextStyle(
                            color: _statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Divider
          const Divider(height: 1, color: Color(0xFFE2E8F0)),

          // Bottom section — date, time, fee
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Date
                const Icon(Icons.calendar_today_outlined,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(appointment.date,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    )),
                const SizedBox(width: 16),

                // Time
                const Icon(Icons.access_time,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(appointment.time,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    )),

                const Spacer(),

                // Fee
                Text('Rs.${appointment.fee}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2563EB),
                    )),
              ],
            ),
          ),

          // Cancel button — sirf pending appointments pe
          if (appointment.status == 'pending')
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Confirm dialog
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Cancel Appointment'),
                        content: const Text(
                            'Are you sure you want to cancel?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<AppointmentCubit>()
                                  .cancelAppointment(appointment.id);
                            },
                            child: const Text('Yes, Cancel',
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Cancel Appointment',
                      style: TextStyle(color: Colors.red)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}