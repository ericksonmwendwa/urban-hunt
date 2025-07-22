import 'package:flutter/material.dart';
import 'package:urban_hunt/widget/loading_icon.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.loading = false,
    this.icon,
    required this.onTap,
  });

  final String text;
  final bool? loading;
  final IconData? icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: loading == true
            ? Center(
                child: LoadingIcon(
                  color: Theme.of(context).colorScheme.surface,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (icon != null) ...[
                    Icon(icon!, color: Theme.of(context).colorScheme.surface),
                    const SizedBox(width: 8.0),
                  ],
                  Text(
                    text.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      letterSpacing: 0.5,
                      color: Theme.of(context).colorScheme.surface,
                      fontVariations: const <FontVariation>[
                        FontVariation.weight(500),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
