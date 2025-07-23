import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urban_hunt/models/property_model.dart';

class PropertyService {
  final CollectionReference propertiesCollection = FirebaseFirestore.instance
      .collection('properties');

  Future<List<PropertyModel>> fetchProperties() async {
    final List<PropertyModel> properties = <PropertyModel>[];

    await propertiesCollection.get().then((QuerySnapshot<Object?> snapshot) {
      for (final QueryDocumentSnapshot<Object?> doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        data['id'] = doc.id;

        properties.add(PropertyModel.fromJson(data));
      }
    });

    return properties;
  }

  Stream<List<PropertyModel>> getProperties({
    required int perPage,
    required bool loadMore,
    required String sortBy,
    required Map<String, dynamic> filters,
  }) {
    Query query = propertiesCollection;

    if (filters['category'] != null) {
      query = query.where('category', isEqualTo: filters['category']);
    }

    if (filters['type'] != null) {
      query = query.where('type', isEqualTo: filters['type']);
    }

    if (filters['minPrice'] != null) {
      query = query.where('price', isGreaterThanOrEqualTo: filters['minPrice']);
    }

    if (filters['maxPrice'] != null) {
      query = query.where('price', isLessThanOrEqualTo: filters['maxPrice']);
    }

    if (filters['bedrooms'] != null) {
      query = query.where('bedrooms', isEqualTo: filters['bedrooms']);
    }

    if (filters['bathrooms'] != null) {
      query = query.where('bathrooms', isEqualTo: filters['bathrooms']);
    }

    if (filters['listing'] != null) {
      query = query.where('listing', isEqualTo: filters['listing']);
    }

    if (filters['amenities'] != null) {
      final amenities = filters['amenities'];
      if (amenities is List && amenities.isNotEmpty) {
        query = query.where('amenities', arrayContainsAny: amenities);
      }
    }

    // Pagination
    query = query.limit(perPage);

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        data['id'] = doc.id;

        return PropertyModel.fromJson(data);
      }).toList();
    });
  }
}
