import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:urban_hunt/models/favorite_model.dart';
import 'package:urban_hunt/models/property_model.dart';

class FavoriteService {
  final String userId;
  final String propertyId;

  FavoriteService({required this.userId, required this.propertyId});

  CollectionReference<Object?> favoritesCollection = FirebaseFirestore.instance
      .collection('favorites');

  CollectionReference<Object?> propertiesCollection = FirebaseFirestore.instance
      .collection('properties');

  Future<void> likeProperty() async {
    final DocumentSnapshot<Object?> propertyDoc = await propertiesCollection
        .doc(propertyId)
        .get();

    if (propertyDoc.exists) {
      final QuerySnapshot<Object?> likeDoc = await favoritesCollection
          .where('userId', isEqualTo: userId)
          .where('propertyId', isEqualTo: propertyId)
          .limit(1)
          .get();

      if (likeDoc.docs.isEmpty) {
        favoritesCollection.add(<String, String?>{
          'userId': userId,
          'propertyId': propertyId,
        });
      } else {
        final DocumentSnapshot<Object?> docSnapshot = likeDoc.docs.first;
        final DocumentReference<Object?> docRef = docSnapshot.reference;
        await docRef.delete();
      }

      int likeCount = propertyDoc['likeCount'] as int;
      likeCount += likeDoc.docs.isEmpty ? 1 : -1;
      propertyDoc.reference.update(<String, int>{'likeCount': likeCount});
    }
  }

  Stream<List<FavoriteModel>> getFavorites() {
    return favoritesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FavoriteModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<PropertyModel>?> get favoritesProperties {
    return favoritesCollection
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (QuerySnapshot<Object?> event) => event.docs
              .map((QueryDocumentSnapshot<Object?> e) => e['property_id'])
              .toList(),
        )
        .asyncExpand((List<dynamic> pids) {
          if (pids.isNotEmpty) {
            return propertiesCollection
                .where(FieldPath.documentId, whereIn: pids)
                .snapshots()
                .map((snapshot) {
                  return snapshot.docs.map((doc) {
                    return PropertyModel.fromJson(
                      doc.data() as Map<String, dynamic>,
                    );
                  }).toList();
                });
          } else {
            return Stream<List<PropertyModel>?>.value(<PropertyModel>[]);
          }
        });
  }
}
