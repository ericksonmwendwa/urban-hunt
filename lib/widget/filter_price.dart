import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/form/custom_text_field.dart';
import 'package:urban_hunt/provider/filter_provider.dart';

class FilterPrice extends StatelessWidget {
  FilterPrice({super.key});

  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Selector<FilterProvider, ({int? min, int? max})>(
      shouldRebuild: (prev, next) =>
          prev.min != next.min || prev.max != next.max,
      selector: (_, provider) => (
        min: provider.minPrice,
        max: provider.maxPrice,
      ),
      builder: (_, price, __) {
        if (price.min == null) {
          _minController.text = '';
        } else {
          _minController.text = price.min.toString();
        }

        if (price.max == null) {
          _maxController.text = '';
        } else {
          _maxController.text = price.max.toString();
        }

        return Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(
                child: CustomTextField(
                  controller: _minController,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: false,
                    decimal: false,
                  ),
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      context.read<FilterProvider>().minPrice = null;
                    } else {
                      context.read<FilterProvider>().minPrice =
                          int.parse(value);
                    }
                  },
                  label: 'Min',
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: CustomTextField(
                controller: _maxController,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: false,
                  decimal: false,
                ),
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  if (value.isEmpty) {
                    context.read<FilterProvider>().maxPrice = null;
                  } else {
                    context.read<FilterProvider>().maxPrice = int.parse(value);
                  }
                },
                label: 'Max',
              ),
            ),
          ],
        );
      },
    );
  }
}
