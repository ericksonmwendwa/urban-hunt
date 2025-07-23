import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/models/favorite_model.dart';
import 'package:urban_hunt/models/property_model.dart';
import 'package:urban_hunt/provider/user_provider.dart';
import 'package:urban_hunt/services/favorite_service.dart';
import 'package:urban_hunt/widget/favorite_button.dart';

class PropertyWidget extends StatelessWidget {
  const PropertyWidget({super.key, required this.property});

  final PropertyModel property;

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat.currency(
      symbol: 'KES ',
      decimalDigits: 0,
    );

    final String userId = context.read<UserProvider>().user?.id ?? '';
    final String propertyId = property.id;

    return StreamProvider<List<FavoriteModel>?>.value(
      initialData: const <FavoriteModel>[],
      value: FavoriteService().getFavorites(),
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          children: <Widget>[
            Container(
              height: 260,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    'https://ik.imagekit.io/myriadlista/properties/$propertyId/${property.coverImage}',
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            Positioned.fill(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: const LinearGradient(
                    colors: <Color>[Colors.black38, Colors.black38],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: <double>[0.1, 1.0],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _header(context, userId, propertyId),
                    _details(formatter, context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _details(NumberFormat formatter, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 10.0),
        Text(
          '${formatter.format(property.price)} ${property.type == 'For Rent' ? '/mo' : ''} ',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Icon(
              Icons.location_pin,
              size: 20.0,
              color: Theme.of(context).colorScheme.surface,
            ),
            Expanded(
              child: Text(
                ' ${property.location.address}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Text(
              '${property.bedrooms} bed${property.bedrooms > 1 ? 's' : ''}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '/',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '${property.bathrooms} bath${property.bathrooms > 1 ? 's' : ''}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '/',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '${property.area} m²',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _header(BuildContext context, String userId, String propertyId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              property.category.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            const SizedBox(width: 7.5),
            Text(
              '•',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            const SizedBox(width: 7.5),
            Text(
              property.type.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ],
        ),
        FavoriteButton(userId: userId, propertyId: propertyId),
      ],
    );
  }
}
