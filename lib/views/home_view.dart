import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ListView.builder(
        itemCount: authViewModel.users.length,
        itemBuilder: (context, index) {
          final user = authViewModel.users[index];
          return ListTile(
            title: Text(user.email),
          );
        },
      ),
    );
  }
}
