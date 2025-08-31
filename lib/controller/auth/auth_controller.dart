import 'package:flutter/material.dart';
import 'package:medical_app/controller/appointment/appointment_controller.dart';
import 'package:medical_app/model/users/user_model.dart';
import 'package:medical_app/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart'; // Add this import

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

  Future<void> setSession(Session session, BuildContext context) async {
    _session = session;
    await _loadCurrentUser(context); // Pass context to load user
  }

  Future<void> _loadCurrentUser(BuildContext context) async {
    if (_session?.user.id != null) {
      _currentUser = await _supabaseService.getCurrentUser(_session!.user.id);
      
      // Set user ID in AppointmentController after loading user
      final appointmentController = context.read<AppointmentController>();
      appointmentController.setUserId(_session!.user.id);
      
      // Load user appointments
      await appointmentController.loadUserAppointments();
      
      notifyListeners();
    }
  }

  Future<bool> signUp(String email, String password, String name, BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _supabaseService.signUp(email, password, {'name': name});

      if (response.user == null) {
        _error = 'Failed to create account';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      await setSession(response.session!, context); // Pass context
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

  Future<bool> signIn(String email, String password, BuildContext context) async {
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

      await setSession(response.session!, context); // Pass context
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

  Future<void> signOut(BuildContext context) async {
    try {
      await _supabaseService.signOut();
      _currentUser = null;
      _session = null;
      
      // Clear appointment controller state
      final appointmentController = context.read<AppointmentController>();
      appointmentController.setUserId('');
      
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
