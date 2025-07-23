import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/models/user_model.dart';
import 'package:urban_hunt/provider/user_provider.dart';
import 'package:urban_hunt/widget/loading_icon.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel? user = context.watch<UserProvider>().user;

    if (user == null) {
      return Center(child: LoadingIcon());
    }

    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.inverseSurface,
                width: 2.0,
              ),
              shape: BoxShape.circle,
            ),
            child: Image.asset('assets/images/user.png'),
          ),
          const SizedBox(height: 12.0),
          Text(
            user.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 4.0),
          Text(
            user.email,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
