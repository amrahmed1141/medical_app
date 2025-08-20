import 'package:flutter/cupertino.dart';
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



}
