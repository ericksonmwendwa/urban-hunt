import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:urban_hunt/form/custom_password_field.dart';
import 'package:urban_hunt/form/custom_text_field.dart';
import 'package:urban_hunt/services/auth_service.dart';
import 'package:urban_hunt/widget/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

      await _authService.login(_email, _password);

      if (!mounted) return;

      Navigator.pushNamed(context, '/');
    } on FirebaseAuthException catch (error) {
      String message;

      if (error.code == 'invalid-credential') {
        message = 'Invalid email or password.';
      } else if (error.code == 'user-not-found') {
        message = 'User not found.';
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
                'Welcome back!',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                'We are happy to see you again.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 48.0),
              _emailInput(),
              const SizedBox(height: 16.0),
              _passwordInput(),
              const SizedBox(height: 32.0),
              _register(),
              const Spacer(),
              _loginButton(),
            ],
          ),
        ),
      ),
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
    );
  }

  Widget _register() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/register');
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account? ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextSpan(
              text: 'Register',
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

  Widget _loginButton() {
    return CustomButton(text: 'Login', loading: _loading, onTap: _onSubmit);
  }
}
