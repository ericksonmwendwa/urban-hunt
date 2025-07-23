import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/config/router.dart';
import 'package:urban_hunt/config/theme.dart';
import 'package:urban_hunt/firebase_options.dart';
import 'package:urban_hunt/models/auth_model.dart';
import 'package:urban_hunt/provider/filter_provider.dart';
import 'package:urban_hunt/provider/user_provider.dart';
import 'package:urban_hunt/screens/app_screen.dart';
import 'package:urban_hunt/screens/splash_screen.dart';
import 'package:urban_hunt/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<AuthModel?>.value(
          value: AuthService().user,
          initialData: null,
        ),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider<FilterProvider>(create: (_) => FilterProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const AuthWrapper(),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthModel? user = Provider.of<AuthModel?>(context);

    if (user == null) {
      return const SplashScreen();
    } else {
      return const AppScreen();
    }
  }
}
