import 'package:flutter/foundation.dart';

class FilterProvider extends ChangeNotifier {
  String _sortBy = 'default';
  String get sortBy => _sortBy;
  set sortBy(String sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  // category
  String? _category;
  String? get category => _category;
  set category(String? category) {
    if (_category == category) {
      _category = null;
    } else {
      _category = category;
    }

    notifyListeners();
  }

  // type
  String? _type;
  String? get type => _type;
  set type(String? value) {
    if (_type == value) {
      _type = null;
    } else {
      _type = value;
    }

    notifyListeners();
  }

  // beds
  int? _beds;
  int? get beds => _beds;
  set beds(int? beds) {
    _beds = beds;
    notifyListeners();
  }

  // baths
  int? _baths;
  int? get baths => _baths;
  set baths(int? baths) {
    _baths = baths;
    notifyListeners();
  }

  // price
  int? _minPrice;
  int? get minPrice => _minPrice;
  set minPrice(int? minPrice) {
    _minPrice = minPrice;
    notifyListeners();
  }

  int? _maxPrice;
  int? get maxPrice => _maxPrice;
  set maxPrice(int? maxPrice) {
    _maxPrice = maxPrice;
    notifyListeners();
  }

  String? _listing;
  String? get listing => _listing;
  set listing(String? value) {
    if (_listing == value) {
      _listing = null;
    } else {
      _listing = value;
    }

    notifyListeners();
  }

  // amenities
  List<String> _amenities = <String>[];
  List<String> get amenities => _amenities;
  void setAmenities(String amenity) {
    if (_amenities.contains(amenity)) {
      _amenities = _amenities.where((a) => a != amenity).toList();
    } else {
      _amenities = [..._amenities, amenity];
    }

    notifyListeners();
  }

  Map<String, dynamic> get filters {
    Map<String, dynamic> filters = {};

    if (_category != null) {
      filters['category'] = _category;
    }

    if (_type != null) {
      filters['type'] = _type;
    }

    if (_beds != null) {
      filters['bedrooms'] = _beds;
    }

    if (_baths != null) {
      filters['bathrooms'] = _baths;
    }

    if (_minPrice != null) {
      filters['minPrice'] = _minPrice;
    }

    if (_maxPrice != null) {
      filters['maxPrice'] = _maxPrice;
    }

    if (_listing != null) {
      filters['listing'] = _listing;
    }

    if (_amenities.isNotEmpty) {
      filters['amenities'] = _amenities;
    }

    return filters;
  }

  void resetFilters() {
    _category = null;
    _type = null;
    _beds = null;
    _baths = null;
    _minPrice = null;
    _maxPrice = null;
    _listing = null;
    _amenities = [];

    notifyListeners();
  }
}
