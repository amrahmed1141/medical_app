import 'package:flutter/material.dart';
import 'package:medical_app/model/users/user_model.dart';
import 'package:medical_app/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends ChangeNotifier {
  UserModel? _currentUser;
  Session? _session;
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  Session? get session => _session;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;

  final SupabaseService _supabaseService = SupabaseService();

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<void> setSession(Session session) async {
    _session = session;
    await _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    if (_session?.user.id != null) {
      _currentUser = await _supabaseService.getCurrentUser(_session!.user.id);
      notifyListeners();
    }
  }

  Future<bool> signUp(String email, String password, String name) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response =
          await _supabaseService.signUp(email, password, {'name': name});

      if (response.user == null) {
        _error = 'failed to create account';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      await setSession(response.session!);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _supabaseService.signIn(email, password);

      if (response.user == null) {
        _error = 'Invalid email or password';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      await setSession(response.session!);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut()async{
    try{
    await _supabaseService.signOut();
    _currentUser=null;
    _session=null;
    notifyListeners();
    } catch(e){
     _error = e.toString();
      notifyListeners();

    }
  }
}
