import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:urban_hunt/models/property_model.dart';
import 'package:urban_hunt/widget/loading_icon.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key, required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: <Widget>[
            _image(),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                children: <Widget>[
                  _header(context),
                  const SizedBox(height: 12.0),
                  _details(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image() {
    return SizedBox(
      width: 92.0,
      height: 92.0,
      child: CachedNetworkImage(
        imageUrl:
            'https://ik.imagekit.io/myriadlista/properties/${property.id}/${property.coverImage}',
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return const Center(child: LoadingIcon());
        },
        errorWidget: (context, url, error) {
          return const Center(child: Icon(Icons.error_rounded));
        },
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Text(
            property.type.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 12.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 6.0),
        const Text('•'),
        const SizedBox(width: 6.0),
        Text(
          property.category.toUpperCase(),
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontVariations: <FontVariation>[FontVariation.weight(500)],
          ),
        ),
      ],
    );
  }

  Widget _details(BuildContext context) {
    String bedrooms =
        '${property.bedrooms} bed${property.bedrooms > 1 ? 's' : ''}';

    String bathrooms =
        '${property.bathrooms} bath${property.bathrooms > 1 ? 's' : ''}';

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _item(context, bedrooms, Icons.hotel_rounded),
            _item(context, bathrooms, Icons.bathtub_rounded),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _item(context, property.yearBuilt.toString(), Icons.event_rounded),
            _item(
              context,
              '${property.area.toStringAsFixed(0)} m²',
              Icons.square_foot_rounded,
            ),
          ],
        ),
      ],
    );
  }

  Widget _item(BuildContext context, String value, IconData icon) {
    return Flexible(
      child: Row(
        children: <Widget>[
          Icon(icon, size: 16.0),
          const SizedBox(width: 8.0),
          Text(value, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
