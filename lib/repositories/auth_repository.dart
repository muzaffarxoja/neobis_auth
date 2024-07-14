import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/shared_preferences_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();
  final SharedPreferencesService _sharedPreferencesService = SharedPreferencesService();

  Future<UserModel?> login(String email, String password) async {
    final response = await _apiService.login(email, password);
    if (response != null) {
      final user = UserModel(email: email, password: password);
      await _sharedPreferencesService.saveUser(user);
      return user;
    }
    return null;
  }

  Future<UserModel?> register(String email, String password) async {
    final response = await _apiService.register(email, password);
    if (response != null) {
      final user = UserModel(email: email, password: password);
      await _sharedPreferencesService.saveUser(user);
      return user;
    }
    return null;
  }

  Future<List<UserModel>> getSavedUsers() async {
    return await _sharedPreferencesService.getUsers();
  }
}
