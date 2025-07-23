class LocationModel {
  final String address;
  final String county;
  final String streetAddress;
  final CoordinatesModel coordinates;

  const LocationModel({
    required this.address,
    required this.county,
    required this.streetAddress,
    required this.coordinates,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      address: json['address'] as String,
      county: json['county'] as String,
      streetAddress: json['street_address'] as String,
      coordinates: CoordinatesModel.fromJson(json['cordinates']),
    );
  }
}

class CoordinatesModel {
  final double lat;
  final double lng;

  const CoordinatesModel({required this.lat, required this.lng});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }
}
