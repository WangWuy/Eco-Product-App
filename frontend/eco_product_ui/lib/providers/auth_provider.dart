import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import '../services/token_storage.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService;
  final TokenStorage _tokenStorage;

  bool _isLoading = false;
  bool _isLoggedIn = false;

  AuthProvider({
    required ApiService apiService,
    required TokenStorage tokenStorage,
  })  : _apiService = apiService,
        _tokenStorage = tokenStorage {
    initializeAuth();
  }

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  // Initialize authentication state
  Future<void> initializeAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      final hasToken = await _tokenStorage.hasToken();
      _isLoggedIn = hasToken;
    } catch (e) {
      _isLoggedIn = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login
  Future<bool> login(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      final success = await _apiService.login(email, password);
      _isLoggedIn = success;
      return success;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      _isLoading = true;
      notifyListeners();

      await _apiService.logout();
      await _tokenStorage.removeToken();

      _isLoggedIn = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
