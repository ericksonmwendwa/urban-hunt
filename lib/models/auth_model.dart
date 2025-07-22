class AuthModel {
  final String uid;
  final String email;

  const AuthModel({required this.uid, required this.email});

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(uid: map['uid'], email: map['email']);
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email};
  }

  factory AuthModel.fromFirebaseUser(dynamic user) {
    return AuthModel(uid: user.uid, email: user.email ?? '');
  }
}
