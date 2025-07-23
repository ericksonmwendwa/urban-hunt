import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/models/favorite_model.dart';
import 'package:urban_hunt/models/property_model.dart';
import 'package:urban_hunt/provider/user_provider.dart';
import 'package:urban_hunt/screens/gallery_screen.dart';
import 'package:urban_hunt/services/favorite_service.dart';
import 'package:urban_hunt/widget/favorite_button.dart';
import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    final Uri googleMapUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
    );
    if (await canLaunchUrl(googleMapUrl)) {
      await launchUrl(
        googleMapUrl,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } else {
      throw Exception('Could not open the map.');
    }
  }
}

class PropertyScreen extends StatefulWidget {
  const PropertyScreen({super.key, required this.property});

  final PropertyModel property;

  @override
  State<PropertyScreen> createState() => _PropertyScreenState();
}

class _PropertyScreenState extends State<PropertyScreen> {
  final FavoriteService _favoriteService = FavoriteService();

  NumberFormat formatter = NumberFormat.currency(
    symbol: 'KES ',
    decimalDigits: 0,
  );

  bool _isExpanded = false;

  Map<String, String> features = <String, String>{
    'AirCon': 'Air-Conditioning',
    'Ensuite': 'Ensuite',
    'Furnished': 'Furnished',
    'Pool': 'Swimming Pool',
    'Internet': 'Fiber / WiFi Internet',
    'Generator': 'Backup Generator',
    'Balcony': 'Balcony',
    'Parking': 'Parking',
    'Elevator': 'Elevator',
    'CCTV': 'CCTV',
  };

  @override
  Widget build(BuildContext context) {
    final String userId = context.read<UserProvider>().user?.id ?? '';

    final PropertyModel property = widget.property;

    final String description = property.description;
    final List<dynamic> amenities = property.amenities;

    return StreamProvider<List<FavoriteModel>?>.value(
      initialData: const <FavoriteModel>[],
      value: _favoriteService.getFavorites(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    _image(property),
                    _actions(userId, property),
                  ],
                ),
                const SizedBox(height: 32.0),
                _nameAndLocation(property),
                const SizedBox(height: 30.0),
                _description(description),
                const SizedBox(height: 30.0),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(18.0),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 3),
                        blurRadius: 7.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Details',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _item(
                            'Type',
                            property.type,
                            CrossAxisAlignment.start,
                          ),
                          _item(
                            'Bed(s)',
                            property.bedrooms.toString(),
                            CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _item(
                            'Category',
                            property.category,
                            CrossAxisAlignment.start,
                          ),
                          _item(
                            'Bath(s)',
                            property.bathrooms.toString(),
                            CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _item(
                            'Price',
                            '${formatter.format(property.price)} ${property.type == 'For Rent' ? '/mo' : ''}',
                            CrossAxisAlignment.start,
                          ),
                          _item(
                            'Area (m²)',
                            '${property.area}',
                            CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          _item(
                            'Listing',
                            property.listing == 'Owner'
                                ? 'Owner'
                                : 'Agent / Agency',
                            CrossAxisAlignment.start,
                          ),
                          _item(
                            'Year Built',
                            '${property.yearBuilt}',
                            CrossAxisAlignment.end,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                _amenities(context, amenities),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _image(PropertyModel property) {
    return Container(
      height: 280.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            'https://ik.imagekit.io/myriadlista/properties/${property.id}/${property.coverImage}',
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 3),
            blurRadius: 7.0,
          ),
        ],
      ),
    );
  }

  Widget _actions(String userId, PropertyModel property) {
    return Container(
      height: 280.0,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Icon(Icons.arrow_back_rounded),
                  ),
                ),
                Container(
                  height: 50.0,
                  width: 50.0,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 3.0),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: FavoriteButton(
                    userId: userId,
                    propertyId: property.id,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) {
                        return GalleryScreen(images: property.imageUrls);
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.image_rounded, size: 20.0),
                label: Text(
                  ' Photos',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  MapUtils.openMap(
                    property.location.coordinates.lat,
                    property.location.coordinates.lng,
                  );
                },
                icon: const Icon(Icons.share_location_rounded, size: 24.0),
                label: Text(
                  'Map',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _nameAndLocation(PropertyModel property) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 3),
            blurRadius: 7.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(property.name, style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 12.0),
          Row(
            children: <Widget>[
              Icon(Icons.location_pin, size: 24.0),
              Expanded(
                child: Text(
                  ' ${property.location.address}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _description(String description) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 3),
            blurRadius: 7.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Description', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 8.0),
          Text(
            _isExpanded
                ? description
                : (description.length > 200
                      ? '${description.substring(0, 200)} ...'
                      : description),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          if (description.length > 200)
            Container(
              margin: const EdgeInsets.only(top: 12.0),
              alignment: Alignment.bottomRight,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                icon: Icon(
                  _isExpanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  size: 28.0,
                ),
                label: Text(
                  _isExpanded ? 'Show less' : 'Read more',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
            )
          else
            Container(),
        ],
      ),
    );
  }

  Widget _amenities(BuildContext context, List<dynamic> amenities) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18.0),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 3),
            blurRadius: 7.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Amenities', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            children: <Widget>[
              for (dynamic amenity in amenities)
                if (features.containsKey(amenity))
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      '${features[amenity]}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _item(String label, String value, CrossAxisAlignment alignment) {
    return Column(
      crossAxisAlignment: alignment,
      children: <Widget>[
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).disabledColor,
            fontVariations: <FontVariation>[FontVariation.weight(500)],
          ),
        ),
        const SizedBox(height: 5.0),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
