import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    final response = await _client
        .from('doctors')
        .select()
        .order('name');
    
    return (response as List).map((doctor) => Doctor.fromJson(doctor)).toList();
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
    
    return (response as List).map((doctor) => Doctor.fromJson(doctor)).toList();
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
      orElse: () => MedicalCategory(name: '', icon: FontAwesomeIcons.user, specialtyKey: ''),
    );
    
    if (category.specialtyKey.isEmpty) return [];
    
    return await getDoctorsBySpecialty(category.specialtyKey);
  } catch (e) {
    debugPrint('Error getting doctors by category name: $e');
    return [];
  }
}

}
