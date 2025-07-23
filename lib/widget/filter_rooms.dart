import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/provider/filter_provider.dart';

class FilterRooms extends StatelessWidget {
  const FilterRooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<FilterProvider, ({int? beds, int? baths})>(
      shouldRebuild: (previous, next) => previous != next,
      selector: (_, provider) => (beds: provider.beds, baths: provider.baths),
      builder: (_, rooms, __) {
        return Column(
          children: <Widget>[
            _item(context, 'Beds', rooms.beds ?? 0, true),
            const SizedBox(height: 8.0),
            _item(context, 'Baths', rooms.baths ?? 0, false),
          ],
        );
      },
    );
  }

  Widget _item(BuildContext context, String label, int value, bool beds) {
    return Row(
      children: <Widget>[
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        const Spacer(),
        GestureDetector(
          onTap: () {
            int? setValue = value - 1;
            if (setValue == 0) {
              setValue = null;
            }

            if (beds && value > 0) {
              context.read<FilterProvider>().beds = setValue;
            } else if (!beds && value > 0) {
              context.read<FilterProvider>().baths = setValue;
            }
          },
          child: _control(
            context,
            Icons.remove_circle_rounded,
            Theme.of(context).disabledColor,
          ),
        ),
        const SizedBox(width: 12.0),
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
        const SizedBox(width: 12.0),
        GestureDetector(
          onTap: () {
            int? setValue = value + 1;
            if (setValue == 0) {
              setValue = null;
            }

            if (beds && value < 20) {
              context.read<FilterProvider>().beds = setValue;
            } else if (!beds && value < 20) {
              context.read<FilterProvider>().baths = setValue;
            }
          },
          child: _control(
            context,
            Icons.add_circle_rounded,
            Theme.of(context).colorScheme.inverseSurface,
          ),
        ),
      ],
    );
  }

  Widget _control(BuildContext context, IconData icon, Color color) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Center(
        child: Icon(icon, color: Theme.of(context).colorScheme.surface),
      ),
    );
  }
}
