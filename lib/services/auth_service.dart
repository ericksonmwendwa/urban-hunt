import 'package:firebase_auth/firebase_auth.dart';
import 'package:urban_hunt/models/auth_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthModel? _userFromFirebase(User? user) {
    if (user == null) return null;

    return AuthModel(uid: user.uid, email: user.email ?? '');
  }

  Stream<AuthModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<AuthModel> login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return _userFromFirebase(result.user)!;
  }

  Future<AuthModel> register(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return _userFromFirebase(result.user)!;
  }

  Future<dynamic> checkPassword(String currentPassword) async {
    final User? user = _auth.currentUser;

    if (user == null) return null;

    final AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    return await user.reauthenticateWithCredential(credential);
  }

  Future<dynamic> updatePassword(String newPassword) async {
    final User? user = _auth.currentUser;

    if (user == null) return null;

    return await user.updatePassword(newPassword);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
