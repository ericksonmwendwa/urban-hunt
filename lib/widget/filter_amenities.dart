import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/provider/filter_provider.dart';
import 'package:urban_hunt/widget/custom_chip.dart';

class FilterAmenities extends StatelessWidget {
  FilterAmenities({super.key});

  final List<String> _amenities = <String>[
    'AirCon',
    'Ensuite',
    'Furnished',
    'Internet',
    'Pool',
    'Generator',
    'Parking',
    'Elevator',
    'CCTV',
  ];

  @override
  Widget build(BuildContext context) {
    return Selector<FilterProvider, List<String>>(
      selector: (_, provider) => provider.amenities,
      builder: (_, amenities, __) {
        return Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _amenities.map((String amenity) {
            return CustomChip(
              selected: amenities.contains(amenity),
              label: amenity,
              onTap: () {
                context.read<FilterProvider>().setAmenities(amenity);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
