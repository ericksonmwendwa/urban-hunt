import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/provider/filter_provider.dart';
import 'package:urban_hunt/widget/custom_button.dart';
import 'package:urban_hunt/widget/filter_amenities.dart';
import 'package:urban_hunt/widget/filter_category.dart';
import 'package:urban_hunt/widget/filter_listing.dart';
import 'package:urban_hunt/widget/filter_price.dart';
import 'package:urban_hunt/widget/filter_rooms.dart';
import 'package:urban_hunt/widget/filter_type.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 16.0),
          _header(context),
          const SizedBox(height: 16.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const FilterType(),
                  const SizedBox(height: 28.0),
                  _title(context, 'Property Type'),
                  const SizedBox(height: 2.0),
                  FilterCategory(),
                  const SizedBox(height: 28.0),
                  _title(context, 'Price Range'),
                  FilterPrice(),
                  const SizedBox(height: 28.0),
                  _title(context, 'No. of Rooms'),
                  const SizedBox(height: 2.0),
                  const FilterRooms(),
                  const SizedBox(height: 28.0),
                  _title(context, 'Listed By'),
                  const SizedBox(height: 2.0),
                  FilterListing(),
                  const SizedBox(height: 28.0),
                  _title(context, 'Featured Amenities'),
                  const SizedBox(height: 2.0),
                  FilterAmenities(),
                  const SizedBox(height: 48.0),
                  _footer(context),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: Theme.of(context).disabledColor,
          ),
        ),
        const SizedBox(height: 6.0),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.inverseSurface,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Icon(
                Icons.close_rounded,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
          ),
        ),
        const Spacer(),
        Text('Filters', style: Theme.of(context).textTheme.displayMedium),
        const Spacer(),
        const SizedBox(width: 48.0),
      ],
    );
  }

  Widget _footer(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomButton(
            text: 'Reset',
            loading: false,
            onTap: () {
              context.read<FilterProvider>().resetFilters();
            },
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: CustomButton(
            text: 'Apply',
            onTap: () {
              Map<String, dynamic> filters = context
                  .read<FilterProvider>()
                  .filters;

              Navigator.pop(context, filters);
            },
          ),
        ),
      ],
    );
  }
}
