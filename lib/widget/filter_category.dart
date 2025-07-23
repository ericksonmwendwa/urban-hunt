import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/provider/filter_provider.dart';
import 'package:urban_hunt/widget/custom_chip.dart';

class FilterCategory extends StatelessWidget {
  FilterCategory({super.key});

  final List<String> _categories = <String>[
    'Apartment',
    'Townhouse',
    'Single Family',
    'Condo',
    'Multi Family',
    'Villa',
  ];

  @override
  Widget build(BuildContext context) {
    return Selector<FilterProvider, String?>(
      selector: (_, provider) => provider.category,
      builder: (_, selected, __) {
        return Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _categories.map((String category) {
            return CustomChip(
              selected: selected == category,
              label: category,
              onTap: () {
                context.read<FilterProvider>().category = category;
              },
            );
          }).toList(),
        );
      },
    );
  }
}
