import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/models/property_model.dart';
import 'package:urban_hunt/services/favorite_service.dart';
import 'package:urban_hunt/widget/loading_icon.dart';
import 'package:urban_hunt/widget/property_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoriteService _favoriteService = FavoriteService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<PropertyModel>?>.value(
      value: _favoriteService.favoritesProperties,
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
        List<PropertyModel>? favorites = context.watch<List<PropertyModel>?>();

        if (favorites == null) {
          return const Center(child: LoadingIcon());
        }

        if (favorites.isEmpty) {
          return const Center(child: Text('No favorites found.'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16.0),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final PropertyModel property = favorites[index];

            return PropertyWidget(property: property);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16.0);
          },
        );
      },
    );
  }
}
