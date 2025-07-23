import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/models/favorite_model.dart';
import 'package:urban_hunt/services/favorite_service.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    super.key,
    required this.userId,
    required this.propertyId,
  });

  final String userId;
  final String propertyId;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    final List<FavoriteModel>? myFavorites = Provider.of<List<FavoriteModel>?>(
      context,
    );

    final bool isFavorite = myFavorites!.any(
      (FavoriteModel favorite) => favorite.propertyId == widget.propertyId,
    );

    return LikeButton(
      circleSize: 30.0,
      isLiked: isFavorite,
      onTap: (bool bool) async {
        await FavoriteService(
          userId: widget.userId,
          propertyId: widget.propertyId,
        ).likeProperty();

        return true;
      },
      likeBuilder: (bool isFavorite) {
        return Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          size: 32.0,
          color: Theme.of(context).colorScheme.surface,
        );
      },
    );
  }
}
