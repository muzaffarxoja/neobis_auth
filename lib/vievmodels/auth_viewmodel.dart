import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  List<UserModel> _users = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<UserModel> get users => _users;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      final user = await _authRepository.login(email, password);
      if (user != null) {
        _users.add(user);
        notifyListeners();
      }
    } catch (e) {
      _setErrorMessage(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register(String email, String password) async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      final user = await _authRepository.register(email, password);
      if (user != null) {
        _users.add(user);
        notifyListeners();
      }
    } catch (e) {
      _setErrorMessage(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadSavedUsers() async {
    final savedUsers = await _authRepository.getSavedUsers();
    _users = savedUsers;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
