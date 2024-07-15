import 'package:flutter_regex/flutter_regex.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neobis_flutter_auth/widgets/custom_text_form_field.dart';
import '../widgets/custom_elevated_button.dart';

// String email = 'abc@gmail.com';
// String phone = '+998 99 870 99 99';

// bool isEmail = email.isEmail();
// bool isPhone = phone.isPhone();

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasDigit = false;
  bool hasSpecialCharacter = false;
  bool hasValidLength = false;

  void _onPasswordChanged(String password) {
    setState(() {
      if (password.isEmpty) {
        hasUpperCase = false;
        hasLowerCase = false;
        hasDigit = false;
        hasSpecialCharacter = false;
        hasValidLength = false;
      } else {
        hasUpperCase = RegExp(r'[A-Z]').hasMatch(password);
        hasLowerCase = RegExp(r'[a-z]').hasMatch(password);
        hasDigit = RegExp(r'[0-9]').hasMatch(password);
        hasSpecialCharacter =
            RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password);
        hasValidLength = password.length >= 8 && password.length <= 15;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
        title: Center(
          child: Text(
            'Registration',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Create acount \nLorby',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Color(0xff212121),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                      controller: emailController,
                      labelText: 'Enter Emai',
                      obscureText: false),
                  SizedBox(height: 14),
                  CustomTextFormField(
                      controller: loginController,
                      labelText: 'Enter login',
                      obscureText: false),
                  SizedBox(height: 14),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: _onPasswordChanged,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (!hasUpperCase ||
                          !hasLowerCase ||
                          !hasDigit ||
                          !hasSpecialCharacter ||
                          !hasValidLength) {
                        return 'Password does not meet all conditions';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  PasswordCriteriaRow(
                      text: 'At least 1 uppercase letter',
                      isValid: hasUpperCase),
                  PasswordCriteriaRow(
                      text: 'At least 1 lowercase letter',
                      isValid: hasLowerCase),
                  PasswordCriteriaRow(
                      text: 'At least 1 digit', isValid: hasDigit),
                  PasswordCriteriaRow(
                      text: 'At least 1 special character',
                      isValid: hasSpecialCharacter),
                  PasswordCriteriaRow(
                      text: '8 to 15 characters long', isValid: hasValidLength),
                  SizedBox(height: 14),
                  CustomTextFormField(
                      controller: loginController,
                      labelText: 'Confirm password',
                      obscureText: false),
                  SizedBox(height: 14),
                  CustomElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Process the registration
                      }
                    },
                    text: 'Register',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordCriteriaRow extends StatelessWidget {
  final String text;
  final bool isValid;

  const PasswordCriteriaRow({required this.text, required this.isValid});

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black; // Default text color

    if (isValid) {
      textColor = Colors.green;
    }

    return Row(
      children: [
        Icon(
          isValid ? Icons.check : Icons.close,
          color: isValid ? Colors.green : Colors.red,
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ],
    );
  }
}
