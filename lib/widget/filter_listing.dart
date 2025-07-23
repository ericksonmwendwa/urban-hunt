import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/provider/filter_provider.dart';
import 'package:urban_hunt/widget/custom_chip.dart';

class FilterListing extends StatelessWidget {
  FilterListing({super.key});

  final List<String> _listings = <String>['Owner', 'Agent'];

  @override
  Widget build(BuildContext context) {
    return Selector<FilterProvider, String?>(
      selector: (_, provider) => provider.listing,
      builder: (_, selected, __) {
        return Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _listings.map((String listing) {
            return CustomChip(
              selected: selected == listing,
              label: listing,
              onTap: () {
                context.read<FilterProvider>().listing = listing;
              },
            );
          }).toList(),
        );
      },
    );
  }
}
