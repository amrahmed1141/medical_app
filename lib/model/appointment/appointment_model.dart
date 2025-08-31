import 'package:flutter/material.dart';

class Appointment {
  final String id;
  final String userId;
  final int doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImage;
  final DateTime date;
  final String time; // CHANGE: TimeOfDay → String
  final String status;
  final double price;
  final String? notes;
  final DateTime createdAt;
  final String? paymentId;

  Appointment({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImage,
    required this.date,
    required this.time, // CHANGE: TimeOfDay → String
    required this.status,
    required this.price,
    this.notes,
    required this.createdAt,
    this.paymentId,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? '',
      userId: json['user_id'] ?? '',
      doctorId: json['doctor_id'] ?? 0,
      doctorName: json['doctor_name'] ?? '',
      doctorSpecialty: json['doctor_specialty'] ?? '',
      doctorImage: json['doctor_image'] ?? '',
      date: DateTime.parse(json['date']),
      time: json['time'] ?? '09:00', // CHANGE: Just use string directly
      status: json['status'] ?? 'pending',
      price: (json['price'] ?? 0.0).toDouble(),
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      paymentId: json['payment_id'],
    );
  }

  // REMOVE the _parseTime method completely

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'doctor_id': doctorId,
      'doctor_name': doctorName,
      'doctor_specialty': doctorSpecialty,
      'doctor_image': doctorImage,
      'date': date.toIso8601String().split('T')[0],
      'time': time, // Just use the string directly
      'status': status,
      'price': price,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'payment_id': paymentId,
    };
  }

  // Helper method to convert string time to TimeOfDay if needed
  TimeOfDay get timeOfDay {
    try {
      final parts = time.split(':');
      return TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    } catch (e) {
      return const TimeOfDay(hour: 9, minute: 0);
    }
  }

  String get formattedDate => '${date.day}/${date.month}/${date.year}';
  String get formattedTime => time;
  bool get isUpcoming => status == 'confirmed' || status == 'pending';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';
}
