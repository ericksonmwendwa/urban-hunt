class UserModel {
  final String id;
  final String email;
  final String name;
  final String phone;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
  });

  UserModel copyWith({String? name, String? phone}) {
    return UserModel(
      id: id,
      email: email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
    );
  }
}
