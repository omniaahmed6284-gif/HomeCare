import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;


  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
    String? address,
    required String role,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.signUp(
        name: name,
        email: email,
        password: password,
        phone: phone,
        address: address,
        role: role,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.login(
        email: email,
        password: password,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> logout() async {
    await _authService.logout();

    _user = null;

    notifyListeners();
  }

  Future<void> loadCurrentUser() async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await _authService.getCurrentUserData();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
