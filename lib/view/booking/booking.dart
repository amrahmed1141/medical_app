import 'package:flutter/material.dart';
import 'package:medical_app/controller/appointment/appointment_controller.dart';
import 'package:medical_app/controller/auth/auth_controller.dart';
import 'package:medical_app/model/doctors/doctors_model.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatefulWidget {
  final Doctor doctor;

  const BookingScreen({super.key, required this.doctor});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  final TextEditingController _notesController = TextEditingController();
  bool _isLoading = false;

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() => _selectedTime = picked);
    }
  }

  Future<void> _bookAppointment() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      final appointmentController = context.read<AppointmentController>();
      final authController = context.read<AuthController>();
      
      // NULL SAFETY CHECK
      if (authController.currentUser?.id == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login first')),
        );
        setState(() => _isLoading = false);
        return;
      }

      try {
        final success = await appointmentController.bookAppointment(
          doctorId: widget.doctor.id.toString(),
          doctorName: widget.doctor.name,
          doctorSpecialty: widget.doctor.specialty,
          doctorImage: widget.doctor.imageUrl,
          date: _selectedDate,
          time: '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
          price: widget.doctor.pricePerHour,
          notes: _notesController.text,
        );

        if (mounted) {
          setState(() => _isLoading = false);
          
          if (success) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Appointment booked successfully!')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to book appointment')),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    // Doctor Info
                    _buildDoctorInfo(),
                    const SizedBox(height: 20),
                    
                    // Date Selection
                    _buildDateSelector(),
                    const SizedBox(height: 16),
                    
                    // Time Selection
                    _buildTimeSelector(),
                    const SizedBox(height: 16),
                    
                    // Notes
                    TextFormField(
                      controller: _notesController,
                      decoration: const InputDecoration(
                        labelText: 'Additional Notes (Optional)',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(16),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 32),
                    
                    // Book Button
                    _buildBookButton(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDoctorInfo() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.doctor.imageUrl),
              onBackgroundImageError: (exception, stackTrace) {
                // Handle image loading errors
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.doctor.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.doctor.specialty,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.doctor.hospital,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${widget.doctor.pricePerHour.toStringAsFixed(0)} per hour',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Date',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectDate(context),
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.calendar_today, color: Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Time',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () => _selectTime(context),
          child: InputDecorator(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedTime.format(context),
                  style: const TextStyle(fontSize: 16),
                ),
                const Icon(Icons.access_time, color: Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _bookAppointment,
        style: ElevatedButton.styleFrom(
          primary: const Color(0xff4894FE),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Book Appointment',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}