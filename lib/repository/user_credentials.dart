import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Shared Preferences Example')),
        body: Center(child: CredentialsForm()),
      ),
    );
  }
}

class CredentialsForm extends StatefulWidget {
  @override
  _CredentialsFormState createState() => _CredentialsFormState();
}

class _CredentialsFormState extends State<CredentialsForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> saveCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> credentials = {'username': username, 'password': password};
    String jsonString = jsonEncode(credentials);
    await prefs.setString('credentials', jsonString);
  }

  Future<Map<String, String>?> getCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('credentials');
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return jsonMap.map((key, value) => MapEntry(key, value as String));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              String username = _usernameController.text;
              String password = _passwordController.text;
              await saveCredentials(username, password);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Credentials saved.')),
              );
            },
            child: Text('Save Credentials'),
          ),
          ElevatedButton(
            onPressed: () async {
              Map<String, String>? credentials = await getCredentials();
              if (credentials != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Username: ${credentials['username']}, Password: ${credentials['password']}'),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No credentials found.')),
                );
              }
            },
            child: Text('Retrieve Credentials'),
          ),
        ],
      ),
    );
  }
}
