// lib/views/appointments/appointment_list_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_app/controller/appointment/appointment_controller.dart';
import 'package:medical_app/model/appointment/appointment_model.dart';

class AppointmentListScreen extends StatelessWidget {
  const AppointmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<AppointmentController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${controller.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.loadUserAppointments(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (controller.appointments.isEmpty) {
            return const Center(
              child: Text(
                'No appointments yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Completed'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildAppointmentList(controller.appointments, context),
                      _buildAppointmentList(controller.upcomingAppointments, context),
                      _buildAppointmentList(controller.completedAppointments, context),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppointmentList(List<Appointment> appointments, BuildContext context) {
    if (appointments.isEmpty) {
      return const Center(
        child: Text('No appointments in this category'),
      );
    }

    return RefreshIndicator(
      onRefresh: () => context.read<AppointmentController>().loadUserAppointments(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return _buildAppointmentCard(appointment, context);
        },
      ),
    );
  }

  Widget _buildAppointmentCard(Appointment appointment, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(appointment.doctorImage),
                  onBackgroundImageError: (_, __) {},
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.doctorName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        appointment.doctorSpecialty,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(appointment.status),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoItem(Icons.calendar_today, appointment.formattedDate),
                const SizedBox(width: 16),
                _buildInfoItem(Icons.access_time, appointment.formattedTime),
                const SizedBox(width: 16),
                _buildInfoItem(Icons.attach_money, '\$${appointment.price}'),
              ],
            ),
            if (appointment.notes != null && appointment.notes!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Notes: ${appointment.notes}',
                style: TextStyle(color: Colors.grey[700], fontStyle: FontStyle.italic),
              ),
            ],
            const SizedBox(height: 12),
            _buildActionButtons(appointment, context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    
    switch (status) {
      case 'confirmed':
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        break;
      case 'pending':
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[800]!;
        break;
      case 'cancelled':
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        break;
      case 'completed':
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue[800]!;
        break;
      default:
        backgroundColor = Colors.grey[100]!;
        textColor = Colors.grey[800]!;
    }
    
    return Chip(
      label: Text(
        status.toUpperCase(),
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: textColor),
      ),
      backgroundColor: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.blue),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildActionButtons(Appointment appointment, BuildContext context) {
    final controller = context.read<AppointmentController>();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (appointment.status == 'pending') ...[
          ElevatedButton(
            onPressed: () => controller.cancelAppointment(appointment.id),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => controller.confirmAppointment(appointment.id),
            style: ElevatedButton.styleFrom(
             primary: Colors.green,
              onPrimary: Colors.white,
            ),
            child: const Text('Confirm'),
          ),
        ],
        if (appointment.status == 'confirmed') 
          ElevatedButton(
            onPressed: () => controller.cancelAppointment(appointment.id),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,
            ),
            child: const Text('Cancel'),
          ),
      ],
    );
  }
}