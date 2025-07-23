import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.selected,
    required this.label,
    required this.onTap,
    this.padding,
  });

  final bool selected;
  final String label;
  final void Function() onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
            padding ??
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.inverseSurface
              : Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.inverseSurface,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 15.0,
            color: selected
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
      ),
    );
  }
}
