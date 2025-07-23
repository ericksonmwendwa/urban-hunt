import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_hunt/form/custom_password_field.dart';
import 'package:urban_hunt/services/auth_service.dart';
import 'package:urban_hunt/widget/custom_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final AuthService _authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loading = false;
  bool _obscureText = true;

  String _currentPassword = '';
  String _newPassword = '';

  void _onSubmit() async {
    try {
      if (!_formKey.currentState!.validate()) return;

      setState(() => _loading = true);

      await _authService.checkPassword(_currentPassword);

      await _authService.updatePassword(_newPassword);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password updated successfully.'),
          backgroundColor: Colors.greenAccent,
        ),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      String message = 'Something went wrong. Please try again.';

      if (error.code == 'invalid-credential') {
        message = 'The current password is incorrect.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong. Try again.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Change Password')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CustomPasswordField(
                  label: 'Current Password',
                  obscureText: _obscureText,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (String value) {
                    _currentPassword = value;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password.';
                    }

                    return null;
                  },
                  onTap: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                ),
                const SizedBox(height: 16.0),
                CustomPasswordField(
                  label: 'New Password',
                  obscureText: _obscureText,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (String value) {
                    _newPassword = value;
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password.';
                    }

                    if (value.length < 8) {
                      return 'Password must be at least 8 characters.';
                    }

                    return null;
                  },
                  onTap: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                ),
                const Spacer(),
                CustomButton(text: 'Save', loading: _loading, onTap: _onSubmit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
