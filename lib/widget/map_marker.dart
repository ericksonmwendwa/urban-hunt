import 'package:flutter/material.dart';
import 'package:urban_hunt/config/colors.dart';

class MapMarker extends StatelessWidget {
  const MapMarker({super.key, required this.price});

  final String price;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: AppColors.primary,
            border: Border.all(color: Theme.of(context).colorScheme.surface),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            price,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.light,
              fontVariations: <FontVariation>[FontVariation.weight(500)],
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        Container(
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ],
    );
  }
}
