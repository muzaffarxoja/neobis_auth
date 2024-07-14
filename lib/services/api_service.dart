class ApiService {
  Future<Map<String, dynamic>?> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    return {'token': 'dummy_token'};
  }

  Future<Map<String, dynamic>?> register(String email, String password) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 2));
    return {'token': 'dummy_token'};
  }
}
