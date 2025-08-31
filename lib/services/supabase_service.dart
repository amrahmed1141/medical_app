import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/model/appointment/appointment_model.dart';
import 'package:medical_app/model/category_model.dart';
import 'package:medical_app/model/doctors/doctors_model.dart';
import 'package:medical_app/model/users/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<AuthResponse> signUp(
      String email, String password, Map<String, dynamic> data) async {
    return await _client.auth
        .signUp(password: password, email: email, data: data);
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  Future<UserModel?> getCurrentUser(String userId) async {
    try {
      final response = await _client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response == null) {
        // Create profile if it doesn't exist
        return await _createUserProfile(userId);
      }

      return UserModel.fromJson(response);
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }

  Future<UserModel> _createUserProfile(String userId) async {
    try {
      final authUser = _client.auth.currentUser;

      final newUser = UserModel(
        id: userId,
        email: authUser?.email ?? '',
        name: authUser?.userMetadata?['name'] ?? '',
        avatar: authUser?.userMetadata?['avatar'] ?? '',
        createdAt: DateTime.now(),
      );

      await _client.from('profiles').insert(newUser.toJson());

      return newUser;
    } catch (e) {
      debugPrint('Error creating user profile: $e');
      rethrow;
    }
  }

// ==================== DOCTOR METHODS BY CATEGORY ====================

  Future<List<Doctor>> getAllDoctors() async {
    try {
      final response = await _client.from('doctors').select().order('name');

      return (response as List)
          .map((doctor) => Doctor.fromJson(doctor))
          .toList();
    } catch (e) {
      debugPrint('Error getting doctors: $e');
      return [];
    }
  }

  Future<List<Doctor>> getDoctorsBySpecialty(String specialty) async {
    try {
      final response = await _client
          .from('doctors')
          .select()
          .eq('specialty', specialty)
          .order('rating', ascending: false);

      return (response as List)
          .map((doctor) => Doctor.fromJson(doctor))
          .toList();
    } catch (e) {
      debugPrint('Error getting doctors by specialty: $e');
      return [];
    }
  }

  Future<List<Doctor>> getDoctorsByCategoryName(String categoryName) async {
    try {
      // Find the specialty key from category name
      final category = categories.firstWhere(
        (cat) => cat.name == categoryName,
        orElse: () => MedicalCategory(
            name: '', icon: FontAwesomeIcons.user, specialtyKey: ''),
      );

      if (category.specialtyKey.isEmpty) return [];

      return await getDoctorsBySpecialty(category.specialtyKey);
    } catch (e) {
      debugPrint('Error getting doctors by category name: $e');
      return [];
    }
  }

// ==================== APPOINTMENTS ====================

  // Appointment Methods
Future<List<Appointment>> getUserAppointments(String userId) async {
  try {
    final response = await _client
        .from('appointments')
        .select()
        .eq('user_id', userId)
        .order('date', ascending: false)
        .order('time', ascending: false);

    return (response as List).map((appt) => Appointment.fromJson(appt)).toList();
  } catch (e) {
    debugPrint('Error getting user appointments: $e');
    return [];
  }
}

Future<bool> createAppointment(Map<String, dynamic> appointmentData) async {
  try {
    debugPrint('Creating appointment with data: $appointmentData');
    
    // Use .insert() with .select() to get the inserted data back
    final response = await _client
        .from('appointments')
        .insert(appointmentData)
        .select(); // Add this to get response data

    debugPrint('Supabase response: $response');

    // If response is not null and is a list, it was successful
    if (response != null && response is List && response.isNotEmpty) {
      debugPrint('Appointment created successfully: $response');
      return true;
    } else {
      debugPrint('Failed to create appointment - empty or null response');
      return false;
    }
  } catch (e) {
    debugPrint('Error creating appointment: $e');
    return false;
  }
}
Future<bool> updateAppointmentStatus(String appointmentId, String status) async {
  try {
    await _client
        .from('appointments')
        .update({'status': status})
        .eq('id', appointmentId);
    
    return true;
  } catch (e) {
    debugPrint('Error updating appointment status: $e');
    return false;
  }
}
}
