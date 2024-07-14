import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class SharedPreferencesService {
  static const String _keyUsers = 'users';

  Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> usersList = prefs.getStringList(_keyUsers) ?? [];
    final userJson = jsonEncode(user.toJson());
    usersList.add(userJson);
    prefs.setStringList(_keyUsers, usersList);
  }

  Future<List<UserModel>> getUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> usersList = prefs.getStringList(_keyUsers) ?? [];
    return usersList.map((userJson) => UserModel.fromJson(jsonDecode(userJson))).toList();
  }
}
