import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:neobis_flutter_auth/viewmodels/auth_viewmodel.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/custom_password_field.dart';
import '../widgets/custom_elevated_button.dart';
import '../main.dart';
import 'package:go_router/go_router.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AuthViewModel>(
          builder: (context, authViewModel, child) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: emailController,
                    labelText: 'Email',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  CustomPasswordField(
                    controller: passwordController,
                    labelText: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  authViewModel.isLoading
                      ? CircularProgressIndicator()
                      : CustomElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authViewModel.login(
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          },
                          text: 'Login',
                        ),
                  SizedBox(height: 28),
                  TextButton(
                      onPressed: () => context.push(register_page),
                      child: Text('I don\'t have account')),
                  if (authViewModel.errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        authViewModel.errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
