class FavoriteModel {
  final String userId;
  final String propertyId;

  const FavoriteModel({required this.userId, required this.propertyId});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      userId: json['userId'] as String,
      propertyId: json['propertyId'] as String,
    );
  }
}
