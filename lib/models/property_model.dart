import 'package:urban_hunt/models/location_model.dart';

class PropertyModel {
  const PropertyModel({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.category,
    required this.price,
    required this.coverImage,
    required this.listing,
    required this.lister,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.yearBuilt,
    required this.location,
    required this.amenities,
    required this.imageUrls,
  });

  final String id;
  final String name;
  final String description;
  final String type;
  final String category;
  final String coverImage;
  final String listing;
  final String lister;
  final int price;
  final int bedrooms;
  final int bathrooms;
  final int area;
  final int yearBuilt;
  final LocationModel location;
  final List<dynamic> amenities;
  final List<dynamic> imageUrls;

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      category: json['category'] as String,
      price: json['price'] as int,
      coverImage: (json['coverImage'] as Map<String, dynamic>)['url'] as String,
      listing: json['listing'] as String,
      lister: json['lister'] as String,
      bedrooms: json['bedrooms'] as int,
      bathrooms: json['bathrooms'] as int,
      area: json['area'] as int,
      yearBuilt: json['yearBuilt'] as int,
      location: LocationModel.fromJson(json['location']),
      amenities: List<dynamic>.from(json['amenities'] ?? []),
      imageUrls: List<dynamic>.from(json['imageUrls'] ?? []),
    );
  }
}
