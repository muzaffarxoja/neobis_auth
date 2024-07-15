import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:neobis_flutter_auth/viewmodels/auth_viewmodel.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/custom_password_field.dart';

// class CustomTextFormField extends StatelessWidget {
//   final TextEditingController controller;
//   final String labelText;
//   final bool obscureText;
//   final String? Function(String?)? validator;

//   CustomTextFormField({
//     required this.controller,
//     required this.labelText,
//     required this.obscureText,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(labelText: labelText),
//       obscureText: obscureText,
//       validator: validator,
//     );
//   }
// }

// class CustomPasswordField extends StatefulWidget {
//   final TextEditingController controller;
//   final String labelText;
//   final String? Function(String?)? validator;

//   CustomPasswordField({
//     required this.controller,
//     required this.labelText,
//     this.validator,
//   });

//   @override
//   _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
// }

// class _CustomPasswordFieldState extends State<CustomPasswordField> {
//   bool _obscureText = true;

//   void _togglePasswordVisibility() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.controller,
//       obscureText: _obscureText,
//       decoration: InputDecoration(
//         labelText: widget.labelText,
//         suffixIcon: IconButton(
//           icon: Icon(
//             _obscureText ? Icons.visibility_off : Icons.visibility,
//           ),
//           onPressed: _togglePasswordVisibility,
//         ),
//       ),
//       validator: widget.validator,
//     );
//   }
// }

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
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              authViewModel.login(
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          },
                          child: Text('Login'),
                        ),
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
