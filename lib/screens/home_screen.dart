import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/models/property_model.dart';
import 'package:urban_hunt/screens/filter_screen.dart';
import 'package:urban_hunt/services/property_service.dart';
import 'package:urban_hunt/widget/loading_icon.dart';
import 'package:urban_hunt/widget/property_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PropertyService _propertyService = PropertyService();

  Map<String, dynamic> _filters = <String, dynamic>{};
  int perPage = 20;
  bool loadMore = false;

  final String _sortBy = 'default';

  List<String> keysToInclude = [
    'type',
    'category',
    'bedrooms',
    'bathrooms',
    'listing',
  ];

  List<MapEntry<String, String>> _currentFilters = <MapEntry<String, String>>[];

  Future<void> _filterProperties() async {
    Map<String, dynamic>? filters = await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (context) {
        return const FilterScreen();
      },
    );

    if (filters != null) {
      Map<String, String> filteredMap = {};

      for (var key in keysToInclude) {
        if (filters.containsKey(key)) {
          filteredMap[key] = filters[key].toString();
        }
      }

      setState(() {
        _filters = filters;
        _currentFilters = filteredMap.entries.toList();
      });
    }
  }

  String _getValue(String key, String value) {
    if (key == 'bedrooms') {
      return '$value Bed';
    }

    if (key == 'bathrooms') {
      return '$value Bath';
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _header(),
        const SizedBox(height: 12.0),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _properties(),
          ),
        ),
      ],
    );
  }

  Widget _properties() {
    return StreamProvider<List<PropertyModel>?>.value(
      value: _propertyService.getProperties(
        perPage: perPage,
        loadMore: loadMore,
        sortBy: _sortBy,
        filters: _filters,
      ),
      initialData: null,
      catchError: (context, error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.redAccent,
          ),
        );

        return null;
      },
      builder: (BuildContext context, Widget? child) {
        List<PropertyModel>? properties = context.watch<List<PropertyModel>?>();

        if (properties == null) {
          return const Center(child: LoadingIcon());
        }

        if (properties.isEmpty) {
          return const Center(child: Text('No properties found'));
        }

        return ListView.separated(
          itemCount: properties.length,
          itemBuilder: (context, index) {
            final PropertyModel property = properties[index];

            return PropertyWidget(property: property);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16.0);
          },
        );
      },
    );
  }

  Widget _header() {
    return Row(
      children: <Widget>[
        Expanded(child: _filtered()),
        const SizedBox(width: 12.0),
        GestureDetector(
          onTap: _filterProperties,
          child: Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                width: 2.0,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Icon(
                Icons.filter_list_rounded,
                size: 18.0,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
      ],
    );
  }

  Widget _filtered() {
    if (_currentFilters.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(
          'No Filters Selected',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return SizedBox(
      height: 44.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _currentFilters.length,
        itemBuilder: (context, index) {
          final filter = _currentFilters[index];

          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: _filterChip(index, filter.key, filter.value),
            );
          }

          return _filterChip(index, filter.key, filter.value);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8.0);
        },
      ),
    );
  }

  Widget _filterChip(int index, String key, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentFilters.removeAt(index);
          _filters.remove(key);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: <Widget>[
            Text(
              _getValue(key, value),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 8.0),
            const Icon(Icons.close_rounded, size: 18.0),
          ],
        ),
      ),
    );
  }
}
