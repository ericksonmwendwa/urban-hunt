import 'package:flutter/material.dart';
import 'package:urban_hunt/services/auth_service.dart';
import 'package:urban_hunt/widget/custom_button.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logout')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Are you sure you want to logout?',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16.0),
              Text(
                'You will need to sign in again to continue.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              CustomButton(
                text: 'Logout',
                onTap: () {
                  AuthService().logout();

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/splash',
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
