import 'package:flutter/material.dart';
import 'package:urban_hunt/widget/profile_header.dart';
import 'package:urban_hunt/widget/profile_link.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ProfileHeader(),
          const SizedBox(height: 48.0),
          _account(context),
          const SizedBox(height: 48.0),
          _resources(context),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }

  Widget _account(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Account'.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).disabledColor,
          ),
        ),
        const SizedBox(height: 12.0),
        const ProfileLink(
          link: 'edit',
          label: 'Edit Profile',
          icon: Icons.edit_square,
        ),
        const SizedBox(height: 12.0),
        const ProfileLink(
          link: 'password',
          label: 'Change Password',
          icon: Icons.lock_rounded,
        ),
        const SizedBox(height: 12.0),
        const ProfileLink(
          link: 'logout',
          label: 'Logout',
          icon: Icons.logout_rounded,
        ),
      ],
    );
  }

  Widget _resources(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Resources'.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).disabledColor,
          ),
        ),
        const SizedBox(height: 12.0),
        const ProfileLink(
          outlink: true,
          link: 'help-center',
          label: 'Help Center',
          icon: Icons.help_center_rounded,
        ),
        const SizedBox(height: 12.0),
        const ProfileLink(
          outlink: true,
          link: 'privacy-policy',
          label: 'Privacy Policy',
          icon: Icons.privacy_tip_rounded,
        ),
        const SizedBox(height: 12.0),
        const ProfileLink(
          outlink: true,
          link: 'terms-of-use',
          label: 'Terms of Use',
          icon: Icons.lock_clock_rounded,
        ),
      ],
    );
  }
}
