import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_hunt/form/custom_password_field.dart';
import 'package:urban_hunt/form/custom_text_field.dart';
import 'package:urban_hunt/services/auth_service.dart';
import 'package:urban_hunt/services/user_service.dart';
import 'package:urban_hunt/widget/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = '';
  String _phone = '';
  String _email = '';
  String _password = '';

  bool _obscureText = true;

  bool _loading = false;

  bool isValidEmail(String email) {
    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegExp.hasMatch(email);
  }

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() => _loading = true);

      await _authService.register(_email, _password);

      await _userService.createUser(_name, _email, _phone);

      if (!mounted) return;

      Navigator.pushNamed(context, '/');
    } on FirebaseAuthException catch (error) {
      String message;

      if (error.code == 'email-already-in-use') {
        message = 'Invalid email or password.';
      } else if (error.code == 'invalid-email') {
        message = 'Invalid email address.';
      } else if (error.code == 'weak-password') {
        message = 'Password is too weak.';
      } else {
        message = 'Something went wrong. Please try again.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong. Please try again.'),
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
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 48.0),
              Text(
                'Welcome to UrbanHunt!',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                'Create your account to continue.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 48.0),
              _nameInput(),
              const SizedBox(height: 16.0),
              _phoneInput(),
              const SizedBox(height: 16.0),
              _emailInput(),
              const SizedBox(height: 16.0),
              _passwordInput(),
              const SizedBox(height: 32.0),
              _login(),
              const Spacer(),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nameInput() {
    return CustomTextField(
      label: 'Name',
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onChanged: (String value) {
        _name = value;
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Name is required.';
        }

        return null;
      },
    );
  }

  Widget _phoneInput() {
    return CustomTextField(
      label: 'Phone Number',
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      onChanged: (String value) {
        _phone = value;
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Phone is required.';
        }

        return null;
      },
    );
  }

  Widget _emailInput() {
    return CustomTextField(
      label: 'Email Address',
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (String value) {
        _email = value;
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Email is required.';
        }

        if (!isValidEmail(value)) {
          return 'Invalid email address.';
        }

        return null;
      },
    );
  }

  Widget _passwordInput() {
    return CustomPasswordField(
      label: 'Password',
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      onChanged: (String value) {
        _password = value;
      },
      onTap: () {
        setState(() => _obscureText = !_obscureText);
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Password is required.';
        }

        return null;
      },
    );
  }

  Widget _login() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/register');
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account? ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextSpan(
              text: 'Login',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).primaryColor,
                fontVariations: [FontVariation.weight(500)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    return CustomButton(text: 'Register', loading: _loading, onTap: _onSubmit);
  }
}
