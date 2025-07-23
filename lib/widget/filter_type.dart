import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/provider/filter_provider.dart';

class FilterType extends StatelessWidget {
  const FilterType({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<FilterProvider, String?>(
      shouldRebuild: (previous, next) => previous != next,
      selector: (_, provider) => provider.type,
      builder: (_, type, __) {
        return Row(
          children: <Widget>[
            _item(context, 'For Rent', type == 'For Rent'),
            const SizedBox(width: 8.0),
            _item(context, 'For Sale', type == 'For Sale'),
          ],
        );
      },
    );
  }

  Widget _item(BuildContext context, String value, bool selected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<FilterProvider>().type = value;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).colorScheme.inverseSurface
                : Theme.of(context).colorScheme.surface,
            border: Border.all(
              width: 1.5,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: selected
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
