import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:urban_hunt/models/user_model.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference usersCollection = FirebaseFirestore.instance
      .collection('users');

  Future<void> updateProfile(String name, String phone) async {
    final String? uid = _auth.currentUser?.uid;

    if (uid == null) return;

    await usersCollection.doc(uid).update({'name': name, 'phone': phone});
  }

  Future<UserModel?> getUser() async {
    final String? uid = _auth.currentUser?.uid;

    if (uid == null) return null;

    final Map<String, dynamic> user = await usersCollection.doc(uid).get().then(
      (DocumentSnapshot<Object?> doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        data['id'] = doc.id;

        return data;
      },
    );

    return UserModel.fromJson(user);
  }

  Future<void> createUser(String name, String email, String phone) async {
    final String? uid = _auth.currentUser?.uid;

    if (uid == null) return;

    Map<String, dynamic> user = <String, dynamic>{
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await usersCollection.doc(uid).set(user);
  }
}
